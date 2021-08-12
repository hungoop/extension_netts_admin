
/*
    {
    "server.path.extension.config.folder":"\/nettserver\/extprop\/",
    "server.path.config.zones.folder":"\/nettserver\/zone\/",
    "db.sqlserver.sqlRead.maxPoolSize":"50",
    "server.tcp.ip.websocket.ssl":"0.0.0.0",
    "db.sqlserver.sqlRead.username":"TestUser",
    "db.sqlserver.sqlClassName":"com.microsoft.sqlserver.jdbc.SQLServerDriver",
    "server.shutdown.delay":"500",
    "server.websocket.app.name":"\/",
    "server.tcp.ip.websocket":"0.0.0.0",
    "server.extcontroller.id":"1",
    "db.sqlserver.sqlRead.url":"jdbc:sqlserver:\/\/217.0.0.1;databaseName=xxx",
    "server.path.extension.jar.folder":"\/nettserver\/extensions\/",
    "server.syscontroller.evenloop":"1",
    "server.syscontroller.id":"0",
    "server.extcontroller.queuesize":"1000",
    "server.tcp.ip.flash.policy":"0.0.0.0",
    "server.tcp.port.rtmp":"1935",
    "db.sqlserver.sqlRead.partitionCount":"2",
    "db.sqlserver.sqlWrite.username":"TestUser",
    "server.syscontroller.poolsize":"2",
    "db.sqlserver.sqlWrite.isCaching":"false",
    "server.client.connectiontimeout":"60",
    "server.tcp.ip.http":"0.0.0.0",
    "server.extcontroller.evenloop":"1",
    "server.run.protocol.http.ssl":"true",
    "server.ssl.certificate.password":"66617006",
    "server.syscontroller.queuesize":"20000",
    "server.http.extcontroller.evenloop":"1",
    "db.sqlserver.sqlRead.isCaching":"false",
    "server.http.extcontroller.queuesize":"3000",
    "server.tcp.ip.rtmp":"0.0.0.0",
    "db.sqlserver.sqlRead.connectionTimeOut":"200",
    "server.run.protocol.http":"true",
    "server.tcp.port.flash.policy":"843",
    "db.sqlserver.sqlWrite.url":"jdbc:sqlserver:\/\/127.0.0.1;
    databaseName=xxx","db.sqlserver.sqlWrite.maxSize":"500",
    "server.path.logs.folder":"..\/logs\/",
    "server.event.manager.threadKeepAliveTime":"60",
    "server.event.manager.corePoolSize":"2",
    "server.tcp.ip.http.ssl":"0.0.0.0",
    "db.sqlserver.sqlRead.minPoolSize":"5",
    "server.threads.executor.worker.http":"1",
    "server.run.protocol.websocket":"true",
    "server.run.protocol.rtmp":"false",
    "server.http.syscontroller.evenloop":"1",
    "db.sqlserver.sqlRead.maxSize":"500",
    "server.tcp.port.websocket":"8722",
    "server.run.protocol.websocket.ssl":"true",
    "server.http.syscontroller.queuesize":"30000",
    "server.threads.executor.worker.websocket":"1",
    "server.http.syscontroller.poolsize":"2",
    "server.event.manager.maxPoolSize":"4",
    "server.threads.executor.boss.http":"1",
    "server.media.client.maximum":"300",
    "db.sqlserver.sqlWrite.password":"Test123456!@#$%^",
    "server.tcp.port.websocket.ssl":"9722",
    "server.threads.executor.boss.websocket":"1",
    "db.sqlserver.sqlWrite.connectionTimeOut":"200",
    "db.sqlserver.sqlWrite.minPoolSize":"5",
    "server.extcontroller.poolsize":"4",
    "server.handler.is.media":"false",
    "server.tcp.port.http.ssl":"9711",
    "db.sqlserver.sqlWrite.partitionCount":"2",
    "db.sqlserver.sqlRead.password":"Test123456!@#$%^",
    "server.http.extcontroller.poolsize":"8",
    "server.run.protocol.flashpolicy":"false",
    "server.tcp.port.http":"8711",
    "db.sqlserver.sqlWrite.maxPoolSize":"50"
    }}
 */

import 'dart:convert';

class ServerPropertyRes {
  Map<String, dynamic> property;

  ServerPropertyRes({
    required this.property
  });

  factory ServerPropertyRes.fromJson(dynamic json){
    return ServerPropertyRes(
      property: json,
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['PROPERTIES'] = this.property;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  String getByKey(String keyProp){
    return '${this.property['$keyProp'] ?? ""}';
  }

}