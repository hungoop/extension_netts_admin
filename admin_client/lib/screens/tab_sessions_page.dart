import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class TabSessionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabSessionsPage();
  }

}

class _TabSessionsPage extends State<TabSessionsPage> {
  late TabSessionsBloc _tabUserBloc;

  @override
  void initState() {
    _tabUserBloc = BlocProvider.of<TabSessionsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TabSessionsBloc, TabUserState> (
            builder: (context, userState) {
              List<SessionView> dataViews = [];

              if(userState is TabUserStateSuccess){
                dataViews = userState.views;
              }

              return Column(
                children: [
                  AppConnectivity(),
                  if(dataViews.isEmpty)...[
                    Center(
                      child: Text(
                          'User - data not found!'
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
                              return _createUserItem(bif);
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

  Widget _createUserItem(SessionView view){
    return AppListTitle(
      title: view.title(),
      subtitle: view.subTitle(),
      onPressed: (){
        _tabUserBloc.add(TabSessionsEventJoinRoom(view.res));
      },
    );
  }

}