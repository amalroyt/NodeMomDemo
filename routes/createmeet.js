var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object

exports.getMeetingTypes = function(req, res) {
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

exports.getAttendeesbyId = function(req, res) {

	var query_attendeesbyid = "SELECT id,CONCAT_WS(' ',firstName,lastName) as firstlast FROM domo_users WHERE id="  + req.params.id;

	sequelize.query(query_attendeesbyid, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(attbyid_rows) {
        res.format({
          json: function() {

            res.send(attbyid_rows);

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

exports.getFirstName = function(req, res) {
	var query_fname = "SELECT firstName FROM domo_users WHERE userName = "+ "'" +req.params.name+"'";
	sequelize.query(query_fname, {
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
	console.log(req.body);
	 var meeting = {
      //id: req.body.meeting_id,
      status: req.body.status,
      type: req.body.type,
      title: req.body.title,
	  purpose: req.body.purpose,
	  facilitator: req.body.facilitator,
	  recorder: req.body.recorder,
	  venue: req.body.venue,
	  date: req.body.date,
      startTime: req.body.startTime + ":00",
	  endTime: req.body.endTime + ":00",
      agenda: req.body.agenda,
      attendees: req.body.attendees
    }
	console.log(meeting);
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
	query += " " + 0 + " )";

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

exports.getMeetingInfo = function(req, res) {
  //Use query method to get the data from server
  sequelize.query("SELECT *,DATE_FORMAT(meetingDate, '%m/%d/%Y') as meetingDate FROM domo_meeting_master WHERE meetingId = " + req.params.id, {
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
exports.updateMeeting = function(req, res) {
	 console.log(req.body.startTime.length);
	 if(((req.body.startTime.length)<8)&&((req.body.endTime.length)<8)){

	var meeting = {
      id: req.body.id,
      status: req.body.status,
      type: req.body.type,
      title: req.body.title,
	  purpose: req.body.purpose,
	  facilitator: req.body.facilitator,
	  recorder: req.body.recorder,
	  venue: req.body.venue,
	  date: req.body.date,
      startTime: req.body.startTime + ":00",
	  endTime: req.body.endTime + ":00",
      agenda: req.body.agenda,
      attendees: req.body.attendees
    }
	}
	else
	{
		var meeting = {
      id: req.body.id,
      status: req.body.status,
      type: req.body.type,
      title: req.body.title,
	  purpose: req.body.purpose,
	  facilitator: req.body.facilitator,
	  recorder: req.body.recorder,
	  venue: req.body.venue,
	  date: req.body.date,
      startTime: req.body.startTime,
	  endTime: req.body.endTime,
      agenda: req.body.agenda,
      attendees: req.body.attendees
    }

	}
	console.log(meeting.startTime.length);

    var query = "UPDATE domo_meeting_master SET";
    //query += meeting.id + ",";
    query += " " + "meetingStatus=" + meeting.status + ",";
    query += " " + "meetingType=" + meeting.type + ",";
    query += " " + "meetingTitle='" + meeting.title + "',";
    query += " " + "meetingPurpose='" + meeting.purpose + "',";
    query += " " + "meetingFacilitator=" + meeting.facilitator + ",";
	query += " " + "meetingRecorder=" + meeting.recorder + ",";
	query += " " + "meetingVenue='" + meeting.venue + "',";
	query += " " + "meetingDate='" + meeting.date + "',";
	query += " " + "startTime='" + meeting.startTime + "',";
	query += " " + "endTime='" + meeting.endTime + "',";
    query += " " + "meetingAgenda='" + meeting.agenda + "',";
    query += " " + "meetingAttendees='" + meeting.attendees + "',";

	query += " " + "active=" + 1 + " " ;

	query += " WHERE meetingId=" + meeting.id + ";";
    var queryID = "SELECT * FROM domo_meeting_master WHERE meetingId=" + meeting.id;

    sequelize.query(query, {
      type: sequelize.QueryTypes.UPDATE
    }).then(function(results) {

      sequelize.query(queryID, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(rows) {
        res.format({
          json: function() {
            //res.send(rows);
            console.log("Updated");

          }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });
    }).error(function(error) {
      console.log("Query Error: " + error);
    });
  }
