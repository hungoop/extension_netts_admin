
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class BanManagerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BanManagerPage();
  }

}

class _BanManagerPage extends State<BanManagerPage> {
  late BanManagerBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<BanManagerBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ban detail'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh_outlined
            ),
            onPressed: () {
              _userBloc.add(BanManagerEventFetched());
            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<BanManagerBloc, BanManagerState> (
            builder: (context, banState) {
              BanView? view;

              if(banState is BanManagerStateSuccess) {
                view = banState.dataView;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
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