import 'package:admin_client/configs/application.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:flutter/material.dart';

class BanView {
  final BanRes res;

  bool choose;

  BanView(this.res, {this.choose = false});

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
          child: Text('allowAllHost: ${this.res.allowAllHost}'),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Application.PADDING_ALL,
              right: Application.PADDING_ALL,
          ),
          child: Text('allowAllIp: ${this.res.allowAllIp}'),
        ),
        viewMap(
            this.res.adminHosts,
            title: 'adminHosts (${this.res.adminHosts.length})'
        ),
        viewMap(
            this.res.adminIps,
            title: 'adminIps (${this.res.adminIps.length})'
        ),
        viewMap(
            this.res.hosts,
            title: 'hosts (${this.res.hosts.length})'
        ),
        viewMap(
            this.res.ips,
            title: 'ips (${this.res.ips.length})'
        ),
        viewMap(
            this.res.words,
            title: 'words (${this.res.words.length})'
        ),
        viewMap(
            this.res.users,
            title: 'users (${this.res.users.length})'
        ),

      ],
    );
  }

  Widget viewMap(List<dynamic> data, {String title = ''}){
    return ExpansionTile(
      title: Text('$title'),
      children: data.map((e) {
        return AppListTitle(
          title: '$e',
        );
      }).toList(),
    );
  }

}