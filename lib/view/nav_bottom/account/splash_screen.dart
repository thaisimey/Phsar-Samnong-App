import 'package:flutter/material.dart';
import 'package:phsar_samnong/repository/user_authen.dart';
import 'package:phsar_samnong/view/nav_bottom/account/account_view.dart';
import 'package:phsar_samnong/view/nav_bottom/account/login_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser().then((user) {
      if(user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AccountView(user)));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginView()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );

  }
}
