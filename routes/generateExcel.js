var sequelize = require("./dbconfiguration").sequelize;
var json2xls = require('json2xls');
var fs = require('fs');
var check = require('./checkExcel');
exports.generateExcel = function(req, res) {
  var meetingMaster = [];
  var fileName;
  var meetingId = req.params.meetingId;
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
  sequelize.query(" SELECT meetingStatus,domo_meeting_type.meetingType,meetingTitle,meetingPurpose,f.userName AS meetingFacilitator,r.userName AS meetingRecorder,meetingVenue,Date_FORMAT(meetingDate, '%d/%m/%Y') AS meetingDate,startTime,endTime,meetingAgenda,meetingAttendees FROM domo_meeting_master INNER JOIN domo_users AS f on domo_meeting_master.meetingFacilitator = f.id INNER JOIN domo_users AS r on  domo_meeting_master.meetingRecorder = r.id INNER JOIN domo_meeting_type on domo_meeting_master.meetingType = domo_meeting_type.id WHERE domo_meeting_master.meetingId= '" + meetingId + "'", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    res.format({
      json: function() {
        fileName = results[0].meetingTitle;
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

    sequelize.query(" SELECT di.userName AS discussionBy,domo_discussion_type.discussionType,discussion,de.userName AS decisionBy,decision FROM domo_meeting_points INNER JOIN domo_users AS de on domo_meeting_points.discussionBy = de.id INNER JOIN domo_users AS di on domo_meeting_points.decisionBy = di.id INNER JOIN domo_discussion_type on domo_meeting_points.discussionType = domo_discussion_type.id WHERE  meetingId= '" + meetingId + "'", {
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

      sequelize.query(" SELECT actionDesc,domo_users.userName AS responsible,Date_FORMAT(openSince, '%d/%m/%Y') AS openSince,Date_FORMAT(expectedCompletion, '%d/%m/%Y') AS expectedCompletion,Date_FORMAT(actualCompletion, '%d/%m/%Y') AS actualCompletion,domo_meeting_status.status AS status FROM domo_meeting_action INNER JOIN domo_users on domo_meeting_action.responsible = domo_users.id LEFT OUTER JOIN domo_meeting_status on domo_meeting_action.status = domo_meeting_status.id WHERE meetingId= '" + meetingId + "'", {
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
            fs.writeFileSync('excelData/' + fileName + '.xlsx', xls, 'binary');
            //checkExcel function
            check.checkExcel();
          }
        });
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
