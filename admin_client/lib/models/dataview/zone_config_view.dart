import 'package:admin_client/models/models.dart';

class ZoneConfigView {
  final ZoneConfigRes res;

  bool choose;

  ZoneConfigView(this.res, {this.choose = false});

  String title(){
    return res.zName;
  }

  String subTitle(){
    return '${this.res.zPath}';
  }

}