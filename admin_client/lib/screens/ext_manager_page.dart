import 'package:admin_client/blocs/blocs/ext_manager_bloc.dart';
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

              return SingleChildScrollView(
                child: Column(
                  children: [
                    AppConnectivity(),
                    if(view != null)...[
                      if(view.res.isStopped)...[
                        Row(
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
                        ),
                      ],
                      if(!view.res.isStopped)...[
                        Row(
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
                        ),
                      ],
                      view.viewInfo()
                    ],
                  ],
                )
              );
            }),
      ),
    );
  }
}