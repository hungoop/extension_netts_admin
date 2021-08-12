import 'package:admin_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class ServerProtocolPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ServerProtocolPage();
  }

}

class _ServerProtocolPage extends State<ServerProtocolPage> {
  late ServerProtocolBloc _protocolBloc;

  @override
  void initState() {
    super.initState();

    _protocolBloc = BlocProvider.of<ServerProtocolBloc>(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Protocols'),
      ),
      body: SafeArea(
        child: BlocBuilder<ServerProtocolBloc, ServerProtocolState> (
            builder: (context, protocolState) {
              List<ServerProtocolView> dataViews = [];

              if(protocolState is ServerProtocolStateSuccess){
                dataViews = protocolState.views;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppConnectivity(),
                  if(dataViews.isEmpty)...[
                    Center(
                      child: Text(
                          'data not found!'
                      ),
                    )
                  ],
                  if(dataViews.isNotEmpty)...[
                    Expanded(
                        child: RefreshIndicator(
                          child: ListView.builder(
                            itemBuilder: (BuildContext buildContext, int index){
                              if (index >= dataViews.length) {
                                return Center(
                                  child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                                );
                              } else {
                                var data = dataViews[index];
                                return _createProtocolItem(data);
                              }
                            },
                            itemCount: dataViews.length,
                          ),
                          onRefresh: onRefreshEvents,
                        )
                    )
                  ]
                ],
              );

            }),
      ),
    );
  }

  Future<void> onRefreshEvents() async {
    UtilLogger.log('downloadEvents', 'downloadEvents');
    _protocolBloc.add(ServerProtocolEventFetched());
  }

  Widget _createProtocolItem(ServerProtocolView view){
    return view.viewInfo();
  }

}