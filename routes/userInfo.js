var sequelize = require("./dbconfiguration").sequelize;
exports.getUsername = function(req, res) {
  sequelize.query("SELECT domo_users.firstName AS userName FROM domo_userlogs INNER JOIN domo_users on domo_userlogs.userId = domo_users.id ORDER BY domo_userlogs.id DESC LIMIT 1", {
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
