var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object

//This function will write the data to the database using INSERT statement.
exports.discussionPoints = function(req, res) {
    var user = {
      id: 22,
      meetingId: 1,
      discussionBy: 2,
      discussionType: 1,
      discussion: "Technologies to be used for new DSR project",
      decisionBy: 2,
      decision: "Use Angular2 and NodeJs"
    }
    var query = "INSERT INTO domo_meeting_points (id,meetingId,discussionBy,discussionType,discussion,decisionBy,decision)";
    query += "VALUES (";
    query += user.id + ",";
    query += " '" + user.meetingId + "',";
    query += " '" + user.discussionBy + "',";
    query += " '" + user.discussionType + "',";
    query += " '" + user.discussion + "',";
    query += " '" + user.decisionBy + "',";
    query += " '" + user.decision + "' )";
    var queryID = "SELECT * FROM domo_meeting_points";

    sequelize.query(query, {
      type: sequelize.QueryTypes.INSERT
    }).then(function(results) {

      sequelize.query(queryID, {
        type: sequelize.QueryTypes.SELECT
      }).then(function(rows) {
        res.format({
          json: function() {
            res.send(rows);
            console.log("Inserted in domo_meeting_points table");
          }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });
    }).error(function(error) {
      console.log("Query Error: " + error);
    });
  }
