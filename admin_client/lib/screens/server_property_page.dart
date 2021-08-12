import 'package:admin_client/language/languages.dart';
import 'package:admin_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class ServerPropertyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ServerPropertyPagePage();
  }

}

class _ServerPropertyPagePage extends State<ServerPropertyPage> {
  late ServerPropertyBloc _propertyBloc;

  @override
  void initState() {
    super.initState();

    _propertyBloc = BlocProvider.of<ServerPropertyBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      body: SafeArea(
        child: BlocBuilder<ServerPropertyBloc, ServerPropertyState> (
            builder: (context, propState) {
              ServerProtocolView? view;
              List<Widget> viewLst = [];

              if(propState is ServerPropertyStateSuccess) {
                view = propState.dataView;
                viewLst = view.viewLst();
              }

              return Column(
                children: [
                  AppConnectivity(),
                  if(view != null)...[
                    Expanded(
                      child: RefreshIndicator(
                          child: ListView.builder(
                            itemBuilder: (BuildContext buildContext, int index){
                              if (index >= viewLst.length) {
                                return Center(
                                  child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                                );
                              } else {
                                return viewLst[index];
                              }
                            },
                            itemCount: viewLst.length,
                          ),
                          onRefresh: onRefreshEvents
                      ),
                    )
                  ],
                ],
              );
            }),
      ),
    );
  }

  Future<void> onRefreshEvents() async {
    UtilLogger.log('downloadEvents', 'downloadEvents');
    _propertyBloc.add(ServerPropertyEventFetched());
  }
}