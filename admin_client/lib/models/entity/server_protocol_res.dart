import 'dart:convert';

import 'package:admin_client/utils/util_logger.dart';
/*
[{
"isTerminatedMaster":false,
"isShutdownMaster":false,
"isShutdownSlave":false,
"serverName":"0:0:0:0:0:0:0:0",
"isShuttingDownSlave":false,
"bootstrap":"ServerBootstrap(
ServerBootstrapConfig(
group: NioEventLoopGroup,
channelFactory: ReflectiveChannelFactory(
NioServerSocketChannel.class),
options: {
SO_REUSEADDR=true,
SO_RCVBUF=2097152,
CONNECT_TIMEOUT_MILLIS=60,
ALLOCATOR=PooledByteBufAllocator(
directByDefault: true)
},
childGroup: NioEventLoopGroup, childOptions: {
SO_REUSEADDR=true,
SO_RCVBUF=8388608,
CONNECT_TIMEOUT_MILLIS=60,
ALLOCATOR=PooledByteBufAllocator(
directByDefault: true),
TCP_NODELAY=false,
SO_KEEPALIVE=false
},
childHandler: nett.server.st.netty.core.HttpServerInitializer@35a50a4c)
)",
"serverPort":8711,
"isShuttingDownMaster":false,
"isTerminatedSlave":false,
"extController":{
"queueSize":0,
"executorService":"java.util.concurrent.ThreadPoolExecutor@103f852[
Running,pool size = 8, active threads = 8, queued tasks = 0, completed tasks = 0
]",
"isTerminated":false,
"active":true,"threadId":1,
"threadPoolSize":8,
"threadEvenLoop":"1.",
"userCount":1,
"maxQueueSize":3000,
"name":"Ext-HTTP4x",
"id":1,
"remainingCapacity":3000,
"isShutdown":false},
"sysController":{
"queueSize":0,
"executorService":"java.util.concurrent.ThreadPoolExecutor@1f021e6c[
Running,pool size = 3, active threads = 3, queued tasks = 0, completed tasks = 0
]",
"isTerminated":false,
"active":true,
"threadId":1,
"threadPoolSize":2,
"threadEvenLoop":"1.",
"userCount":1,
"maxQueueSize":30000,
"name":"Sys-HTTP4x",
"id":0,"remainingCapacity":30000,
"isShutdown":false
},
"serverType":"nett.server.st.netty.GWSHTTPNetty4x",
"startTime":"Thu Aug 12 11:41:40 ICT 2021",
"serverAdress":"0:0:0:0:0:0:0:0",
"channelId":"3c22fbfffee6120a-000029b6-00000000-eee30d9caeba7500-421323e7"
},

{"isTerminatedMaster":false,"isShutdownMaster":false,"isShutdownSlave":false,
"serverName":"0:0:0:0:0:0:0:0","isShuttingDownSlave":false,
"bootstrap":"ServerBootstrap(ServerBootstrapConfig(group: NioEventLoopGroup,
channelFactory: ReflectiveChannelFactory(NioServerSocketChannel.class),
options: {SO_REUSEADDR=true, SO_RCVBUF=2097152, CONNECT_TIMEOUT_MILLIS=60,
ALLOCATOR=PooledByteBufAllocator(directByDefault: true)}, childGroup: NioEventLoopGroup,
childOptions: {SO_REUSEADDR=true, SO_RCVBUF=8388608, CONNECT_TIMEOUT_MILLIS=60,
ALLOCATOR=PooledByteBufAllocator(directByDefault: true), TCP_NODELAY=false,
SO_KEEPALIVE=false}, childHandler: nett.server.st.netty.core.SSLHttpServerInitializer@595b007d))",
"serverPort":9711,"isShuttingDownMaster":false,"isTerminatedSlave":false,
"extController":{"queueSize":0,"executorService":"java.util.concurrent.ThreadPoolExecutor@2d7275fc[Running,
 pool size = 8, active threads = 8, queued tasks = 0, completed tasks = 0]",
 "isTerminated":false,"active":true,"threadId":1,"threadPoolSize":8,"threadEvenLoop":"1.",
 "userCount":1,"maxQueueSize":3000,"name":"SSLExt-SSLHTTP4x","id":1,
 "remainingCapacity":3000,"isShutdown":false},"sysController":{"queueSize":0,
 "executorService":"java.util.concurrent.ThreadPoolExecutor@72d1ad2e[Running,
 pool size = 3, active threads = 3, queued tasks = 0, completed tasks = 0]",
 "isTerminated":false,"active":true,"threadId":1,"threadPoolSize":2,"threadEvenLoop":"1.",
 "userCount":1,"maxQueueSize":30000,"name":"SSLSys-SSLHTTP4x","id":0,
 "remainingCapacity":30000,"isShutdown":false},"serverType":"nett.server.st.netty.GWSSSLHTTPNetty4x",
 "startTime":"Thu Aug 12 11:41:40 ICT 2021","serverAdress":"0:0:0:0:0:0:0:0",
 "channelId":"3c22fbfffee6120a-000029b6-00000001-1b397c94aeba7615-54e54078"},
 {"isTerminatedMaster":false,"isShutdownMaster":false,"isShutdownSlave":false,
 "serverName":"0:0:0:0:0:0:0:0","isShuttingDownSlave":false,
 "bootstrap":"ServerBootstrap(ServerBootstrapConfig(group: NioEventLoopGroup,
 channelFactory: ReflectiveChannelFactory(NioServerSocketChannel.class), options:
 {SO_REUSEADDR=true, SO_RCVBUF=1048576, CONNECT_TIMEOUT_MILLIS=60,
 ALLOCATOR=PooledByteBufAllocator(directByDefault: true)}, childGroup:
 NioEventLoopGroup, childOptions: {SO_REUSEADDR=true, SO_RCVBUF=1048576,
 CONNECT_TIMEOUT_MILLIS=60, TCP_NODELAY=true, SO_LINGER=100, SO_KEEPALIVE=true},
 childHandler: nett.server.st.netty.core.WebSocketServerInitializer@692f203f))",
 "serverPort":8722,"isShuttingDownMaster":false,"isTerminatedSlave":false,
 "extController":{"queueSize":0,"executorService":"java.util.concurrent.ThreadPoolExecutor@7b2bbc3[Running,
 pool size = 5, active threads = 5, queued tasks = 0, completed tasks = 0]",
 "isTerminated":false,"active":true,"threadId":1,"threadPoolSize":4,"threadEvenLoop":"1.",
 "userCount":1,"maxQueueSize":1000,"name":"Ext-WSOCKET4x","id":1,"remainingCapacity":1000,
 "isShutdown":false},"sysController":{"queueSize":0,"executorService":"java.util.concurrent.ThreadPoolExecutor@48f2bd5b[Running,
 pool size = 3, active threads = 3, queued tasks = 0, completed tasks = 0]",
 "isTerminated":false,"active":true,"threadId":1,"threadPoolSize":2,"threadEvenLoop":"1.",
 "userCount":1,"maxQueueSize":20000,"name":"Sys-WSOCKET4x","id":0,"remainingCapacity":20000,
 "isShutdown":false},"serverType":"nett.server.st.netty.GWSWebsocketNetty4x",
 "startTime":"Thu Aug 12 11:41:40 ICT 2021","serverAdress":"0:0:0:0:0:0:0:0",
 "channelId":"3c22fbfffee6120a-000029b6-00000002-07110664aeba7628-69857438"},
 {"isTerminatedMaster":false,"isShutdownMaster":false,"isShutdownSlave":false,
 "serverName":"0:0:0:0:0:0:0:0","isShuttingDownSlave":false,
 "bootstrap":"ServerBootstrap(ServerBootstrapConfig(group: NioEventLoopGroup,
 channelFactory: ReflectiveChannelFactory(NioServerSocketChannel.class),
 options: {SO_REUSEADDR=true, SO_RCVBUF=1048576, CONNECT_TIMEOUT_MILLIS=60,
 ALLOCATOR=PooledByteBufAllocator(directByDefault: true)}, childGroup: NioEventLoopGroup,
 childOptions: {SO_REUSEADDR=true, SO_RCVBUF=1048576, CONNECT_TIMEOUT_MILLIS=60,
 TCP_NODELAY=true, SO_LINGER=100, SO_KEEPALIVE=true},
 childHandler: nett.server.st.netty.core.SSLWebSocketServerInitializer@76505305))",
 "serverPort":9722,"isShuttingDownMaster":false,"isTerminatedSlave":false,
 "extController":{"queueSize":0,"executorService":"java.util.concurrent.ThreadPoolExecutor@77888435[Running,
 pool size = 4, active threads = 4, queued tasks = 0, completed tasks = 0]",
 "isTerminated":false,"active":true,"threadId":1,"threadPoolSize":4,"threadEvenLoop":"1.",
 "userCount":1,"maxQueueSize":1000,"name":"SSLExt-SSLWSOCKET4x","id":1,
 "remainingCapacity":1000,"isShutdown":false},"sysController":{"queueSize":0,
 "executorService":"java.util.concurrent.ThreadPoolExecutor@14cd1699[Running,
 pool size = 3, active threads = 3, queued tasks = 0, completed tasks = 0]",
 "isTerminated":false,"active":true,"threadId":1,"threadPoolSize":2,"threadEvenLoop":"1.",
 "userCount":1,"maxQueueSize":20000,"name":"SSLSys-SSLWSOCKET4x","id":0,
 "remainingCapacity":20000,"isShutdown":false},"serverType":"nett.server.st.netty.GWSSSLWebsocketNetty4x",
 "startTime":"Thu Aug 12 11:41:40 ICT 2021","serverAdress":"0:0:0:0:0:0:0:0",
 "channelId":"3c22fbfffee6120a-000029b6-00000003-691979e4aeba762c-57751cea"}]}
 */

