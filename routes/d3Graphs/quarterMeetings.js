var sequelize = require("../dbconfiguration").sequelize; //import sequelize database object

exports.quarterMeetingsData = function(req, res) {
  var quarterDates = JSON.parse(req.params.quarterDates);
  var startDateVal = quarterDates.startDate;
  var endDateVal = quarterDates.endDate;
  var startDate = startDateVal + ' 00:00:00';
  var endDate = endDateVal + ' 00:00:00';
  var dataSet = [];
  var countData = [];
  var meetingData = [];
  sequelize.query("SELECT COUNT(m.meetingType) AS count,t.meetingType as label FROM domo_meeting_master AS m LEFT OUTER JOIN domo_meeting_type AS t ON m.meetingType = t.id WHERE meetingDate NOT IN('" + endDate + "') AND meetingDate BETWEEN '" + startDate + "' and '"+endDate +"' GROUP BY m.meetingType", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    res.format({
      json: function() {
        countData = results;
        sequelize.query("SELECT m.meetingId,m.meetingTitle,Date_FORMAT(m.meetingDate, '%d-%m-%Y') AS meetingDate,t.meetingType as meetingType FROM domo_meeting_master AS m LEFT OUTER JOIN domo_meeting_type AS t ON m.meetingType = t.id WHERE meetingDate NOT IN('" + endDate + "') AND meetingDate BETWEEN '" + startDate + "' and '"+endDate +"'", {
          type: sequelize.QueryTypes.SELECT
        }).then(function(results) {
          res.format({
            json: function() {
              meetingData = results;
              dataSet.push({countData:countData,meetingData:meetingData});
              res.send(dataSet);
            }
          });
        }).error(function(error) {
          console.log("Query Error: " + error);
        });
      }
    });
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
}
