import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/app_font_size.dart';
import 'package:phsar_samnong/constant/app_image.dart';
import 'package:phsar_samnong/constant/app_string.dart';
import 'package:phsar_samnong/repository/login_with_facebook.dart';
import 'package:phsar_samnong/repository/login_with_google.dart';
import 'package:phsar_samnong/repository/user_authen.dart';
import 'package:phsar_samnong/view/screen/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<LoginView> {

  bool isloggedIn = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser().then((user) {
      if(user != null) {
        isloggedIn = true;
      } else {
        isloggedIn = false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize: AppFontSize.value26),),
                      Text("Sign in to continue",style: TextStyle(fontSize: AppFontSize.value14),),
                      Padding(
                        padding: const EdgeInsets.only(top: AppDimen.value40),
                        child: Text("Phone number",),
                      ),
                      TextField(),
                      Text("Verification code"),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.greenAccent
                              ),
                              child: Align(alignment: Alignment.center,child: Text(AppString.signIn,))),

                        ),
                      ),
                    ],
                  ),
                ),

                // SizedBox(height: AppDimen.value110,),


                InkWell(
                  onTap: () async {
                    await signInWithFacebook().then((user) {
                      print(user.user.email);
                      if(user != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeView()));

                      } else {
                        print("There is some error");
                      }
                    } );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left:AppDimen.value20,right:AppDimen.value20 ),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.greenAccent
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:AppDimen.value14,right:AppDimen.value14 ),
                          child: Row(
                            children: [
                              GestureDetector(onTap: () {},child: Image.asset("assets/images/social/facebook.png",height: 30,width: 30,)),
                              SizedBox(width: AppDimen.value70,),
                              Align(alignment: Alignment.center,child: Text(AppString.signInWithFacebook,))
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 20,),


                Padding(
                  padding: const EdgeInsets.only(left:AppDimen.value20,right:AppDimen.value20 ),
                  child: new Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                      // color: Colors.greenAccent
                    ),
                    child: new Material(
                      child: new InkWell(
                        onTap: () async {
                          await signInWithGoogle().then((user) {
                            print(user.user.displayName);
                            if(user != null) {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeView()));

                            } else {
                              print("There is some error");
                            }
                          } );

                        },
                        child: new Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,

                            child: Padding(
                              padding: const EdgeInsets.only(left:AppDimen.value14,right:AppDimen.value14 ),
                              child: Row(
                                children: [
                                  Image.asset(AppImage.google,height: 26,width: 26,),
                                  SizedBox(width: AppDimen.value70),
                                  Align(alignment: Alignment.center,child: Text(AppString.signInWithGoogle,))
                                ],
                              ),
                            )),
                      ),
                      color: Colors.transparent,
                    ),

                  ),
                ),

              ],

            ),
          )
        );


  }
}
