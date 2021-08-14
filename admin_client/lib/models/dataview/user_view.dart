import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
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
  return '${this.res.uID}';
  }

  Widget viewInfo(){
    return Padding(
          padding: EdgeInsets.all(Application.PADDING_ALL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField('userName: ${this.title()}'),
              AppTextField('userID: ${this.subTitle()}'),
              AppTextField('sessionID: ${this.res.sessionID}'),
              AppTextField('isLoggedIn: ${this.res.isLoggedIn}'),
              AppTextField('isConnected: ${this.res.isConnected}'),
              AppTextField('playerID: ${this.res.playerID}'),
              AppTextField('joinRoons: ${this.res.joinRoons}'),
              AppTextField('isJoining: ${this.res.isJoining}'),
              AppTextField('hashCode: ${this.res.hashCode}'),
            ],
          )
      );

  }

}