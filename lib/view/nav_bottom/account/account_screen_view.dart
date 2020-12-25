import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/app_font_size.dart';
import 'package:phsar_samnong/constant/app_image.dart';
import 'package:phsar_samnong/constant/app_string.dart';

class AccountScreenView extends StatefulWidget {
  @override
  _AccountScreenViewState createState() => _AccountScreenViewState();
}

class _AccountScreenViewState extends State<AccountScreenView> {

  bool isLoggedIn = false;
  String username = "";
  String email = "";

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      setState(() {
        username = value.user.displayName;
        email = value.user.email;
      });
      print('auth cre ${value.user.toString()}');
    });

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn  = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(inputData() == null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    if(_auth.currentUser.email != null) {
      username = _auth.currentUser.displayName;
      email = _auth.currentUser.email;
    }
  }

  String inputData() {
    String uid;
    try {
      User user = _auth.currentUser;
      if(user != null) {
        uid = user.uid;
        print("UID ${uid}");
      }
    } catch(e) {
      print('error get current user $e');
    }
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? Column(
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
            onTap: () {},
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
                        Image.asset("assets/images/social/facebook.png",height: 30,width: 30,),
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
                    await signInWithGoogle();
                    setState(() {
                      isLoggedIn = false;
                    });
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

      )
        : Container(
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
                       child: Image(
                         image: AssetImage(AppImage.account),
                       ),
                     ),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimen.value10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(username,style: TextStyle(fontWeight: FontWeight.bold,fontSize: AppFontSize.value20),),
                            Text("Email : "),
                            Text(email),
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
                      onPressed: () async {
                        try {
                          await _auth.signOut();
                          await _googleSignIn.signOut();
                          setState(() {
                            isLoggedIn = true;
                          });
                        } catch(e) {
                          print("error $e");
                        }
                      }, child: Text("Log out",style: TextStyle(color: Colors.white),)),
                )
              ],
            )
          );

  }
}
