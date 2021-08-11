import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:admin_client/storage/storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await SharedData().setPreferences();

  runApp(EasyLocalization(
    startLocale: AppLanguage.defaultLocale,
    supportedLocales: AppLanguage.supportLanguage,
    path: 'assets/translations',
    //useOnlyLangCode: true,
    fallbackLocale: AppLanguage.defaultLocale, // AppLanguage.getSupportLocale(AppLanguage.defaultLocale),
    child: AdminToolApp(),
  ));
}
