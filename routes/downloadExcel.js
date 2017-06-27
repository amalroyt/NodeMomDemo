path = require('path');
const fs = require('fs');
exports.downloadExcel = function(req, res) {
  var meetingId = req.params.meetingId;

  var filePath = './excelData/';

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
};
