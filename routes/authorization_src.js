var sequelize = require("./dbconfiguration").sequelize,
  jwt = require('jsonwebtoken');

exports.preAuthorization = function(req, res) {
  //Declaring and initializing variables
  var name = req.body.userName;
  var password = req.body.userPassword;
  var user;
  //Removing special characters from input credentials
  var newName = name.replace(/[^\w]/gi, '');
  var newPassword = password.replace(/[^\w@]/gi, '');

  //To check if the user is trying to do any undesired moves
  if ( newName === name && newPassword === password ) {
  //Use query method to get the data from sever
  sequelize.query(" SELECT * FROM domo_users WHERE userName = '" + name + "' AND password = '" + password + "' LIMIT 1 ", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    res.format({
      json: function() {
        //Checking if authorization is valid.
        if (results.length != 0) {
          user = results[0];
          //The secret key used to encode and decode token.
          var thesecret = "nosecrets";
          //Creating token using jwt
          var token = jwt.sign({
            userId: user.empId,
            admin: user.admin,
            exp: Math.floor(Date.now() / 1000) + 60 * 10,
            iat: Math.floor(Date.now() / 1000)
          }, thesecret);
          var isAdmin;
          if ( results[0].role == 3 ) {
            isAdmin = true;
          }
          else {
            isAdmin = false;
          }
          /*Creating new token variable with the expiry parameter seperate
          so that the expiry parameter is not available client side.*/
          var newToken = {
              'token': token,
              'exp': Math.floor(Date.now() / 1000) + 60 * 10,
              'userDetails': [{'firstName':results[0].firstName,'lastName':results[0].lastName,'isAdmin':isAdmin, 'userId':results[0].id}]
            }
            //Insert values into token table.
          sequelize.query("INSERT INTO domo_token (token,expiryTime) VALUES ('" + newToken.token + "', from_unixtime('" + newToken.exp + "'))", {
              type: sequelize.QueryTypes.INSERT
            }).then(function(users) {})
            //Insert values into userlog table.
          sequelize.query("INSERT INTO domo_userlogs (empId,role,date,loginTime,token) VALUES ('" + user.id + "', '" + user.role + "', curdate(), now(),'" + newToken.token + "') ", {
              type: sequelize.QueryTypes.INSERT
            }).then(function(users) {})
            //Setting token in the response.
          res.status(200).send(newToken);
        } else {
          res.status(401);
          res.send();
        }
      }
    });
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
}
else {
  res.status(401);
  res.send();
}
};

exports.preLogout = function(req, res) {
var token = req.body.token;
  sequelize.query("DELETE FROM domo_token WHERE TOKEN = '" + token + "' ", {
      type: sequelize.QueryTypes.DELETE
    }).then(function(users) {
        res.end();
    })
}

exports.postAuthorization = function(req, res) {
var userId = req.params.userId,
    isAdmin;
  sequelize.query("SELECT role FROM domo_users WHERE id = '" + userId + "' ", {
      type: sequelize.QueryTypes.SELECT
    }).then(function(results) {
        if (results[0].role == 3) {
          isAdmin = true;
        }
        else {
          isAdmin = false;
        }
        res.send(isAdmin);
    })
}
