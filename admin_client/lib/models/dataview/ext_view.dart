import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:flutter/material.dart';

class ExtView {
  final ExtRes res;

  bool choose;

  ExtView(this.res, {this.choose = false});


  String title(){
    return res.zName;
  }

  String subTitle(){
    return 'ID:${this.res.zID} - isStopped:${this.res.isStopped}';
  }

  Widget viewInfo(){
    return Column(
      children: [
        Text('zID: ${this.res.zID}'),
        Text('zName: ${this.res.zName}'),
        Text('isStopped: ${this.res.isStopped}'),
        viewMap(this.res.eventHandler),
        viewMap(this.res.requestHandler),
        viewMap(this.res.cachedHandlers),
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