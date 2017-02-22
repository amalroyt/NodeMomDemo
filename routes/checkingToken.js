var sequelize = require("./dbconfiguration").sequelize;

exports.isAuthorized = function(req, res) {
  //Add exceptional case for login req.
  var authPromise = new Promise ( function (resolve,reject) {
  if (req.url == '/login') {
    authPromise.resolve(true);
  } else {
    console.log("inside else");
    var responseToken = req.get('token');
    //To fetch the token from the token table.
    return sequelize.query(" SELECT * FROM domo_token WHERE token = '" + responseToken + "' ", {
      type: sequelize.QueryTypes.SELECT
    }).then(function(results) {
      //To check if the token is present in the token table.
      console.log(results.length, 'results' , results)
      if (results.length != 0) {
        //Creating variables currTime,expTime to fetch the current and expiry timestamp values in milliseconds.
        var currTime = Date.now();
        var expTime = Date.parse(results[0].expiryTime);
        //To check if token has expired or not.
        if (expTime > currTime) {
          //If the expiry time is less than 2 mins, refresh the expiry time to 10mins.
          if ((expTime - currTime) < 120000) {
            //Creating newExpTime with value 10 mins.
            var newExpTime = Math.floor(Date.now() / 1000) + 60 * 10;
            //Updating expiry time in token table
            sequelize.query(" UPDATE domo_token SET expiryTime = from_unixtime('" + newExpTime + "') ", {
                type: sequelize.QueryTypes.UPDATE
              }).then(function(users) {})
              //Updating expiry time in userlog
            sequelize.query(" UPDATE domo_userlogs SET expiryTime = from_unixtime('" + newExpTime + "') ", {
              type: sequelize.QueryTypes.UPDATE
            }).then(function(users) {})
          }
        }
        console.log('True Re');
        resolve(true);
      } else {
        console.log('False Re');
        reject("false");
      }
    })
  }
  });
}
