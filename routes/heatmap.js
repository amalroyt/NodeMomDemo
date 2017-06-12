var fs = require('fs');
var sequelize = require("./dbconfiguration").sequelize; //import sequelize database object
var counts = [];
 exports.generateheatmap = function(req, res) {

    sequelize.query("SELECT meetingTitle, DATE_FORMAT(meetingDate, '%Y-%m-%d') as meetingDate,COUNT(*) as count FROM domo_meeting_master GROUP BY meetingDate", {
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
 exports.showmoredetails = function(req, res) {
   console.log(req.params.id);
    sequelize.query("SELECT m.meetingId, m.meetingTitle, d.meetingType , DATE_FORMAT(m.meetingDate, '%d-%m-%Y') as meetingDate from domo_meeting_master m join domo_meeting_type d on (m.meetingType = d.id) WHERE m.meetingDate = '" + req.params.id +"'",{
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
