import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:flutter/material.dart';

class ServerPropertyView {
  final ServerPropertyRes res;
  int roomID;

  bool choose;

  ServerPropertyView(this.res, {this.choose = false, this.roomID = -1});


  String title(){
    return res.getByKey('server.extcontroller.poolsize');
  }

  String subTitle(){
    return res.getByKey('server.extcontroller.queuesize');
  }

  Widget viewInfo(){
    return Column(
      children: [
        Text('${this.title()}'),
        Text('${this.subTitle()}'),
        viewMap(res.property)
      ],
    );
  }

  Widget viewMap(Map<String, dynamic> data){
    return Column(
      children: data.keys.map((e) {
        return AppListTitle(
          title: '$e',
          subtitle: '${data[e]}',
        );
      }).toList(),
    );
  }

}