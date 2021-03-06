var sequelize = require("./dbconfiguration").sequelize;
exports.meetingList = function(req, res) {
  sequelize.query("SELECT meetingId,meetingTitle,meetingAgenda,status,Date_FORMAT(meetingDate,'%d-%m-%Y') as meetingDate,generatedExcel,group_concat(' ',firstName,' ',lastName) as meetingAttendees FROM domo_meeting_master as t1 LEFT JOIN domo_users as t2 ON find_in_set(t2.id, t1.meetingAttendees) LEFT JOIN domo_meeting_status as t3 ON t3.id = t1.meetingStatus WHERE t1.active != true group by t1.meetingId, t1.meetingTitle ORDER BY t1.meetingId DESC", {
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
