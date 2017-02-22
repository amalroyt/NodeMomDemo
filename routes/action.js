var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object

//This function will write the data to the database using INSERT statement.
exports.actionItems = function(req, res) {
    var user = {
      id: 33,
      meetingId: 1,
      actionDesc: "Rutuja to complete validation",
      responsible: 1,
      openSince: "2017-02-01",
      expectedCompletion: "2017-02-22",
      actualCompletion: "2017-02-18",
      status: 1,
    }
    var query = "INSERT INTO domo_meeting_action (id,meetingId,actionDesc,responsible,openSince,expectedCompletion,actualCompletion,status)";
    query += "VALUES (";
    query += user.id + ",";
    query += " '" + user.meetingId + "',";
    query += " '" + user.actionDesc + "',";
    query += " '" + user.responsible + "',";
    query += " '" + user.openSince + "',";
    query += " '" + user.expectedCompletion + "',";
    query += " '" + user.actualCompletion + "',";
    query += " '" + user.status + "')";
    var queryID = "SELECT * FROM domo_meeting_action";

    sequelize.query(query, {
      type: sequelize.QueryTypes.INSERT
    }).then(function(results) {

      sequelize.query(queryID, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(rows) {
        res.format({
          json: function() {
            res.send(rows);
            console.log("Inserted in domo_meeting_action table");
          }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });
    }).error(function(error) {
      console.log("Query Error: " + error);
    });
  }
