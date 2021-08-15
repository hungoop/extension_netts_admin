
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/dataview/account_view.dart';
import 'package:admin_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class AccountManagerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountManagerPage();
  }

}

class _AccountManagerPage extends State<AccountManagerPage> {
  late AccManagerBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<AccManagerBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: SafeArea(
        child: BlocBuilder<AccManagerBloc, AccManagerState> (
            builder: (context, gameState) {
              List<AccountView> lstAdminView = [];

              if(gameState is AccManagerStateSuccess) {
                lstAdminView = gameState.lstAdminView;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppConnectivity(),
                  if(lstAdminView.isNotEmpty)...[
                    Expanded(
                        child: RefreshIndicator(
                          child: ListView.builder(
                            itemBuilder: (BuildContext buildContext, int index){
                              if (index >= lstAdminView.length) {
                                return Center(
                                  child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                                );
                              } else {
                                var data = lstAdminView[index];
                                return _createAccItem(data);
                              }
                            },
                            itemCount: lstAdminView.length,
                          ),
                          onRefresh: onRefreshEvents,
                        )
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
    _userBloc.add(AccManagerEventFetched());
  }

  Widget _createAccItem(AccountView view){
    return view.viewInfo();
  }
}