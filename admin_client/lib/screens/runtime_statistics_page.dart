
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class RuntimeStatisticsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RuntimeStatisticsPage();
  }

}

class _RuntimeStatisticsPage extends State<RuntimeStatisticsPage> {
  late RStatisticsBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<RStatisticsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Runtime statistics'),
        actions: [
          IconButton(
            icon: Icon(
                Icons.refresh_outlined
            ),
            onPressed: () {
              _userBloc.add(RStatisticsEventFetched());
            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<RStatisticsBloc, RStatisticsState> (
            builder: (context, banState) {
              RStatisticsView? view;

              if(banState is RStatisticsStateSuccess) {
                view = banState.dataView;
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppConnectivity(),
                    if(view != null)...[
                      view.viewInfo()
                    ],
                  ],
                ),
              );
            }),
      ),
    );
  }
}