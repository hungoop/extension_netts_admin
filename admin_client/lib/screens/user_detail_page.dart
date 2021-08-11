import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class UserDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserDetailPage();
  }

}

class _UserDetailPage extends State<UserDetailPage> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User detail'),
      ),
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState> (
            builder: (context, gameState) {
              UserView? view;

              if(gameState is UserStateSuccess) {
                view = gameState.dataView;
              }

              return Column(
                children: [
                  AppConnectivity(),
                  if(view != null)...[
                    view.viewInfo()
                  ],
                ],
              );
            }),
      ),
    );
  }
}