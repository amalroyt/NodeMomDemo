var sequelize = require("./dbconfiguration").sequelize;
exports.createUser = function(req, res) {
var user = req.body;
  sequelize.query(" INSERT INTO domo_users (empId,userName,emailId,firstName,lastName,password,role,active) VALUES ('" + user.empId + "', '" + user.userName + "', '" + user.emailId + "', '" + user.firstName + "', '" + user.lastName + "', '" + user.password + "', '" + user.role + "', 1 ) ", {
    type: sequelize.QueryTypes.INSERT
  }).then(function(results) {
    res.format({
      json: function() {
        res.end();
      }
    });
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
};

exports.getUserRoles = function(req, res) {
  sequelize.query(" SELECT id, role FROM domo_userroles ", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    res.format({
      json: function() {
        res.send(results);
      }
    });
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
};

 exports.checkUsername = function(req, res) {
  sequelize.query(" select COUNT(userName) as userCount FROM domo_users WHERE userName = '" + req.body.userName + "' ", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    res.format({
      json: function() {
        res.send(results);
      }
    });
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
 };
