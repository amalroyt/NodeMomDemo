var sequelize = require("./dbconfiguration").sequelize;
exports.deleteMeeting = function(req, res) {
var userId = req.params.userId;
var meetingIds = req.body.meetingIds;
  sequelize.query(" UPDATE domo_meeting_master SET active = 1 WHERE meetingId IN ("+ meetingIds +")", {
    type: sequelize.QueryTypes.UPDATE
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
