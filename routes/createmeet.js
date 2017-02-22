var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object

exports.getTypes = function(req, res) {
	var query_status = "SELECT * FROM domo_meeting_type";
	sequelize.query(query_status, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(status_rows) {
        res.format({
          json: function() {
			
            res.send(status_rows);
			
           }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });
}

exports.getAttendees = function(req, res) {
	var query_attendees = "SELECT id,CONCAT_WS(' ',firstName,lastName) as firstlast FROM domo_users";
	sequelize.query(query_attendees, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(att_rows) {
        res.format({
          json: function() {
			
            res.send(att_rows);
			
            
          }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });
}
exports.getFaci = function(req, res) {
	var query_facilitator = "SELECT id,CONCAT_WS(' ',firstName,lastName) as firstlast FROM domo_users";
	sequelize.query(query_facilitator, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(faci_rows) {
        res.format({
          json: function() {
			
            res.send(faci_rows);
			
            
          }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });
}

exports.getRec = function(req, res) {
	var query_recorder = "SELECT id,CONCAT_WS(' ',firstName,lastName) as firstlast FROM domo_users";
	sequelize.query(query_recorder, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(rec_rows) {
        res.format({
          json: function() {
			
            res.send(rec_rows);
			
            
          }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });
}

exports.postMeeting = function(req, res) {
	
	 var meeting = {
      //id: req.body.meeting_id,
      status: req.body.meeting_status,
      type: req.body.meeting_type,
      title: req.body.meeting_title,
	  purpose: req.body.meeting_purpose,
	  facilitator: req.body.meeting_facilitator,
	  recorder: req.body.meeting_recorder,
	  venue: req.body.meeting_venue,
	  date: req.body.meeting_date,
      startTime: req.body.meeting_starttime,
	  endTime: req.body.meeting_endtime,
      agenda: req.body.meeting_agenda,
      attendees: req.body.meeting_attendees
    }
    var query = "INSERT INTO domo_meeting_master (meetingStatus,meetingType,meetingTitle,meetingPurpose,meetingFacilitator,meetingRecorder,meetingVenue,meetingDate,startTime,endTime,meetingAgenda,meetingAttendees,active)";
    query += "VALUES (";
    //query += meeting.id + ",";
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
    query += " '" + meeting.attendees + "',";
	query += " " + 1 + " )"; 
    var queryID = "SELECT * FROM domo_meeting_master";

    sequelize.query(query, {
      type: sequelize.QueryTypes.INSERT
    }).then(function(results) {

      sequelize.query(queryID, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(rows) {
        res.format({
          json: function() {
            //res.send(rows);
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
exports.deleteMeet = function(req, res) {
	
  sequelize.query("DELETE FROM domo_meeting_master WHERE meetingId=" + req.params.id, {
    type: sequelize.QueryTypes.DELETE
  }).then(function() {
    res.send(req.params);
    console.log("Deleted")
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
};

exports.getMeeting = function(req, res) {
  //Use query method to get the data from server
  sequelize.query("UPDATE domo_meeting_master SET active = 0 WHERE meetingId = " + req.params.id, {
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