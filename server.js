/*
  Backend Reset API's
  AngualrCLI will do the proxy to this express server
  Don't use express here for front end serving, this will be handled by ng serve
*/
var express = require('express'),
  http = require('http'),
  app = express(),
  bodyParser = require('body-parser'),
  cookieParser = require('cookie-parser'),
  path = require('path'),
  sequelize = require('./routes/dbconfiguration').sequelize,
  config = require('./routes/dbresources'),
  authorization = require('./routes/authorization_src'),
  meetingList = require('./routes/meetingList'),
  moreDetails = require('./routes/moreDetails'),
  generate = require('./routes/generateExcel'),
  check = require('./routes/checkExcel'),
  download = require('./routes/downloadExcel'),
  meeting = require('./routes/meeting'),
  discussion = require('./routes/discussion'),
  action = require('./routes/action'),
  address   =  require('./routes/createmeet');
 
   app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });

app.use(cookieParser());
app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({
  extended: true
})); // for parsing application/x-www-form-urlencoded
app.use(express.static(__dirname + '/dist'));

// app.get('/', function(req, res) {
//   res.sendFile(path.join(__dirname + '/dist', 'index.html'));
// });

app.post('/login', authorization.preAuthorization);
app.get('/meetingList', meetingList.meetingList);
app.get('/moreDetails/:meetingId', moreDetails.moreDetails);
app.get('/moreDetailsPoints/:meetingId', moreDetails.moreDetailsPoints);
app.get('/moreDetailsAction/:meetingId', moreDetails.moreDetailsAction);
app.post('/generateExcel/:meetingId', generate.generateExcel);
app.put('/checkExcel', check.checkExcel);
app.get('/download/:meetingTitle', download.downloadExcel);
app.post('/discussion',discussion.discussionPoints);
app.post('/action',action.actionItems);
app.post('/postMeeting',address.postMeeting);
app.get('/getMeeting/:id',address.getMeeting);
app.get('/getTypes',address.getTypes);
app.get('/getAttendees',address.getAttendees);
app.get('/getFaci',address.getFaci);
app.get('/getRec',address.getRec);
app.delete('/deleteMeet/:id',address.deleteMeet);


app.listen(8081, function() {
  console.log('Example listening on port 8081!');
});
