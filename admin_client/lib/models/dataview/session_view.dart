import 'package:admin_client/models/models.dart';

class SessionView {
  final SessionRes res;

  bool choose;

  SessionView(this.res, {this.choose = false});

  String title(){
    return '${res.sName} - ${res.zoneName}';
  }

  String subTitle(){
    return 'ID:${this.res.sID} - session:${this.res.sessionID}';
  }

}