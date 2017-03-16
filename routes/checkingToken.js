var sequelize = require("./dbconfiguration").sequelize;
exports.isAuthorized = function(req, res) {
  console.log("inside token check");
  //Add exceptional case for login req.
  if (req.url == '/login') {
    //fetch excel file and convert them
    toJson.excelToJson();
    preDatabase.prejson_database();
    return true;
  } else {
    var responseToken = req.get('token');
    //To fetch the token from the token table.
    sequelize.query(" SELECT * FROM domo_token WHERE token = '" + responseToken + "' ", {
      type: sequelize.QueryTypes.SELECT
    }).then(function(results) {
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
          sequelize.query(" UPDATE domo_dsr_token SET expiryTime = from_unixtime('" + newExpTime + "') ", {
              type: sequelize.QueryTypes.UPDATE
            }).then(function(users) {})
            //Updating expiry time in userlog
          // sequelize.query(" UPDATE domo_dsr_userlogs SET expiryTime = from_unixtime('" + newExpTime + "') ", {
          //   type: sequelize.QueryTypes.UPDATE
          // }).then(function(users) {})
        }
        return true;
      }
      return false;
    })
  }
}
