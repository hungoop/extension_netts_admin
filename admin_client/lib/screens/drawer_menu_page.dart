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
              child: Text('User: root')
          ),
          AppListTitle(
            title: 'Server Property',
            onPressed: (){
              RouteGenerator.pop();

              RouteGenerator.pushNamed(
                  ScreenRoutes.SERVER_PROPERTY
              );
            },
          ),
          AppListTitle(
            title: 'Server protocol',
            onPressed: (){
              RouteGenerator.pop();

              RouteGenerator.pushNamed(
                  ScreenRoutes.SERVER_PROTOCOL
              );
            },
          ),
          AppListTitle(
              title: 'Ban manager',
            onPressed: (){
              RouteGenerator.pop();
            },
          ),
          AppListTitle(
            title: 'Admin manager',
            onPressed: () {
              RouteGenerator.pop();
            },
          )
        ],
      ),
    );
  }
  
}