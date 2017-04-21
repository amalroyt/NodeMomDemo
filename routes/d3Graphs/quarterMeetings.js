var sequelize = require("../dbconfiguration").sequelize; //import sequelize database object

exports.quarterMeetingsData = function(req, res) {
  var quarterDates = JSON.parse(req.params.quarterDates);
  var startDateVal = quarterDates.startDate;
  var endDateVal = quarterDates.endDate;
  var startDate = startDateVal + ' 00:00:00';
  var endDate = endDateVal + ' 00:00:00';
  sequelize.query("SELECT Date_FORMAT(meetingDate,'%d-%m-%Y') as meetingDate FROM domo_meeting_master where meetingDate NOT IN('" + endDate + "') AND meetingDate BETWEEN '" + startDate + "' and '"+endDate +"'", {
    type: sequelize.QueryTypes.SELECT
  }).then(function(results) {
    res.format({
      json: function() {
        var arrDetails = [];
        var dataSet = [];
        var arrJan = [];
        var arrFeb = [];
        var arrMar = [];
        var arrApr = [];
        var arrMay = [];
        var arrJun = [];
        var arrJul = [];
        var arrAug = [];
        var arrSep = [];
        var arrOct = [];
        var arrNov = [];
        var arrDec = [];

        for (var i in results) {
          var monthDetails = results[i].meetingDate;
          var monthValue = Number(monthDetails.substring(monthDetails.lastIndexOf("-") - 2, monthDetails.lastIndexOf("-")));
          if (monthValue == 1) {
            arrJan.push({
              monthDetails
            });
          } else if (monthValue == 2) {
            arrFeb.push({
              monthDetails
            });

          } else if (monthValue == 3) {
            arrMar.push({
              monthDetails
            });

          } else if (monthValue == 4) {
            arrApr.push({
              monthDetails
            });

          } else if (monthValue == 5) {
            arrMay.push({
              monthDetails
            });

          } else if (monthValue == 6) {
            arrJun.push({
              monthDetails
            });

          } else if (monthValue == 7) {
            arrJul.push({
              monthDetails
            });

          } else if (monthValue == 8) {
            arrAug.push({
              monthDetails
            });

          } else if (monthValue == 9) {
            arrSep.push({
              monthDetails
            });

          } else if (monthValue == 10) {
            arrOct.push({
              monthDetails
            });

          } else if (monthValue == 11) {
            arrJan.push({
              monthDetails
            });
          } else if (monthValue == 12) {
            arrJan.push({
              monthDetails
            });
          }
        }

        arrDetails.push({
          arrJan: arrJan.length,
          arrFeb: arrFeb.length,
          arrMar: arrMar.length,
          arrApr: arrApr.length,
          arrMay: arrMay.length,
          arrJun: arrJun.length,
          arrJul: arrJul.length,
          arrAug: arrAug.length,
          arrSep: arrSep.length,
          arrOct: arrOct.length,
          arrNov: arrNov.length,
          arrDec: arrDec.length
        });

        if ( arrDetails[0].arrJan > 0)  {
          dataSet.push({count:arrDetails[0].arrJan,label:'January'});
        }
        if ( arrDetails[0].arrFeb > 0)  {
          dataSet.push({count:arrDetails[0].arrFeb,label:'February'});
        }
        if ( arrDetails[0].arrMar > 0)  {
          dataSet.push({count:arrDetails[0].arrMar,label:'March'});
        }
        if ( arrDetails[0].arrApr > 0)  {
          dataSet.push({count:arrDetails[0].arrApr,label:'April'});
        }
        if ( arrDetails[0].arrMay > 0)  {
          dataSet.push({count:arrDetails[0].arrMay,label:'May'});
        }
        if ( arrDetails[0].arrJun > 0)  {
          dataSet.push({count:arrDetails[0].arrJun,label:'June'});
        }
        if ( arrDetails[0].arrJul > 0)  {
          dataSet.push({count:arrDetails[0].arrJul,label:'July'});
        }
        if ( arrDetails[0].arrAug > 0)  {
          dataSet.push({count:arrDetails[0].arrAug,label:'August'});
        }
        if ( arrDetails[0].arrSep > 0)  {
          dataSet.push({count:arrDetails[0].arrSep,label:'September'});
        }
        if ( arrDetails[0].arrOct > 0)  {
          dataSet.push({count:arrDetails[0].arrOct,label:'October'});
        }
        if ( arrDetails[0].arrNov > 0)  {
          dataSet.push({count:arrDetails[0].arrNov,label:'November'});
        }
        if ( arrDetails[0].arrDec > 0)  {
          dataSet.push({count:arrDetails[0].arrDec,label:'December'});
        }
        
        res.send(dataSet);
      }
    });
  }).error(function(error) {
    console.log("Query Error: " + error);
  });
}
