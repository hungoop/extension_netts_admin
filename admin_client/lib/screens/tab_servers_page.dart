import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class TabServersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabServersPage();
  }

}

class _TabServersPage extends State<TabServersPage> {
  late TabServersBloc lobbyBloc;
  
  @override
  void initState() {
    super.initState();

    lobbyBloc = BlocProvider.of<TabServersBloc>(context);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TabServersBloc, TabLobbyState> (
            builder: (context, lobbyState) {
              List<ZoneConfigView> dataViews = [];

              if(lobbyState is TabLobbyStateSuccess){
                dataViews = lobbyState.views;
              }

              return Column(
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
                      child:
                        ListView.builder(
                          itemBuilder: (BuildContext buildContext, int index){
                            if (index >= dataViews.length) {
                              return Center(
                                child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                              );
                            } else {
                              var bif = dataViews[index];
                              return _createRoomItem(bif);
                            }
                          },
                          itemCount: dataViews.length,
                        )
                    )
                  ]
                ],
              );

            }),
      ),
    );
  }

  Widget _createRoomItem(ZoneConfigView view){
    return AppListTitle(
        title: view.title(),
        subtitle: view.subTitle(),
        onPressed: (){
          lobbyBloc.add(TabServersEventGoToZone(view.res));
        },
    );
  }

}