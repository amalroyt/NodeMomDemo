var sequelize = require("./dbconfiguration").sequelize,
  path = require('path'),
  fs = require('fs');
exports.downloadExcel = function(req, res) {
  var meetingId = req.params.meetingId;

  var filePath = './excelData/';
  if (fs.existsSync(filePath + 'meeting_' + meetingId)) {
    fs.readdir(filePath + 'meeting_' + meetingId, (err, files) => {
      var patt = /[\d]{10}/g;
      var diffArray = [];
      files.forEach(file => {
        diffArray.push({
          timeStamp: Number(file.match(patt)),
          fileName: file
        });
      });
      var startValue = 0;
      for (var i = 0; i < diffArray.length; i++) {
        if (diffArray[i].timeStamp > startValue) {
          fileName = diffArray[i].fileName;
        }
      }
      var thisPath = path.resolve(filePath + 'meeting_' + meetingId + '/' + fileName);
      res.setHeader('Content-type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      res.download(thisPath);
    })
  } else {
    sequelize.query(" UPDATE domo_meeting_master SET generatedExcel = 0 where meetingId = '" + meetingId + "' LIMIT 1  ", {
      type: sequelize.QueryTypes.UPDATE
    }).then(function(results) {
      res.status(404);
      res.end();
    })
  }
};
