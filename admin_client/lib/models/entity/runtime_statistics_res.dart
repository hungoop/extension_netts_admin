
/*
    {"OperatingSystem":
    {"ThreadCount":1457,"Version":"10.15.7","DomainName":"",
    "Ipv4DefaultGateway":"192.168.1.1","Manufacturer":"Apple","Family":"macOS",
    "DnsServers":["8.8.8.8","1.1.1.1"],"ProcessId":64924,
    "HostName":"Huynhs-MacBook-Pro.local","Ipv6DefaultGateway":"fe80::1",
    "ProcessCount":650},

    "DiskStoreLst":[{"Serial":"","Size":5.00277792768e11,"CurrentQueueLength":0,
    "Model":"APPLE SSD AP0512N","Writes":1051701,"Name":"disk0",
    "Reads":1433971},{"Serial":"","Size":3.7300047872e11,
    "CurrentQueueLength":0,"Model":"APPLE SSD AP0512N",
    "Writes":1051701,"Name":"disk1","Reads":1432873}],
    "AVAILABLE_PRO":12,
    "USED_MEM":3.5862144e7,

    "GlobalMemory":{"PageSize":4096,"Total":1.7179869184e10,"Available":4.699574272e9},

    "MAX_MEM":3.817865216e9,

    "ProcessorIdentifier":{"Stepping":"10","Microarchitecture":"Coffee Lake",
    "PhysicalProcessorCount":6,"Model":"158","Family":"6","PhysicalPackageCount":1,
    "Vendor":"GenuineIntel","LogicalProcessorCount":12,"VendorFreq":2.6e9,
    "isCpu64bit":true,"Name":"Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz"},
    "TOTAL_MEM":2.57425408e8,"CPU":0,"FREE_MEM":2.21563264e8,"THREAD":44,

    "NetworkInfoLst":[{"PacketsSent":0,"Speed":0,"PacketsRecv":0,
    "IPv6addr":["fe80:0:0:0:44c2:ccff:feab:317a"],"DisplayName":"llw0",
    "IfAlias":"","IPv4addr":[],"BytesSent":0,"BytesRecv":0},
    {"PacketsSent":4,"Speed":1.0e7,"PacketsRecv":0,
    "IPv6addr":["fe80:0:0:0:44c2:ccff:feab:317a"],"DisplayName":"awdl0",
    "IfAlias":"","IPv4addr":[],"BytesSent":0,"BytesRecv":0},
    {"PacketsSent":7493,"Speed":1.0e8,"PacketsRecv":7436,
    "IPv6addr":["fe80:0:0:0:aede:48ff:fe00:1122"],"DisplayName":"en5","IfAlias":"",
    "IPv4addr":[],"BytesSent":3963904,"BytesRecv":850944},
    {"PacketsSent":4400,"Speed":1.0e8,"PacketsRecv":2479,
    "IPv6addr":["fe80:0:0:0:c61:134c:2c02:7141"],"DisplayName":"en8",
    "IfAlias":"","IPv4addr":["169.254.104.143"],"BytesSent":1273856,
    "BytesRecv":829440},{"PacketsSent":974189,"Speed":5.395e7,
    "PacketsRecv":585365,"IPv6addr":["2402:800:62b9:667d:99be:90c0:e80a:f116",
    "2402:800:62b9:667d:4a3:332a:183f:43b8","fe80:0:0:0:1cba:749e:4416:6422"],
    "DisplayName":"Wi-Fi","IfAlias":"","IPv4addr":["192.168.1.3"],
    "BytesSent":1.15446784e8,"BytesRecv":7.11440384e8}]}}
 */
import 'dart:convert';

class RStatisticsRes{
  int usedMemory;
  int maxMemory;
  int freeMemory;
  int totalMemory;
  int threadRunning;
  int cpuUsage;

  Map<String, dynamic> cpuInfo;
  Map<String, dynamic> memoryInfo;
  List<dynamic> diskInfo;
  Map<String, dynamic> osInfo;
  List<dynamic> networkInfo;

  RStatisticsRes({
    required this.usedMemory,
    required this.maxMemory,
    required this.freeMemory,
    required this.totalMemory,
    required this.threadRunning,
    required this.cpuUsage,

    required this.cpuInfo,
    required this.memoryInfo,
    required this.diskInfo,
    required this.osInfo,
    required this.networkInfo
  });

  factory RStatisticsRes.fromJson(dynamic json){
    return RStatisticsRes(
      usedMemory: json["USED_MEM"],
      maxMemory: json["MAX_MEM"],
      freeMemory: json["FREE_MEM"],
      totalMemory: json["TOTAL_MEM"],
      threadRunning: json["THREAD"],
      cpuUsage: json["CPU"],

      cpuInfo: json["ProcessorIdentifier"],
      memoryInfo: json["GlobalMemory"],
      diskInfo: json["DiskStoreLst"],
      osInfo: json["OperatingSystem"],
      networkInfo: json["NetworkInfoLst"],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['usedMemory'] = this.usedMemory;
    map['maxMemory'] = this.maxMemory;
    map['freeMemory'] = this.freeMemory;
    map['totalMemory'] = this.totalMemory;
    map['threadRunning'] = this.threadRunning;
    map['cpuUsage'] = this.cpuUsage;

    map['cpuInfo'] = this.cpuInfo;
    map['memoryInfo'] = this.memoryInfo;
    map['diskInfo'] = this.diskInfo;
    map['osInfo'] = this.osInfo;
    map['networkInfo'] = this.networkInfo;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}