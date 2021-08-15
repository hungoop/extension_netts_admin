import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:flutter/material.dart';

class AccountView {
  final AccountRes res;

  bool choose;

  AccountView(this.res, {this.choose = false});

  Widget viewInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Application.PADDING_ALL,
              right: Application.PADDING_ALL,
              top: Application.PADDING_ALL
          ),
          child: Text('id: ${this.res.id}'),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Application.PADDING_ALL,
            right: Application.PADDING_ALL,
          ),
          child: Text('name: ${this.res.name}'),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Application.PADDING_ALL,
            right: Application.PADDING_ALL,
          ),
          child: Text('zoneName: ${this.res.data.zoneName}'),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Application.PADDING_ALL,
            right: Application.PADDING_ALL,
          ),
          child: Text('privilege: ${this.res.privilege.getName()}'),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Application.PADDING_ALL,
            right: Application.PADDING_ALL,
          ),
          child: Text('type: ${this.res.data.type.getName()}'),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Application.PADDING_ALL,
            right: Application.PADDING_ALL,
          ),
          child: Text('role: ${this.res.role}'),
        ),
        viewMap(
            this.res.data.cmd,
            title: 'cmd (${this.res.data.cmd.length})'
        ),
        Divider(color: AppTheme.currentTheme.color,)
      ],
    );
  }

  Widget viewList(List<dynamic> data, {String title = ''}){
    return ExpansionTile(
      title: Text('$title'),
      children: data.map((e) {
        return AppListTitle(
          title: '$e',
        );
      }).toList(),
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