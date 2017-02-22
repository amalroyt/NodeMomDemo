var sequelize = require("./dbconfiguration").sequelize;
exports.moreDetails = function(req, res) {
  var meetingId = req.params.meetingId;
  sequelize.query(" SELECT meetingTitle FROM domo_meeting_master WHERE meetingId = '" + meetingId + "'", {
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

exports.moreDetailsPoints = function(req, res) {
  var meetingId = req.params.meetingId;
  sequelize.query(" SELECT di.userName AS discussionBy,de.userName AS decisionBy,domo_discussion_type.discussionType,discussion,decision FROM domo_meeting_points inner join domo_users as de on domo_meeting_points.discussionBy = de.id inner join domo_users as di on domo_meeting_points.decisionBy = di.id INNER JOIN domo_discussion_type ON domo_meeting_points.discussionType = domo_discussion_type.id WHERE  meetingId= '" + meetingId + "'", {
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
  var meetingId = req.params.meetingId;
  sequelize.query(" SELECT domo_users.userName AS responsible,domo_meeting_status.status AS status,actionDesc,DATE_FORMAT(openSince, '%d/%m/%Y') as openSince,DATE_FORMAT(expectedCompletion, '%d/%m/%Y') as expectedCompletion,DATE_FORMAT(actualCompletion, '%d/%m/%Y') as actualCompletion FROM domo_meeting_action INNER JOIN domo_users ON domo_meeting_action.responsible = domo_users.id LEFT OUTER JOIN domo_meeting_status ON domo_meeting_action.status = domo_meeting_status.id WHERE meetingId= '" + meetingId + "'", {
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
