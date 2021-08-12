import 'package:admin_client/blocs/blocs/ext_manager_bloc.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/screens/screens.dart';

class ExtManagerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExtManagerPage();
  }

}

class _ExtManagerPage extends State<ExtManagerPage> {
  late ExtManagerBloc _extManagerBloc;
  ValueNotifier<int> _valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _extManagerBloc = BlocProvider.of<ExtManagerBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extension Manager'),
      ),
      body: SafeArea(
        child: BlocBuilder<ExtManagerBloc, ExtState> (
            builder: (context, extState) {
              ExtView? view;

              if(extState is ExtStateSuccess) {
                view = extState.dataView;
              }

              Future.delayed(Duration(milliseconds: 300), (){
                if(view != null && view.res.isStopped){
                  _valueNotifier.value = 1;
                }
                else if(view != null && !view.res.isStopped) {
                  _valueNotifier.value = 2;
                }
                else {
                  _valueNotifier.value = 0;
                }
              });

              return RefreshIndicator(
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppConnectivity(),
                        if(view != null)...[
                          view.viewInfo(),
                        ],
                      ],
                    )
                ),
                onRefresh: onRefreshEvents,
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
                          'Start',
                          icon: Icon(Icons.run_circle_outlined) ,
                          onPressed: (){
                            _extManagerBloc.add(ExtEventStart());
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
                          'Stop',
                          icon: Icon(Icons.do_disturb_on_rounded) ,
                          onPressed: (){
                            _extManagerBloc.add(ExtEventStop());
                          },
                        ),
                        SizedBox(width: 50,),
                        AppButton(
                          'Reload',
                          icon: Icon(Icons.refresh_outlined) ,
                          onPressed: (){
                            _extManagerBloc.add(ExtEventReload());
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

  Future<void> onRefreshEvents() async {
    UtilLogger.log('onRefreshEvents', 'onRefreshEvents');
    _extManagerBloc.add(ExtEventFetched());
  }
}