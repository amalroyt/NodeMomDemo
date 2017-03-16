var sequelize = require("./dbconfiguration").sequelize;
var fs = require('fs');
exports.checkExcel = function(req, res) {

  sequelize.query(" SELECT meetingTitle FROM domo_meeting_master", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    //Function called to iterate through excel files
    var checkFile = function(val) {
        fs.stat('excelData/' + results[val].meetingTitle + '.xlsx', function(err, stat) {
          if (err == null) {
            sequelize.query(" UPDATE domo_meeting_master SET generatedExcel = 1 where meetingTitle = '" + results[val].meetingTitle + "' LIMIT 1  ", {
              type: sequelize.QueryTypes.UPDATE
            }).then(function(results) {
            })
          } else {
            sequelize.query(" UPDATE domo_meeting_master SET generatedExcel = 0 where meetingTitle = '" + results[val].meetingTitle + "' LIMIT 1  ", {
              type: sequelize.QueryTypes.UPDATE
            }).then(function(results) {
            })
          }
          return true;
        });
      }
      //Iterating through the folder for excel files
    for (var val in results) {
      checkFile(val);
    }
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
};
