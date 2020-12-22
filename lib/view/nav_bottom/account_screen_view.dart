import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/app_font_size.dart';
import 'package:phsar_samnong/constant/app_string.dart';

class AccountScreenView extends StatefulWidget {
  @override
  _AccountScreenViewState createState() => _AccountScreenViewState();
}

class _AccountScreenViewState extends State<AccountScreenView> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: Material(
              child: InkWell(
                onTap: () {},
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
                          SizedBox(width:70,),
                          Align(alignment: Alignment.center,child: Text(AppString.signInWithGoogle,))
                        ],
                      ),
                    )),

              ),
              color: Colors.transparent,
            ),
          ),

          Center(
            child: new Container(
              child: new Material(
                child: new InkWell(
                  onTap: (){print("tapped");},
                  child: new Container(
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                color: Colors.transparent,
              ),
              color: Colors.orange,
            ),
          ),








        ],

      );

  }
}
