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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('zID: ${this.res.zID}'),
        Text('zName: ${this.res.zName}'),
        Text('isStopped: ${this.res.isStopped}'),
        viewMap(
            this.res.eventHandler,
            title: 'System handler (${this.res.eventHandler.length})'
        ),
        viewMap(
            this.res.requestHandler,
            title: 'Extension handler (${this.res.requestHandler.length})'
        ),
        viewMap(
            this.res.cachedHandlers,
            title: 'Cached handlers (${this.res.cachedHandlers.length})'
        ),
      ],
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

}