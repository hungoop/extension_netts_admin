
/*
        {"allowAllIp":false,
        "allowAllHost":true,
        "ad_ips":[],
        "ad_hosts":[],
        "hosts":[],
        "words":[],
        "ips":["10.10.100.6","10.10.100.213","10.10.100.215"],
        "users":[]}}
*/
import 'dart:convert';

class BanRes{
  bool allowAllIp;
  bool allowAllHost;
  List<dynamic> adminIps;
  List<dynamic> adminHosts;
  List<dynamic> hosts;
  List<dynamic> ips;
  List<dynamic> words;
  List<dynamic> users;

  BanRes({
    required this.allowAllIp,
    required this.allowAllHost,
    required this.adminIps,
    required this.adminHosts,
    required this.hosts,
    required this.ips,
    required this.words,
    required this.users,
  });

  factory BanRes.fromJson(dynamic json){
    return BanRes(
      allowAllIp: json["allowAllIp"],
      allowAllHost: json["allowAllHost"],
      adminIps: json["adminIps"] ?? [],
      adminHosts: json["adminHosts"] ?? [],
      hosts: json["hosts"] ?? [],
      ips: json["ips"] ?? [],
      words: json["words"] ?? [],
      users: json["users"] ?? [],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['allowAllIp'] = this.allowAllIp;
    map['allowAllHost'] = this.allowAllHost;
    map['adminIps'] = this.adminIps;
    map['adminHosts'] = this.adminHosts;
    map['hosts'] = this.hosts;
    map['ips'] = this.ips;
    map['words'] = this.words;
    map['users'] = this.users;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}