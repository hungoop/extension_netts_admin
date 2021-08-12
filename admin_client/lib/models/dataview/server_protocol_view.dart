import 'package:admin_client/models/entity/entity.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:flutter/material.dart';

class ServerProtocolView {
  final ServerProtocolRes res;

  bool choose;

  ServerProtocolView(this.res, {this.choose = false});

  String title(){
    return '${res.getByKey('serverName')}:${res.getByKey('serverPort')}' ;
  }

  String subTitle(){
    return res.getByKey('serverType');
  }

  Widget viewInfo(){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
              '${this.title()}'
          ),
          Text(
              '${this.subTitle()}'
          ),
          viewMap(res.property, title: res.getByKey('startTime'))
        ],
      )
    );

  }

  Widget viewMap(Map<String, dynamic> data, {String title = ''}){
    return ExpansionTile(
      title: Text('$title'),
      children: data.keys.map((e) {
        return AppListTitle(
          title: '$e',
          subtitle: '${data[e]}',
        );
      }).toList(),
    );
  }

  List<Widget> viewLst(){
    return res.property.keys.map((e) {
      return AppListTitle(
        title: '$e',
        subtitle: '${res.getByKey(e)}',
      );
    }).toList();
  }

}