import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/storage/storage.dart';
import 'package:admin_client/utils/utils.dart';


class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(InitialLanguageState());

  @override
  Stream<LanguageState> mapEventToState(event) async* {
    try {
      if (event is OnChangeLanguage) {
        print('OnChangeLanguage  ${event.locale.languageCode} - ${event.locale.countryCode}');
        //Save language code and country code like format: vi, vi_VN
        ///Preference save
        if (!Utils.checkDataEmpty(event.locale.countryCode)) {
          SharedData().setString(
              Preferences.languageCode,
              event.locale.countryCode!
          );
        }
        else {
          SharedData().setString(Preferences.languageCode, '');
          SharedData().setString(Preferences.language, event.locale.languageCode);
        }
        print('Change language to : ${SharedData().getString(Preferences.language)} - ${SharedData().getString(Preferences.languageCode)}');

        AppLanguage.defaultLocale= AppLanguage.getSupportLocale();

        yield LanguageUpdated();
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