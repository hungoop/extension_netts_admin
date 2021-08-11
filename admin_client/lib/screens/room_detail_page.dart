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
  late RoomBloc _playGameBloc;

  @override
  void initState() {
    super.initState();

    _playGameBloc = BlocProvider.of<RoomBloc>(context);
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

              if(gameState is RoomStateSuccess) {
                view = gameState.dataView;
                userViews = gameState.userViews;
              }

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
                        )
                    )
                  ]
                ],
              );

            }),
      ),
    );
  }

  Widget _createUserItem(UserView view){
    return AppListTitle(
      title: view.title(),
      subtitle: view.subTitle(),
      onPressed: (){
        _playGameBloc.add(RoomEventOpenUser(view));
      },
    );
  }
}