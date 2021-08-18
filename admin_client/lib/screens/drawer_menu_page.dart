import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:flutter/material.dart';

class DrawerMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginStorage? store = LoginStorage.read();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: Application.SIZE_ICON_AVATAR,
                    ),
                  ),
                  if(store != null)...[
                    AppTextField('User: ${store.identification}')
                  ],
                  if(store != null)...[
                    Text(
                      'token: ${store.token}',
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                    )
                  ]
                ],
              )
          ),
          AppListTitle(
            title: 'Runtime statistics',
            onPressed: () {
              RouteGenerator.pushNamed(
                  ScreenRoutes.RUNTIME_STATISTICS
              );
            },
          ),
          AppListTitle(
            title: 'Server Property',
            onPressed: (){
              RouteGenerator.pushNamed(
                  ScreenRoutes.SERVER_PROPERTY
              );
            },
          ),
          AppListTitle(
            title: 'Server protocol',
            onPressed: (){
              RouteGenerator.pushNamed(
                  ScreenRoutes.SERVER_PROTOCOL
              );
            },
          ),
          AppListTitle(
              title: 'Ban manager',
            onPressed: (){
              RouteGenerator.pushNamed(
                  ScreenRoutes.BAN_MANAGER
              );
            },
          ),
          AppListTitle(
            title: 'Admin manager',
            onPressed: () {
              RouteGenerator.pop();

              RouteGenerator.pushNamed(
                  ScreenRoutes.ACCOUNT_MANAGER
              );
            },
          ),
          AppListTitle(
            title: 'Logout',
            onPressed: () {
              AppBloc.authBloc.add(OnClear());
              RouteGenerator.pop();
            },
          ),
          AppListTitle(
            title: 'Close',
            onPressed: () {
              RouteGenerator.pop();
            },
          ),
        ],
      ),
    );
  }
  
}