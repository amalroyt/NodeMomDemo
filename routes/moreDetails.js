var sequelize = require("./dbconfiguration").sequelize;
exports.moreDetailsPoints = function(req, res) {
  var meetingId = req.get('meetingId');
  sequelize.query(" SELECT * FROM domo_meeting_points WHERE  meetingId= '" + meetingId + "' LIMIT 1", {
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

exports.moreDetailsAction = function(req, res) {
  var meetingId = req.get('meetingId');
  sequelize.query(" SELECT * FROM domo_meeting_action WHERE  meetingId= '" + meetingId + "' LIMIT 1", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    console.log(results);
    res.format({
      json: function() {
        res.send(results);
      }
    });
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
};
