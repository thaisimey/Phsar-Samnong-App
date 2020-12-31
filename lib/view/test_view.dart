// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:phsar_samnong/constant/app_dimen.dart';
// import 'package:phsar_samnong/constant/app_font_size.dart';
// import 'package:phsar_samnong/constant/app_string.dart';
// import 'package:phsar_samnong/model/user/user_info.dart';
// import 'package:phsar_samnong/repository/api_service.dart';
//
// class TestView extends StatefulWidget {
//   @override
//   _TestViewState createState() => _TestViewState();
// }
//
// class _TestViewState extends State<TestView> {
//
//
//   bool isLoggedIn = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn  = GoogleSignIn();
//   static final FacebookLogin facebookSignIn = new FacebookLogin();
//   UserInfor userInfor;
//
//
//
//   void onLoginStatusChanged(bool isLoggedIn) {
//     setState(() {
//       this.isLoggedIn = isLoggedIn;
//     });
//   }
//
//   void initiateFacebookLogin() async {
//
//     var facebookLoginResult =
//     await facebookSignIn.logInWithReadPermissions(['email']);
//     switch (facebookLoginResult.status) {
//       case FacebookLoginStatus.error:
//         print("Error");
//         onLoginStatusChanged(false);
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         print("CancelledByUser");
//         onLoginStatusChanged(false);
//         break;
//       case FacebookLoginStatus.loggedIn:
//         FacebookAccessToken myToken = facebookLoginResult.accessToken;
//         try {
//           Response response = await ApiService.httpClient.dio.get(
//               'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${myToken.token}');
//
//           // print("response ${response.data}");
//           Map<String, dynamic> responseJson = jsonDecode(response.data);
//           userInfor = UserInfor.fromJson(responseJson);
//           print(userInfor.name);
//
//
//         } catch(e) {
//           print("error $e}");
//         }
//
//         print("${myToken.token}");
//         print("${myToken.userId}");
//         print("${myToken.expires}");
//         print("${myToken.permissions}");
//         print("${myToken.declinedPermissions}");
//         print("LoggedIn");
//         onLoginStatusChanged(true);
//         break;
//     }
//   }
//
//   Future<void> signOut() async {
//     await facebookSignIn.logOut();
//   }
//
//   Future<void> signOutFromGoogle() async {
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//   }
//
//
//
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//     // Create a new credential
//     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//     FirebaseAuth.instance.signInWithCredential(credential).then((value) {
//       print('auth cre ${value.user.toString()}');
//     });
//
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize: AppFontSize.value26),),
//               Text("Sign in to continue",style: TextStyle(fontSize: AppFontSize.value14),),
//               Padding(
//                 padding: const EdgeInsets.only(top: AppDimen.value40),
//                 child: Text("Phone number",),
//               ),
//               TextField(),
//               Text("Verification code"),
//               TextField(
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(6),
//                   border: new OutlineInputBorder(
//                       borderSide: new BorderSide(color: Colors.teal)),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.green,
//                       style: BorderStyle.solid,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: InkWell(
//                   onTap: () {},
//                   child: Container(
//                       height: 50,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.greenAccent
//                       ),
//                       child: Align(alignment: Alignment.center,child: Text(AppString.signIn,))),
//
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         // SizedBox(height: AppDimen.value110,),
//
//
//         InkWell(
//           onTap: () {
//             initiateFacebookLogin();
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left:AppDimen.value20,right:AppDimen.value20 ),
//             child: Container(
//                 height: 50,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: Colors.greenAccent
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left:AppDimen.value14,right:AppDimen.value14 ),
//                   child: Row(
//                     children: [
//                       Image.asset("assets/images/social/facebook.png",height: 30,width: 30,),
//                       SizedBox(width: AppDimen.value70,),
//                       Align(alignment: Alignment.center,child: Text(AppString.signInWithFacebook,))
//                     ],
//                   ),
//                 )),
//           ),
//         ),
//         SizedBox(height: 20,),
//
//
//         Padding(
//           padding: const EdgeInsets.only(left:AppDimen.value20,right:AppDimen.value20 ),
//           child: new Container(
//             decoration: BoxDecoration(
//               color: Colors.orange,
//               borderRadius: BorderRadius.circular(8),
//               // color: Colors.greenAccent
//             ),
//             child: new Material(
//               child: new InkWell(
//                 onTap: () async {
//                   await signInWithGoogle();
//                 },
//                 child: new Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//
//                     child: Padding(
//                       padding: const EdgeInsets.only(left:AppDimen.value14,right:AppDimen.value14 ),
//                       child: Row(
//                         children: [
//                           Image.asset("assets/images/social/facebook.png",height: 30,width: 30,),
//                           SizedBox(width:70,),
//                           Align(alignment: Alignment.center,child: Text(AppString.signInWithGoogle,))
//                         ],
//                       ),
//                     )),
//               ),
//               color: Colors.transparent,
//             ),
//
//           ),
//         ),
//
//         Padding(
//           padding: const EdgeInsets.only(left:AppDimen.value20,right:AppDimen.value20 ),
//           child: new Container(
//             decoration: BoxDecoration(
//               color: Colors.orange,
//               borderRadius: BorderRadius.circular(8),
//               // color: Colors.greenAccent
//             ),
//             child: new Material(
//               child: new InkWell(
//                 onTap: () {
//                   signOut();
//                 },
//                 child: new Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//
//                     child: Padding(
//                       padding: const EdgeInsets.only(left:AppDimen.value14,right:AppDimen.value14 ),
//                       child: Row(
//                         children: [
//                           Image.asset("assets/images/social/facebook.png",height: 30,width: 30,),
//                           SizedBox(width:70,),
//                           Align(alignment: Alignment.center,child: Text("Sign Out"))
//                         ],
//                       ),
//                     )),
//               ),
//               color: Colors.transparent,
//             ),
//
//           ),
//         ),
//
//         Padding(
//           padding: const EdgeInsets.only(left:AppDimen.value20,right:AppDimen.value20 ),
//           child: new Container(
//             decoration: BoxDecoration(
//               color: Colors.orange,
//               borderRadius: BorderRadius.circular(8),
//               // color: Colors.greenAccent
//             ),
//             child: new Material(
//               child: new InkWell(
//                 onTap: () {
//                   signOutFromGoogle();
//                 },
//                 child: new Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//
//                     child: Padding(
//                       padding: const EdgeInsets.only(left:AppDimen.value14,right:AppDimen.value14 ),
//                       child: Row(
//                         children: [
//                           Image.asset("assets/images/social/facebook.png",height: 30,width: 30,),
//                           SizedBox(width:70,),
//                           Align(alignment: Alignment.center,child: Text("Sign Out from Google"))
//                         ],
//                       ),
//                     )),
//               ),
//               color: Colors.transparent,
//             ),
//
//           ),
//         ),
//
//
//         //
//
//
//
//
//       ],
//
//     );
//   }
// }