class ServerProtocolRes{
  Map<String, dynamic> property;

  ServerProtocolRes({
    required this.property
  });

  factory ServerProtocolRes.fromJson(dynamic json){
    UtilLogger.log('ServerProtocolRes.fromJson', '$json');
    return ServerProtocolRes(
      property: json,
    );
  }

  Map<String, dynamic> toJson(){
    //Map<String, dynamic> map = {};
    //map['PROPERTIES'] = this.property;
    return this.property;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  String getByKey(String keyProp){
    return '${this.property['$keyProp'] ?? ""}';
  }

}


enum TEAM_TYPE {
  UNKNOWN,//0
  GREEN,//1
  BLUE,//2
}

extension TEAM_TYPE_EXT on TEAM_TYPE {
  static TEAM_TYPE parse(int typeId){
    return TEAM_TYPE.values.firstWhere((element) {
      return element.getId() == typeId;
    }, orElse: () => TEAM_TYPE.UNKNOWN);
  }

  _eTypeId(TEAM_TYPE key){
    switch (key) {
      case TEAM_TYPE.UNKNOWN: {
        return 0;
      }
      case TEAM_TYPE.GREEN: {
        return 1;
      }
      case TEAM_TYPE.BLUE: {
        return 2;
      }
      default:{
        return 0;
      }
    }
  }

  _eTypeName(TEAM_TYPE key){
    switch (key) {
      case TEAM_TYPE.UNKNOWN: {
        return "UNKNOWN";
      }
      case TEAM_TYPE.GREEN: {
        return "GREEN";
      }
      case TEAM_TYPE.BLUE: {
        return "BLUE";
      }
      default:{
        return "UNKNOWN";
      }
    }
  }

  int getId(){
    return _eTypeId(this);
  }

  String getName(){
    return _eTypeName(this);
  }
}