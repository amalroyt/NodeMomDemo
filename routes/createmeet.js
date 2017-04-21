var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object

 exports.checkIfAllItemsClosed = function(req, res) {
    var meetingId = req.params.id;
    console.log(meetingId);
    sequelize.query("SELECT status FROM domo_meeting_action WHERE meetingId=" + meetingId , {
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
}


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
  var query_attendeesbyid = "SELECT id,CONCAT_WS(' ',firstName,lastName) as firstlast FROM domo_users WHERE id=" + req.params.id;
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
  var query_fname = "SELECT firstName FROM domo_users WHERE userName = " + "'" + req.params.name + "'";
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
  var createMeet = req.body;
  var userId = JSON.parse(createMeet[0]);
  var meet = JSON.parse(createMeet[1])
  var meeting = {
    //id: req.body.meeting_id,
    status: meet.status,
    type: meet.type,
    title: meet.title,
    purpose: meet.purpose,
    facilitator: meet.facilitator,
    recorder: meet.recorder,
    venue: meet.venue,
    date: meet.date,
    startTime: meet.startTime + ":00",
    endTime: meet.endTime + ":00",
    agenda: meet.agenda,
    attendees: meet.attendees,
    startForm: meet.startForm,
    endForm: meet.endForm,
    duration: meet.duration
  }
  console.log(meeting);
  var query = "INSERT INTO domo_meeting_master (meetingStatus,meetingType,meetingTitle,meetingPurpose,meetingFacilitator,meetingRecorder,meetingVenue,meetingDate,startTime,endTime,meetingAgenda,meetingAttendees,active,createdBy,createdDate,startForm,endForm,duration)";
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
  query += " " + 0 + ",";
  query += " " + userId + ",";
  query += "curdate(),";
  query += "'" + meeting.startForm + "',";
  query += "'" + meeting.endForm + "',";
  query += "'" + meeting.duration + "')";
  var queryID = "SELECT * FROM domo_meeting_master";

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
  sequelize.query("SELECT *,DATE_FORMAT(meetingDate, '%Y-%m-%d') as meetingDate FROM domo_meeting_master WHERE meetingId = " + req.params.id, {
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
  var editMeet = req.body;
  var userId = JSON.parse(editMeet[0]);

  var meet = JSON.parse(editMeet[1]);

  //console.log(meet.startTime.length);
  if (((meet.startTime.length) < 8) && ((meet.endTime.length) < 8)) {

    var meeting = {
      id: meet.id,
      status: meet.status,
      type: meet.type,
      title: meet.title,
      purpose: meet.purpose,
      facilitator: meet.facilitator,
      recorder: meet.recorder,
      venue: meet.venue,
      date: meet.date,
      startTime: meet.startTime + ":00",
      endTime: meet.endTime + ":00",
      agenda: meet.agenda,
      attendees: meet.attendees,
      startForm: meet.startForm,
      endForm: meet.endForm,
      duration: meet.duration,
      reason: meet.reason
    }
  } else {
    var meeting = {
      id: meet.id,
      status: meet.status,
      type: meet.type,
      title: meet.title,
      purpose: meet.purpose,
      facilitator: meet.facilitator,
      recorder: meet.recorder,
      venue: meet.venue,
      date: meet.date,
      startTime: meet.startTime,
      endTime: meet.endTime,
      agenda: meet.agenda,
      attendees: meet.attendees,
      startForm: meet.startForm,
      endForm: meet.endForm,
      duration: meet.duration,
      reason: meet.reason
    }

  }
  console.log(meeting.startTime.length);
  console.log(meeting);
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
  query += " " + "startForm='" + meeting.startForm + "',";
  query += " " + "endForm='" + meeting.endForm + "',";
  query += " " + "duration='" + meeting.duration + "',";
  query += " " + "reason='" + meeting.reason + "'";
  //query += " " + "active=" + 1 + " ";
  query += " WHERE meetingId=" + meeting.id + ";";
  var queryID = "SELECT * FROM domo_meeting_master WHERE meetingId=" + meeting.id;
  var updateQuery = "INSERT INTO domo_tasklogs (task,onTable,meetingId,updatedBy,updatedDate) VALUES ('Update','domo_meeting_master','" + meeting.id + "','" + userId + "',curdate())";
  sequelize.query(query, {
    type: sequelize.QueryTypes.UPDATE
  }).then(function(results) {

    sequelize.query(updateQuery, {
      type: sequelize.QueryTypes.INSERT
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
