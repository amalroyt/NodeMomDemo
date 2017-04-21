var sequelize = require("./dbconfiguration").sequelize;
var json2xls = require('json2xls');
var fs = require('fs');
exports.generateExcel = function(req, res) {
  var meetingMaster = [];
  var meetingId = req.params.meetingId;
  var versionNum;
  var spacingFunc = function() {
    for (var i = 0; i < 3; i++) {
      meetingMaster.push({
        a: "",
        b: "",
        c: "",
        d: "",
        e: "",
        f: "",
        g: "",
        h: "",
        i: "",
        j: "",
        k: "",
        l: ""
      });
    }
  }
  sequelize.query(" SELECT meetingStatus,domo_meeting_type.meetingType,meetingTitle,meetingPurpose,f.firstName AS meetingFacilitator,r.firstName AS meetingRecorder,meetingVenue,Date_FORMAT(meetingDate, '%d-%m-%Y') AS meetingDate,startTime,endTime,meetingAgenda,group_concat(' ',f.firstName,' ',f.lastName) as meetingAttendees FROM domo_meeting_master as t1 LEFT JOIN domo_users as t2 ON find_in_set(t2.id, t1.meetingAttendees) INNER JOIN domo_users AS f on t1.meetingFacilitator = f.id INNER JOIN domo_users AS r on  t1.meetingRecorder = r.id INNER JOIN domo_meeting_type on t1.meetingType = domo_meeting_type.id WHERE t1.meetingId = '" + meetingId + "'", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    res.format({
      json: function() {
        spacingFunc();

        meetingMaster.push({
          b: 'Meeting Details'
        });

        meetingMaster = [{
          a: 'Status',
          b: 'meetingType',
          c: 'Title',
          d: 'Purpose',
          e: 'Facilitator',
          f: 'Recorder',
          g: 'Venue',
          h: 'Date',
          i: 'startTime',
          j: 'endTime',
          k: 'Agenda',
          l: 'Attendees'
        }];
        //Pushing data for the meetingMaster
        meetingMaster.push({
          a: results[0].meetingStatus,
          b: results[0].meetingType,
          c: results[0].meetingTitle,
          d: results[0].meetingPurpose,
          e: results[0].meetingFacilitator,
          f: results[0].meetingRecorder,
          g: results[0].meetingVenue,
          h: results[0].meetingDate,
          i: results[0].startTime,
          j: results[0].endTime,
          k: results[0].meetingAgenda,
          l: results[0].meetingAttendees
        });
        spacingFunc();
      }
    });

    sequelize.query(" SELECT di.firstName AS discussionBy,domo_discussion_type.discussionType,discussion,de.firstName AS decisionBy,decision FROM domo_meeting_points INNER JOIN domo_users AS di on domo_meeting_points.discussionBy = di.id INNER JOIN domo_users AS de on domo_meeting_points.decisionBy = de.id INNER JOIN domo_discussion_type on domo_meeting_points.discussionType = domo_discussion_type.id WHERE  meetingId= '" + meetingId + "'", {
      type: sequelize.QueryTypes.SELECT
    }).then(function(results) {
      res.format({
        json: function() {
          meetingMaster.push({
            b: 'Discussion Points'
          });

          meetingMaster.push({
            a: 'discussionBy',
            b: 'discussionType',
            c: 'discussion',
            d: 'decisionBy',
            e: 'decision'
          });
          for (var val in results) {
            meetingMaster.push({
              a: results[val].discussionBy,
              b: results[val].discussionType,
              c: results[val].discussion,
              d: results[val].decisionBy,
              e: results[val].decision
            });
          }
          spacingFunc();
        }
      });

      sequelize.query(" SELECT actionDesc,domo_users.firstName AS responsible,Date_FORMAT(openSince, '%d-%m-%Y') AS openSince,Date_FORMAT(expectedCompletion, '%d-%m-%Y') AS expectedCompletion,Date_FORMAT(actualCompletion, '%d-%m-%Y') AS actualCompletion,domo_meeting_status.status AS status FROM domo_meeting_action INNER JOIN domo_users on domo_meeting_action.responsible = domo_users.id LEFT OUTER JOIN domo_meeting_status on domo_meeting_action.status = domo_meeting_status.id WHERE meetingId= '" + meetingId + "'", {
        type: sequelize.QueryTypes.SELECT
      }).then(function(results) {
        res.format({
          json: function() {
            meetingMaster.push({
              b: 'Action Points'
            });

            meetingMaster.push({
              a: 'actionDesc',
              b: 'responsible',
              c: 'openSince',
              d: 'expectedCompletion',
              e: 'actualCompletion',
              f: 'status'
            });
            for (var val in results) {
              meetingMaster.push({
                a: results[val].actionDesc,
                b: results[val].responsible,
                c: results[val].openSince,
                d: results[val].expectedCompletion,
                e: results[val].actualCompletion,
                f: results[val].status
              });
            }
            var xls = json2xls(meetingMaster);
            //To check if file is to generated for the first time or not.

            var ititialDir = 'D:/NodeMomDemo/excelData/';

            if (!fs.existsSync(ititialDir + 'meeting_' + meetingId)){
                fs.mkdirSync(ititialDir + 'meeting_' + meetingId);
            }
              fs.writeFileSync('excelData/' + 'meeting_' + meetingId + '/' + Math.floor(Date.now() / 1000) + '.xlsx', xls, 'binary');
              sequelize.query(" UPDATE domo_meeting_master SET generatedExcel = 1 where meetingId = '" + meetingId + "' LIMIT 1  ", {
                type: sequelize.QueryTypes.UPDATE
              }).then(function(results) {
                res.end();
              })
          }
        });
      }).error(function(error) {
        console.log("Query Error: " + error);
      });

    }).error(function(error) {
      console.log("Query Error: " + error);
    });

  }).error(function(error) {
    console.log("Query Error: " + error);
  });
};
