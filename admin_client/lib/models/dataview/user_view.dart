import 'package:admin_client/models/models.dart';
import 'package:flutter/material.dart';

class UserView {
  final UserRes res;
  int roomID;

  bool choose;

  UserView(this.res, {this.choose = false, this.roomID = -1});


  String title(){
  return res.uName;
  }

  String subTitle(){
  return 'ID:${this.res.uID} - session:${this.res.sessionID}';
  }

  Widget viewInfo(){
    return Column(
      children: [
        Text('${this.title()}'),
        Text('${this.subTitle()}'),
        Text('sessionID: ${this.res.sessionID}'),
        Text('isLoggedIn: ${this.res.isLoggedIn}'),
        Text('isConnected: ${this.res.isConnected}'),
        Text('playerID: ${this.res.playerID}'),
        Text('joinRoons: ${this.res.joinRoons}'),
        Text('isJoining: ${this.res.isJoining}'),
        Text('hashCode: ${this.res.hashCode}'),
      ],
    );
  }

}