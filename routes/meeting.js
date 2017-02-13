var sequelize = require("./dbconfiguration").sequelize;
exports.meetingList = function(req, res) {
  sequelize.query(" SELECT * FROM domo_meeting_master", {
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
