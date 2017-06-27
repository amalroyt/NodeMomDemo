var sequelize = require("./dbconfiguration").sequelize;
exports.updateDiscussion = function(req, res) {
  var discussionId = req.params.discussionId;
  var updateDetails = req.body;
  var discussionDetails = JSON.parse(updateDetails[1]);
  var userId = JSON.parse(updateDetails[0]);
  var meetingId = updateDetails[2];
  sequelize.query(" UPDATE domo_meeting_points SET discussionBy = '" + discussionDetails.discussionBy + "', discussionType = '" + discussionDetails.discussionType + "', discussion = '" + discussionDetails.discussion + "', decisionBy = '" + discussionDetails.decisionBy + "', decision = '" + discussionDetails.decision + "' WHERE id = '" + discussionId + "'", {
    type: sequelize.QueryTypes.UPDATE
  }).then(function(results) {
    sequelize.query(" INSERT INTO domo_tasklogs (task,onTable,meetingId,updatedBy,updatedDate) VALUES ('Update','domo_meeting_points','" + discussionDetails.meetingId + "','" + userId + "',curdate())", {
      type: sequelize.QueryTypes.INSERT
    }).then(function(results) {
      sequelize.query(" UPDATE domo_meeting_master SET generatedExcel = 0 WHERE meetingId = '" + meetingId + "'", {
        type: sequelize.QueryTypes.UPDATE
      }).then(function(results) {
        console.log("before end");
        res.end();
      })
    })
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
};

exports.updateAction = function(req, res) {
  var actionId = req.params.actionId;
  var updateDetails = req.body;
  var actionDetails = JSON.parse(updateDetails[1]);
  var userId = JSON.parse(updateDetails[0]);
  var meetingId = updateDetails[2];
  if (actionDetails.status == 2) {
    sequelize.query(" UPDATE domo_meeting_action SET actionDesc = '" + actionDetails.actionDesc + "', responsible = '" + actionDetails.responsible + "', openSince = '" + actionDetails.openSince + "', expectedCompletion = '" + actionDetails.expectedCompletion + "', actualCompletion = CURDATE() , status = '" + actionDetails.status + "' WHERE id = '" + actionId + "'", {
      type: sequelize.QueryTypes.UPDATE
    }).then(function(results) {
      sequelize.query(" INSERT INTO domo_tasklogs (task,onTable,meetingId,updatedBy,updatedDate) VALUES ('Update','domo_meeting_action','" + actionDetails.meetingId + "','" + userId + "',curdate())", {
        type: sequelize.QueryTypes.UPDATE
      }).then(function(results) {
        sequelize.query(" UPDATE domo_meeting_master SET generatedExcel = 0 WHERE meetingId = '" + meetingId + "'", {
          type: sequelize.QueryTypes.UPDATE
        }).then(function(results) {
          res.end();
        })
      })
    }).error(function(error) {
      console.log("Query Error: " + error);
    });
  } else {
    sequelize.query(" UPDATE domo_meeting_action SET actionDesc = '" + actionDetails.actionDesc + "', responsible = '" + actionDetails.responsible + "', openSince = '" + actionDetails.openSince + "', expectedCompletion = '" + actionDetails.expectedCompletion + "',actualCompletion = " + null + " ,status = '" + actionDetails.status + "' WHERE id = '" + actionId + "'", {
      type: sequelize.QueryTypes.UPDATE
    }).then(function(results) {
      sequelize.query(" INSERT INTO domo_tasklogs (task,onTable,meetingId,updatedBy,updatedDate) VALUES ('Update','domo_meeting_action','" + actionDetails.meetingId + "','" + userId + "',curdate())", {
        type: sequelize.QueryTypes.UPDATE
      }).then(function(results) {
        sequelize.query(" UPDATE domo_meeting_master SET generatedExcel = 0 WHERE meetingId = '" + meetingId + "'", {
          type: sequelize.QueryTypes.UPDATE
        }).then(function(results) {
          res.end();
        })
      })
    }).error(function(error) {
      console.log("Query Error: " + error);
    });
  }
};
