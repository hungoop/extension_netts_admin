import 'package:admin_client/utils/util_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TabSessionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabSessionsPage();
  }

}

class _TabSessionsPage extends State<TabSessionsPage> {
  late TabSessionsBloc _tabSessionsBloc;
  final SlidableController slidableController = SlidableController();

  @override
  void initState() {
    _tabSessionsBloc = BlocProvider.of<TabSessionsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connections'),
      ),
      body: SafeArea(
        child: BlocBuilder<TabSessionsBloc, TabSessionsState> (
            builder: (context, userState) {
              List<SessionView> dataViews = [];

              if(userState is TabSessionsStateSuccess){
                dataViews = userState.views;
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
                        child: RefreshIndicator(
                          onRefresh: downloadEvents,
                          child: ListView.builder(
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

                          ),
                        )
                    )
                  ]
                ],
              );

            }),
      ),
    );

  }

  Future<void> downloadEvents() async {
    UtilLogger.log('downloadEvents', 'downloadEvents');
    _tabSessionsBloc.add(TabSessionsEventFetched());
  }

  Widget _createUserItem(SessionView view){
    final Color color = Theme.of(context).dividerColor;
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      controller: slidableController,
      child: Container(
          padding: EdgeInsets.zero,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: color),
            child: AppListTitle(
              title: view.title(),
              subtitle: view.subTitle(),
              onPressed: (){
                _tabSessionsBloc.add(TabSessionsEventSelected(view.res));
              },
            ),
          )
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: AppLanguage().translator(LanguageKeys.DELETE_BTN_TEXT),
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _tabSessionsBloc.add(TabSessionsEventDelete(view.res));
          },
        ),
      ],
    );
  }

}