var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object

exports.postMeeting = function(req, res) {
    var meeting = {
      id: 1,
      status: "Open",
      type: "Sprint Meet",
      title: "Weekly Sprint Status meeting",
	  purpose: "Weekly Sprint Status meeting",
	  facilitator: "Sandeep Nabar",
	  recorder: "Durgesh Ahire",
	  venue: "CT1-6-7080",
	  date: '2017-02-15',
      startTime: '03:30:00',
	  endTime: '05:00:00',
      agenda: "• General Engineering updates• JIRA User Stories Status",
      attendees: "Josh Nelson, Vikas Jadhav, Sandhya Aghav"
    }
    var query = "INSERT INTO meeting (id,status,type,title,purpose,facilitator,recorder,venue,date,startTime,endTime,agenda,attendees)";
    query += "VALUES (";
    query += meeting.id + ",";
    query += " '" + meeting.status + "',";
    query += " '" + meeting.type + "',";
    query += " '" + meeting.title + "',";
    query += " '" + meeting.purpose + "',";
    query += " '" + meeting.facilitator + "',";
	query += " '" + meeting.recorder + "',";
	query += " '" + meeting.venue + "',";
	query += " '" + meeting.date + "',";
	query += " '" + meeting.startTime + "',";
	query += " '" + meeting.endTime + "',";
    query += " '" + meeting.agenda + "',";
    query += " '" + meeting.attendees + "' )";
    var queryID = "SELECT * FROM meeting";

    sequelize.query(query, {
      type: sequelize.QueryTypes.INSERT
    }).then(function(results) {

      sequelize.query(queryID, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(rows) {
        res.format({
          json: function() {
            res.send(rows);
            console.log("Inserted");
          }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });
    }).error(function(error) {
      console.log("Query Error: " + error);
    });
  }
