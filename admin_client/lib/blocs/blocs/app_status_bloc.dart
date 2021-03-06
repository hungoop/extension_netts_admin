
import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/utils/utils.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppState> {
  AppStateBloc() : super(AppStateInitial());

  @override
  Stream<AppState> mapEventToState(AppStateEvent event) async* {
    var currState = state;

    try {
      if(currState is AppStateInitial){
        // ???
      }

      if (event is OnResume) {
        if(currState is Background){
          //Application.chatSocket?.forceCheckReConnect();
        }

        yield Active();
      }

      if (event is OnBackground) {
        yield Background();
      }

      if(event is OnLoginDoneNotify){

      }

    } catch (ex, stacktrace) {
      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );
    }

  }


}


