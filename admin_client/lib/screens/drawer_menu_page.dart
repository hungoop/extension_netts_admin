import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:flutter/material.dart';

class DrawerMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  Text('User: root')
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