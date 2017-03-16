var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object

exports.getMeetingId = function(req, res) {
  //Use query method to get the data from sever
  sequelize.query("SELECT * from domo_meeting_master", {
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

exports.getTypes = function(req, res) {
  //Use query method to get the data from sever
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

exports.getUserNames = function(req, res) {
  //Use query method to get the data from sever
  sequelize.query("SELECT id,CONCAT_WS(' ',firstName,lastName) as fullUserName from domo_users", {
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
  var num = ((req.body).length)-1;
  var id = user[num].ids;
  console.log(id);
  for(var i=0; i< (user.length)-1; i++) {
      var query = "INSERT INTO domo_meeting_points (meetingId,discussionBy,discussionType,discussion,decisionBy,decision)";
      query += "VALUES (";
      query += " '" + id + "',";
      query += " '" + user[i].discussionBy + "',";
      query += " '" + user[i].discussionType + "',";
      query += " '" + user[i].discussion + "',";
      query += " '" + user[i].decisionBy + "',";
      query += " '" + user[i].decision + "' )";
    //  var queryID = "SELECT * FROM discussion_dumy";
      sequelize.query(query, {
        type: sequelize.QueryTypes.INSERT
         }).then(function(results) {
           res.format({
             json: function() {
               //res.send(results);
               //res.end();
               console.log("Inserted into discussion table");
               res.end();
             }
           });
         }).error(function(error) {
           console.log("Query Error: " + error);
         });

    }
  }
