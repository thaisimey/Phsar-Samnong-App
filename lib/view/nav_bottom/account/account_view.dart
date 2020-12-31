import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/app_font_size.dart';
import 'package:phsar_samnong/constant/app_image.dart';
import 'package:phsar_samnong/repository/login_with_google.dart';
import 'package:phsar_samnong/view/nav_bottom/account/login_view.dart';
import 'package:phsar_samnong/view/screen/home_view.dart';

class AccountView extends StatefulWidget {
  final User user;
  const AccountView(this.user);
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
    print("photo ${user.photoURL}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: AppDimen.value12,bottom: AppDimen.value12,left: AppDimen.value6  ),
                margin: EdgeInsets.only(left: AppDimen.value10,right: AppDimen.value10,top: AppDimen.value10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(AppDimen.value4)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.05,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${user.photoURL}?width=9999" ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: AppDimen.value10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.displayName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: AppFontSize.value20),),
                          Text("Email : "),
                          Text(user.email),
                        ],
                      ),
                    )
                  ],

                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left:AppDimen.value10,right:AppDimen.value10,top: AppDimen.value10 ),
                child: new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0.01,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    // color: Colors.greenAccent
                  ),
                  child: Material(
                    child: InkWell(
                      onTap: ()  {
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: AppDimen.value6,right: AppDimen.value6 ),
                        // margin: EdgeInsets.only(left: AppDimen.value10,right: AppDimen.value10,top: AppDimen.value14),

                        child: Row(
                          children: [
                            Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text("Edit Profile")
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded,size: 16,)
                          ],

                        ),
                      ),
                    ),
                    color: Colors.transparent,
                  ),

                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left:AppDimen.value10,right:AppDimen.value10,top: AppDimen.value10 ),
                child: new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0.01,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    // color: Colors.greenAccent
                  ),
                  child: Material(
                    child: InkWell(
                      onTap: ()  {
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: AppDimen.value6,right: AppDimen.value6 ),
                        // margin: EdgeInsets.only(left: AppDimen.value10,right: AppDimen.value10,top: AppDimen.value14),

                        child: Row(
                          children: [
                            Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text("Favorites")
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded,size: 16,)
                          ],

                        ),
                      ),
                    ),
                    color: Colors.transparent,
                  ),

                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: AppDimen.value10,right: AppDimen.value10,top: AppDimen.value10 ),
                child: FlatButton(
                    color: Colors.green,
                    onPressed: () {
                      signOut().then((value) => {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeView()))
                      });
                    }, child: Text("Log out",style: TextStyle(color: Colors.white),)),
              )
            ],
          )
      ),
    );
  }
}
