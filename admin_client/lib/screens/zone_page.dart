import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';
import 'package:admin_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZonePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ZonePage();
  }

}

class _ZonePage extends State<ZonePage> {
  late ZoneBloc _zoneBloc;
  ValueNotifier<int> _valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _zoneBloc = BlocProvider.of<ZoneBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zone Manager'),
        actions: <Widget> [
          IconButton(
            icon: Icon(
                Icons.list
            ),
            onPressed: (){
              _zoneBloc.add(ZoneEventGetUsers());

              var view = _zoneBloc.server;
              List<UserView> userViews = _zoneBloc.userListModel.dataViews;

              showBoxMembers(userViews, view);
            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ZoneBloc, ZoneState> (
            builder: (context, gameState) {
              ZoneView? view;
              List<RoomView> roomViews = [];
              bool allowAddZone = false;

              if(gameState is ZoneStateSuccess) {
                view = gameState.dataView;
                roomViews = gameState.roomViews;
              }

              if(gameState is ZoneStateWaitingAdd) {
                allowAddZone = true;
              }

              Future.delayed(Duration(milliseconds: 300), (){
                if(view == null && allowAddZone){
                  _valueNotifier.value = 1;
                }
                else if(view != null) {
                  _valueNotifier.value = 2;
                }
                else {
                  _valueNotifier.value = 0;
                }
              });

              return Column(
                children: [
                  AppConnectivity(),
                  if(view != null)...[
                    Column(
                      children: [
                        Text('${view.title()}'),
                        Text('${view.subTitle()}'),
                        Text('maxRoom: ${view.res.maxRoom}'),
                        Text('totalUser: ${view.res.totalUser}'),
                        Text('forceLogout: ${view.res.forceLogout}'),
                        Text('customLogin: ${view.res.customLogin}'),
                        Text('notifyRemoveRoom: ${view.res.notifyRemoveRoom}'),
                        Text('notifyCreateRoom: ${view.res.notifyCreateRoom}'),
                      ],
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ],
                  if(roomViews.isNotEmpty)...[
                    Expanded(
                      child: RefreshIndicator(
                        child: ListView.builder(
                          itemBuilder: (BuildContext buildContext, int index){
                            if (index >= roomViews.length) {
                              return Center(
                                child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                              );
                            }
                            else {
                              var room = roomViews[index];
                              return _createRoomItem(room);
                            }
                          },
                          itemCount: roomViews.length,
                        ),
                        onRefresh: downloadEvents,
                      )
                    )
                  ]
                ],
              );

            }),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
                valueListenable: _valueNotifier,
                builder: (context, int value, Widget? child) {
                  if(value == 1){
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                          'Add',
                          icon: Icon(Icons.add_circle_rounded) ,
                          onPressed: (){
                            _zoneBloc.add(ZoneEventAdd());
                          },
                        ),
                      ],
                    );
                  }
                  else if(value == 2) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                          'Remove',
                          icon: Icon(Icons.do_disturb_on_rounded) ,
                          onPressed: (){
                            _zoneBloc.add(ZoneEventRemove());
                          },
                        ),
                        SizedBox(width: 10,),
                        AppButton(
                          'Manager',
                          icon: Icon(Icons.explicit_rounded) ,
                          onPressed: (){
                            _zoneBloc.add(ZoneEventManager());
                          },
                        ),
                        SizedBox(width: 10,),
                        AppButton(
                          'New Room',
                          icon: Icon(Icons.room_outlined) ,
                          onPressed: (){
                            _zoneBloc.add(ZoneEventNewRoom());
                          },
                        ),
                      ],
                    );
                  }
                  else {
                    return Text(
                      AppLanguage().translator(LanguageKeys.LOADING_DATA)
                    );
                  }
                }
            )

          ],
        ),
      ),
    );
  }

  Future<void> downloadEvents() async {
    UtilLogger.log('downloadEvents', 'downloadEvents');
    _zoneBloc.add(ZoneEventFetched());
  }

  Widget _createUserItem(UserView view){
    return AppListTitle(
      title: view.title(),
      subtitle: view.subTitle(),
      onPressed: (){

      },
    );
  }

  Widget _createRoomItem(RoomView view){
    return AppListTitle(
      title: '${view.title()}',
      subtitle: '${view.subTitle()}',
      onPressed: (){
        _zoneBloc.add(ZoneEventRoomChoose(view));
      },
    );
  }

  void showBoxMembers(List<UserView> userViews, ZoneConfigRes res){
    var boxLstMember = AppAlertDialog(
      title: 'User list',
      txtYes: AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
      yesOnPressed: (){
        RouteGenerator.maybePop();
      },
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            if(userViews.isNotEmpty)...[
              Expanded(
                  child:
                  ListView.builder(
                    itemBuilder: (BuildContext buildContext, int index){
                      if (index >= userViews.length) {
                        return Center(
                          child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                        );
                      } else {
                        UserView bif = userViews[index];
                        return _createUserItem(bif);
                      }
                    },
                    itemCount: userViews.length,
                  )
              )
            ],
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => boxLstMember);
  }

}