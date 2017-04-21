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
  checkingToken = require('./routes/checkingToken'),
  meetingList = require('./routes/meetingList'),
  moreDetails = require('./routes/moreDetails'),
  generate = require('./routes/generateExcel'),
  check = require('./routes/checkExcel'),
  download = require('./routes/downloadExcel'),
  deleteMeet = require('./routes/deleteMeeting'),
  address = require('./routes/createmeet'),
  actionDiscussion = require('./routes/actionDiscussion'),
  updateDetails = require('./routes/updateDetails'),
  quarterMeetings = require('./routes/d3Graphs/quarterMeetings');
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  res.header("Access-Control-Allow-Methods", "DELETE, GET, POST, PUT, POST");
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
app.get('/download/:meetingId', download.downloadExcel);
app.put('/deleteMeeting/:meetingIds', deleteMeet.deleteMeeting);
app.post('/updateDiscussion/:discussionId', updateDetails.updateDiscussion);
app.post('/updateAction/:actionId', updateDetails.updateAction);
app.put('/logoutToken', authorization.preLogout);
app.get('/moreDetailsHistory/:meetingId', moreDetails.moreDetailsHistory);
app.get('/downloadPrev/:download',moreDetails.downloadPrev);
app.get('/quarterMeetings/:quarterDates',quarterMeetings.quarterMeetingsData);
app.get('/isAdminUser/:userId',authorization.postAuthorization);

app.get('/actionDiscussion/:meetingId', actionDiscussion.actionDiscussion);
app.post('/discussionPoints', actionDiscussion.discussionPoints);
app.post('/actionItems', actionDiscussion.actionItems);
app.get('/getTypes', actionDiscussion.getTypes);
app.get('/getUserNames/:meetingId', actionDiscussion.getUserNames);
app.get('/getStatus', actionDiscussion.getStatus);
app.get('/getExistingMettingInfo/:meetingId', actionDiscussion.getExistingMeetingInfo);
app.get('/getExistingMeetingInfoAction/:meetingId', actionDiscussion.getExistingMeetingInfoAction);
app.delete('/deleteDiscussionPoints/:trackIndex', actionDiscussion.deleteDiscussionPoints);
app.delete('/deleteActionItem/:trackIndex', actionDiscussion.deleteActionItem);
app.get('/getActionItemsInformationForGraph', actionDiscussion.getActionItemsInformationForGraph);

app.post('/postMeeting',address.postMeeting);
app.put('/updateMeeting',address.updateMeeting);
app.get('/getMeeting/:id',address.getMeeting);
app.get('/getMeetingInfo/:id',address.getMeetingInfo);
app.get('/getMeetingTypes',address.getMeetingTypes);
app.get('/getAttendees',address.getAttendees);
app.get('/getAttendees/:id',address.getAttendeesbyId);
app.get('/getFaci',address.getFaci);
app.get('/getRec',address.getRec);
app.delete('/deleteMeet/:id',address.deleteMeet);
app.get('/checkIfAllItemsClosed/:id',address.checkIfAllItemsClosed);

app.listen(8081, function() {
  console.log('Example listening on port 8081!');
});
