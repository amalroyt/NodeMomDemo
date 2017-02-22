var sequelize = require("./dbconfiguration").sequelize;
var check = require('./checkExcel');
exports.meetingList = function(req, res) {
  //checkExcel function
  check.checkExcel();
  sequelize.query(" SELECT * FROM domo_meeting_master", {
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
