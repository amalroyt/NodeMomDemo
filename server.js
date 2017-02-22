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
  meeting = require('./routes/meeting'),
  moreDetails = require('./routes/moreDetails'),
  discussion = require('./routes/discussion'),
  action = require('./routes/action');



  address   =  require('./routes/createmeet'),
   moreDetails = require('./routes/moreDetails');
   
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
app.post('/meetingList',meeting.meetingList);
app.post('/moreDetailsPoints',moreDetails.moreDetailsPoints);
app.post('/moreDetailsAction',moreDetails.moreDetailsAction);
app.post('/discussion',discussion.discussionPoints);
app.post('/action',action.actionItems);
app.post('/postMeeting',address.postMeeting);
app.get('/getMeeting/:id',address.getMeeting);
app.get('/getTypes',address.getTypes);
app.get('/getAttendees',address.getAttendees);
app.get('/getFaci',address.getFaci);
app.get('/getRec',address.getRec);
app.delete('/deleteMeet/:id',address.deleteMeet);
app.post('/moreDetailsPoints',moreDetails.moreDetailsPoints);
app.post('/moreDetailsAction',moreDetails.moreDetailsAction);

app.listen(8081, function() {
  console.log('Example listening on port 8081!');
});
