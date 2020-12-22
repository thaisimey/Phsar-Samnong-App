import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class BrandScreenView extends StatefulWidget {
  @override
  _BrandScreenViewState createState() => _BrandScreenViewState();
}

class _BrandScreenViewState extends State<BrandScreenView> {

  StreamSubscription subscription;

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      print("result ${result}");
      if (result == ConnectivityResult.none) {
        return Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          message: "no internet",
          icon:
          Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),
          messageText: Row(
            children: [
              Text("no internet",style: TextStyle(color: Colors.white),),
              Spacer(),
              Container(
                height: 20,
                child: FlatButton(onPressed: (){},
                    child: Text("Try again",style: TextStyle(color: Colors.green),)),
              )

            ],
          ),

          duration: Duration(seconds: 6),
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
