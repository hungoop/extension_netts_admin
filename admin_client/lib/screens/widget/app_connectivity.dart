import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/language/languages.dart';

class AppConnectivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppConnectivity();
  }
}

class _AppConnectivity extends State<AppConnectivity> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConnectivityBloc, AppConnectivityState>(
        builder: (context, conState) {
          if(conState is ConnectivityStateFail){
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_outlined,
                        size: Application.SIZE_ICON_NUM_NEW,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        AppLanguage().translator(
                            conState.errorCode
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Application.FONT_SIZE_SMALL
                        ),
                      )
                    ],
                  )
                ],
              )
            );
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            height: 0,
          );
        }
    );

  }
}