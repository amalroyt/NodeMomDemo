var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object

// to get meeting title
exports.actionDiscussion = function(req, res) {
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

// to get User Names from users lable
exports.getUserNames = function(req, res) {
  //Use query method to get the data from sever
  var meetingId = req.params.meetingId;
  sequelize.query("SELECT id, CONCAT_WS(' ',firstName,lastName) as firstlast FROM domo_meeting_master as t1 LEFT JOIN domo_users as t2 ON find_in_set(t2.id, t1.meetingAttendees) where meetingId= '" + meetingId + "'", {
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

/**************************************DISCUSSION********************************************/

// to get existing meeting details(dicussion)
exports.getExistingMeetingInfo = function(req, res) {
  var meetingId = req.params.meetingId;
  sequelize.query(" SELECT * from domo_meeting_points WHERE active != true AND meetingId= '" + meetingId + "'", {
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

// to get discussion type in dropdown
exports.getTypes = function(req, res) {
  sequelize.query("SELECT * from domo_discussion_type", {
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

//This function will write the data to the database using INSERT statement.
exports.discussionPoints = function(req, res) {
  console.log(req.body);
  var user = req.body;
  var id = user[0];
  console.log(id);
  var userValues = JSON.parse(user[1]);
  var userId = user[2];
  console.log(userId);
  console.log(userValues);
  console.log(userValues.discussionBy);
  var query = "INSERT INTO domo_meeting_points (meetingId,discussionBy,discussionType,discussion,decisionBy,decision,createdBy,createdDate)";
  query += "VALUES (";
  query += " '" + id + "',";
  query += " '" + userValues.discussionBy + "',";
  query += " '" + userValues.discussionType + "',";
  query += " '" + userValues.discussion + "',";
  query += " '" + userValues.decisionBy + "',";
  query += " '" + userValues.decision + "',";
  query += " '" + userId + "',";
  query += " CURDATE() )";

  sequelize.query(query, {
    type: sequelize.QueryTypes.INSERT
  }).then(function(results) {
    res.format({
      json: function() {
        console.log("Inserted into discussion table");
        //res.send(results);
        res.end();
      }
    });
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
}

// to delete selected database row from discussion table
exports.deleteDiscussionPoints = function(req, res) {
  var trackIndex = req.params.trackIndex;
  console.log(trackIndex);
  sequelize.query(" UPDATE domo_meeting_points SET active = '1' WHERE id IN ("+trackIndex+")", {
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

/**************************************DISCUSSION********************************************/

/**************************************ACTION********************************************/

// to get existing meeting details(action)
exports.getExistingMeetingInfoAction = function(req, res) {
  var meetingId = req.params.meetingId;
  sequelize.query(" SELECT id, meetingId,actionDesc,responsible,DATE_FORMAT(openSince, '%m/%d/%Y') as openSince,DATE_FORMAT(expectedCompletion, '%m/%d/%Y') as expectedCompletion,DATE_FORMAT(actualCompletion, '%m/%d/%Y') as actualCompletion, status FROM domo_meeting_action WHERE active != true AND meetingId= '" + meetingId + "'", {
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


// to get meeting status in dropdown
exports.getStatus = function(req, res) {
  sequelize.query("SELECT * from domo_meeting_status", {
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

//This function will write the data to the database using INSERT statement.
exports.actionItems = function(req, res) {
  console.log(req.body);
  var user = req.body;
  var id = user[0];
  console.log(id);
  var userValues = JSON.parse(user[1]);
  var userId = user[2];
  console.log(userId);
  console.log(userValues);

  if (userValues.status == 2) {
    var query = "INSERT INTO domo_meeting_action (meetingId,actionDesc,responsible,openSince,expectedCompletion,actualCompletion,status,createdBy,createdDate)";
    query += "VALUES (";
    query += " '" + id + "',";
    query += " '" + userValues.actionDesc + "',";
    query += " '" + userValues.responsible + "',";
    query += " '" + userValues.openSince + "',";
    query += " '" + userValues.expectedCompletion + "',";
    query += " CURDATE() ,";
    query += " '" + userValues.status + "',";
    query += " '" + userId + "',";
    query += " CURDATE() )";
    sequelize.query(query, {
      type: sequelize.QueryTypes.INSERT
    }).then(function(results) {
      res.format({
        json: function() {
          console.log("Inserted into action table");
          res.end();
          //res.send(results);
        }
      });
    }).error(function(error) {
      console.log("Query Error: " + error);
    });

  }
  else {
    var query = "INSERT INTO domo_meeting_action (meetingId,actionDesc,responsible,openSince,expectedCompletion,status,createdBy,createdDate)";
    query += "VALUES (";
    query += " '" + id + "',";
    query += " '" + userValues.actionDesc + "',";
    query += " '" + userValues.responsible + "',";
    query += " '" + userValues.openSince + "',";
    query += " '" + userValues.expectedCompletion + "',";
    query += " '" + userValues.status + "',";
    query += " '" + userId + "',";
    query += " CURDATE() )";
    sequelize.query(query, {
      type: sequelize.QueryTypes.INSERT
    }).then(function(results) {
      res.format({
        json: function() {
          console.log("Inserted into action table");
          res.end();
          //res.send(results);
        }
      });
    }).error(function(error) {
      console.log("Query Error: " + error);
    });
  }

}

// to delete selected database row from action table
exports.deleteActionItem = function(req, res) {
  var trackIndex = req.params.trackIndex;
  console.log(trackIndex);
  sequelize.query(" UPDATE domo_meeting_action SET active = '1' WHERE id IN ("+trackIndex+")", {
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

/**************************************ACTION********************************************/
