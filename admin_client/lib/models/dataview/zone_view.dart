import 'package:admin_client/models/models.dart';

class ZoneView{
  final ZoneRes res;

  bool choose;

  ZoneView(this.res, {this.choose = false});

  String title(){
    return res.zName;
  }

  String subTitle(){
    return '${this.res.zID}';
  }

}