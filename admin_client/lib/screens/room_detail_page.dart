import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class RoomDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RoomDetailPage();
  }

}

class _RoomDetailPage extends State<RoomDetailPage> {
  late RoomBloc _roomBloc;
  final txtNameController = TextEditingController();

  ValueNotifier<int> _valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _roomBloc = BlocProvider.of<RoomBloc>(context);

    txtNameController.addListener(() {
        print('on change ${txtNameController.text}');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room detail'),
      ),
      body: SafeArea(
        child: BlocBuilder<RoomBloc, RoomState> (
            builder: (context, gameState) {
              RoomView? view;
              List<UserView> userViews = [];

              if(gameState is RoomStateAddNew) {
                return _addNewRoom();
              }

              if(gameState is RoomStateSuccess) {
                view = gameState.dataView;
                userViews = gameState.userViews;
              }

              Future.delayed(Duration(milliseconds: 300), (){
                if(view != null){
                  _valueNotifier.value = 1;
                }
                else {
                  _valueNotifier.value = 0;
                }
              });

              return Column(
                children: [
                  AppConnectivity(),
                  if(view != null)...[
                    Text('Room ${view.title()}'),
                  ],
                  if(view != null)...[
                    Text('Room ${view.subTitle()}'),
                  ],
                  if(userViews.isNotEmpty)...[
                    Expanded(
                        child: RefreshIndicator(
                          onRefresh: onRefreshEvents,
                          child: ListView.builder(
                          itemBuilder: (BuildContext buildContext, int index){
                            if (index >= userViews.length) {
                              return Center(
                                child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                              );
                            }
                            else {
                              var view = userViews[index];
                              return _createUserItem(view);
                            }
                          },
                          itemCount: userViews.length,
                        ),
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
                          'Remove',
                          icon: Icon(Icons.delete_forever_outlined) ,
                          onPressed: (){
                            _roomBloc.add(RoomEventRemove());
                          },
                        ),
                      ],
                    );
                  }
                  else {
                    return SizedBox();
                  }
                }
            )

          ],
        ),
      ),
    );
  }

  Future<void> onRefreshEvents() async {
    UtilLogger.log('downloadEvents', 'downloadEvents');
    _roomBloc.add(RoomEventFetched());
  }

  Widget _createUserItem(UserView view){
    return AppListTitle(
      title: view.title(),
      subtitle: view.subTitle(),
      onPressed: (){
        _roomBloc.add(RoomEventOpenUser(view));
      },
    );
  }

  Widget _addNewRoom(){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(Application.PADDING_ALL),
          child: AppTextInput(
            maxLines: 1,
            maxLength: 30,
            controller: txtNameController,
            labelText: AppLanguage().translator("Room name"),
            hintText: AppLanguage().translator("Input room name"),
            keyboardType: TextInputType.text,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: AppButton(
            AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
            onPressed: () async {
              _roomBloc.add(RoomEventSubmit(txtNameController.text));
            },
          ),
        )
      ],
    );
  }

}