
import 'package:admin_client/blocs/blocs/ext_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/room_detail_page.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:admin_client/utils/utils.dart';

class RouteGenerator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static String currRouteScreen        = "";

  static Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) async {
    if(navigatorKey.currentState != null){
      await navigatorKey.currentState!.pushReplacementNamed(
          routeName, arguments: arguments
      );
    }
  }

  static Future<dynamic> pushNamedAndRemoveUntil(String newRouteName,
        RoutePredicate predicate,
        {Object? arguments}
      ) async {

    if(navigatorKey.currentState != null){
      await navigatorKey.currentState!.pushNamedAndRemoveUntil(
          newRouteName,
          predicate,
          arguments: arguments
      );
    }

  }

  static Future<void> pushNamed(String routeName, {Object? arguments}) async {
    if(navigatorKey.currentState != null){
      await navigatorKey.currentState!.pushNamed(
          routeName,
          arguments: arguments
      );
    }

  }

  static void pop(){
    if(navigatorKey.currentState != null){
      navigatorKey.currentState!.pop();
    }
  }

  static Future<bool?> maybePop() async {
    if(navigatorKey.currentState != null){
      return await navigatorKey.currentState!.maybePop("1");
    }
  }

  static void maybePopUntil(String screenShow) {
    if(navigatorKey.currentState != null && navigatorKey.currentState!.canPop()){
      navigatorKey.currentState!.popUntil(
              (Route<dynamic> route) {
                UtilLogger.log('maybePopUntil ==>> ', '$route');
                return route.settings.name == screenShow;
              }
      );
    }
  }

  static void popScreenCall() async {
    if(navigatorKey.currentState != null && navigatorKey.currentState!.canPop()){
      navigatorKey.currentState!.popUntil((Route<dynamic> route) {
            UtilLogger.log('maybePopUntil ==>> ', '$route');
            return  route.settings.name == ScreenRoutes.OPEN_ZONE || route.isFirst;
          }
      );
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.LOGIN: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_){
              return LoginPage();
            }
        );
      }
      case ScreenRoutes.THEME_OPTION: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_){
              return ThemeOptionPage();
            }
        );
      }
      case ScreenRoutes.FOND_SETTING: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_){
              return FontSettingPage();
            }
        );
      }
      case ScreenRoutes.CHANGE_LANGUAGE: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_){
              return LanguageOptionPage();
            }
        );
      }
      case ScreenRoutes.OPEN_ZONE: {
        var res = settings.arguments;
        if(res is ZoneConfigRes){
          return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              return BlocProvider<ZoneBloc>(
                create: (context) {
                  return ZoneBloc(res)
                    ..add(ZoneEventFetched());
                },
                child: ZonePage(),
              );
            });
        }

        return _errorRoute(settings);
      }
      case ScreenRoutes.OPEN_ROOM: {
        var res = settings.arguments;
        if(res is RoomRes){
          return MaterialPageRoute(
              settings: settings,
              builder: (_) {
                return BlocProvider<RoomBloc>(
                  create: (context) {
                    return RoomBloc(res)
                      ..add(RoomEventFetched());
                  },
                  child: RoomDetailPage(),
                );
              });
        }

        return _errorRoute(settings);
      }
      case ScreenRoutes.ADD_ROOM: {
        var res = settings.arguments;
        if(res is RoomRes){
          return MaterialPageRoute(
              settings: settings,
              builder: (_) {
                return BlocProvider<RoomBloc>(
                  create: (context) {
                    return RoomBloc(res)
                      ..add(RoomEventAddNew());
                  },
                  child: RoomDetailPage(),
                );
              });
        }

        return _errorRoute(settings);
      }
      case ScreenRoutes.OPEN_USER: {
        var res = settings.arguments;
        if(res is UserView){
          return MaterialPageRoute(
              settings: settings,
              builder: (_) {
                return BlocProvider<UserBloc>(
                  create: (context) {
                    return UserBloc(res)
                      ..add(UserEventFetched());
                  },
                  child: UserDetailPage(),
                );
              });
        }

        return _errorRoute(settings);
      }
      case ScreenRoutes.OPEN_EXT: {
        var res = settings.arguments;
        if(res is ZoneRes){
          return MaterialPageRoute(
              settings: settings,
              builder: (_) {
                return BlocProvider<ExtManagerBloc>(
                  create: (context) {
                    return ExtManagerBloc(res)
                      ..add(ExtEventFetched());
                  },
                  child: ExtManagerPage(),
                );
              });
        }

        return _errorRoute(settings);
      }
      case ScreenRoutes.SERVER_PROPERTY: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              return BlocProvider<ServerPropertyBloc>(
                create: (context) {
                  return ServerPropertyBloc()
                    ..add(ServerPropertyEventFetched());
                },
                child: ServerPropertyPage(),
              );
            });
      }
      case ScreenRoutes.SERVER_PROTOCOL: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              return BlocProvider<ServerProtocolBloc>(
                create: (context) {
                  return ServerProtocolBloc()
                    ..add(ServerProtocolEventFetched());
                },
                child: ServerProtocolPage(),
              );
            });
      }
      default:
        return _errorRoute(settings);
    }

  }

  static Route<dynamic> _errorRoute(RouteSettings settings){
    UtilLogger.recordError(
        settings,
        reason: 'errorRoute, DATA input open  screen is null or wrong'
    );

    return MaterialPageRoute(
    settings: settings,
      builder: (_) {
        return  BlocProvider<SplashScreenBloc> (
          create: (context) {
            return SplashScreenBloc()..add(
                SplashScreenEventShowMessage(
                    message: '${AppLanguage().translator(
                        LanguageKeys.ERROR_DATA_INPUT_WRONG
                    )}, ${settings.name}'
                )
            );
          },
          child: SplashPage(),
        );
      }
    );
  }

  static bool isScreen(String routeName){
    if (currRouteScreen == routeName){
      return true;
    }
    return false;
  }

  static Widget? currentWidget(){
    return navigatorKey.currentWidget;
  }

  static void toPrint() {
    UtilLogger.log('currentContext', '${navigatorKey.currentContext}');
    UtilLogger.log('currentWidget', '${currentWidget()}');
    UtilLogger.log('currentState', '${navigatorKey.currentState}');
    UtilLogger.log('currRouteScreen', '$currRouteScreen');
  }

}