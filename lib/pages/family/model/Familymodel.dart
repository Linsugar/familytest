import 'dart:convert';

class Familymodel{
  var teamUid;
  var teamName;
  var teamInit;
  var teamInitid;
  var teamType;
  var teamSize;
  var teamRank;
  var teamCover;
  var teamIntroduction;
  var teamCity;
  var teamlevel;
  var teamScore;
  var teamSex;
  var teamTime;
  Familymodel(value){
    teamUid =value['Team_uid'];
    teamName =value['Team_name'];
    teamInit =value['Team_init'];
    teamInitid =value['Team_initid'];
    teamType =value['Team_Type'];
    teamSize =value['Team_Size'];
    teamRank =value['Team_Rank'];
    teamCover =json.decode(value['Team_Cover']);
    teamIntroduction =value['Team_Introduction'];
    teamCity =value['Team_City'];
    teamlevel =value['Team_level'];
    teamScore =value['Team_Score'];
    teamSex =value['Team_sex'];
    teamTime =value['Team_time'];
  }
}