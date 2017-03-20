var sequelize = require("./dbconfiguration").sequelize;
exports.moreDetails = function(req, res) {
  var meetingId = req.params.meetingId;
  sequelize.query(" select meetingId,meetingTitle,meetingPurpose,meetingAgenda,Date_FORMAT(meetingDate, '%d-%m-%Y') AS meetingDate,group_concat(' ',firstName,lastName) as meetingAttendees FROM domo_meeting_master as t1 LEFT JOIN domo_users as t2 ON find_in_set(t2.id, t1.meetingAttendees) WHERE t1.meetingId = '" + meetingId + "' group by t1.meetingId", {
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
  sequelize.query(" SELECT di.firstName AS discussionBy,de.firstName AS decisionBy,domo_discussion_type.discussionType,discussion,decision FROM domo_meeting_points inner join domo_users as de on domo_meeting_points.discussionBy = de.id inner join domo_users as di on domo_meeting_points.decisionBy = di.id INNER JOIN domo_discussion_type ON domo_meeting_points.discussionType = domo_discussion_type.id WHERE  meetingId= '" + meetingId + "'", {
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
  sequelize.query(" SELECT domo_users.firstName AS responsible,domo_meeting_status.status AS status,actionDesc,DATE_FORMAT(openSince, '%d-%m-%Y') as openSince,DATE_FORMAT(expectedCompletion, '%d-%m-%Y') as expectedCompletion,DATE_FORMAT(actualCompletion, '%d/%m/%Y') as actualCompletion FROM domo_meeting_action INNER JOIN domo_users ON domo_meeting_action.responsible = domo_users.id LEFT OUTER JOIN domo_meeting_status ON domo_meeting_action.status = domo_meeting_status.id WHERE meetingId= '" + meetingId + "'", {
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
