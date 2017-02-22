path = require('path');
exports.downloadExcel = function(req, res) {
  var fileName = req.params.meetingTitle;
  var filePath = 'D:/AngularMOMDemo/NodeMomDemo/excelData/';
  var thisPath = path.resolve(filePath + fileName + '.xlsx');
  res.setHeader('Content-type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  res.download(thisPath);
};
