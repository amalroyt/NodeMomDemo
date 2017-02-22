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

exports.getStatus = function(req, res) {
  //Use query method to get the data from sever
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
  var num = ((req.body).length)-1;
  var id = user[num].ids;
  console.log(id);
  for(var i=0; i< (user.length)-1; i++) {
    var query = "INSERT INTO domo_meeting_action (meetingId,actionDesc,responsible,openSince,expectedCompletion,actualCompletion,status)";
      query += "VALUES (";
      query += " '" + id + "',";
      query += " '" + user[i].actionDesc + "',";
      query += " '" + user[i].responsible + "',";
      query += " '" + user[i].openSince + "',";
      query += " '" + user[i].expectedCompletion + "',";
      query += " '" + user[i].actualCompletion + "',";
      query += " '" + user[i].status + "')";
    sequelize.query(query, {
      type: sequelize.QueryTypes.INSERT
       }).then(function(results) {
         res.format({
           json: function() {
             //res.send(results);
             //res.end();
             console.log("Inserted into action table");
             res.end();
           }
         });
       }).error(function(error) {
         console.log("Query Error: " + error);
       });
     }
 }
