import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';

class AppBloc {

  static final applicationBloc    = ApplicationBloc();
  static final authBloc           = AuthBloc();
  static final appStateBloc       = AppStateBloc();
  static final languageBloc       = LanguageBloc();
  static final themeBloc          = ThemeBloc();
  static final connectivityBloc   = AppConnectivityBloc();

  static final splashBloc         = SplashScreenBloc();
  static final loginBloc          = LoginBloc();
  static final settingBloc        = TabSettingBloc();
  static final gameBloc           = TabSessionsBloc();
  static final lobbyBloc          = TabServersBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<AppStateBloc>(
      create: (context) => appStateBloc,
    ),
    BlocProvider<LanguageBloc>(
      create: (context) => languageBloc,
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<AppConnectivityBloc>(
      create: (context) => connectivityBloc,
    ),
    BlocProvider<SplashScreenBloc>(
      create: (context) => splashBloc,
    ),
    BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
    ),
    BlocProvider<TabSettingBloc>(
      create: (context) => settingBloc,
    ),
    BlocProvider<TabSessionsBloc>(
      create: (context) => gameBloc,
    ),
    BlocProvider<TabServersBloc>(
      create: (context) => lobbyBloc,
    ),
  ];

  static void dispose(){
    applicationBloc.close();
    authBloc.close();
    appStateBloc.close();
    languageBloc.close();
    themeBloc.close();
    connectivityBloc.close();
    splashBloc.close();
    loginBloc.close();
    settingBloc.close();
    gameBloc.close();
    lobbyBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}