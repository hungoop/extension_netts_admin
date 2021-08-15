
import 'package:admin_client/configs/application.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:admin_client/utils/utils.dart';
import 'package:flutter/material.dart';

class RStatisticsView {
  final RStatisticsRes res;

  bool choose;

  RStatisticsView(this.res, {this.choose = false});

  String usedMemory(){
    return Utils.convertBytesToSize(
        this.res.usedMemory,
        2
    );
  }

  String freeMemory(){
    return Utils.convertBytesToSize(
        this.res.freeMemory,
        2
    );
  }

  String maxMemory(){
    return Utils.convertBytesToSize(
        this.res.maxMemory,
        2
    );
  }

  String totalMemory(){
    return Utils.convertBytesToSize(
        this.res.totalMemory,
        2
    );
  }

  Widget viewInfo(){
    return Padding(
      padding: EdgeInsets.only(
          left: Application.PADDING_ALL,
          right: Application.PADDING_ALL,
          top: Application.PADDING_ALL
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField('Used memory: ${this.usedMemory()}'),
          AppTextField('Free memory: ${this.freeMemory()}'),
          AppTextField('Max memory: ${this.maxMemory()}'),
          AppTextField('Total memory: ${this.totalMemory()}'),
          AppTextField('Thread running: ${this.res.threadRunning}'),
          AppTextField('CPU running: ${this.res.cpuUsage}'),
          viewMap(
              this.res.cpuInfo,
              title: 'cpuInfo (${this.res.cpuInfo.length})'
          ),
          viewMap(
              this.res.memoryInfo,
              title: 'memoryInfo (${this.res.memoryInfo.length})'
          ),
          viewMap(
              this.res.osInfo,
              title: 'osInfo (${this.res.osInfo.length})'
          ),
          viewList(
              this.res.diskInfo,
              title: 'diskInfo'
          ),
          viewList(
              this.res.networkInfo,
              title: 'networkInfo'
          )
        ],
      )
    );
  }

  Widget viewList(List<dynamic> data, {String title = ''}){
    return ExpansionTile(
      title: Text('$title (${data.length})'),
      children: data.map((e) {
        return viewMap(e, title: title);
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