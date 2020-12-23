import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/view/nav_bottom/account_screen_view.dart';
import 'package:phsar_samnong/view/nav_bottom/brand_screen_view.dart';
import 'package:phsar_samnong/view/nav_bottom/home_screen_view.dart';
import 'package:phsar_samnong/view/screen/search_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  int curIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreenView(),
    BrandScreenView(),
    AccountScreenView(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: [
            Image.asset(
              "assets/images/home/logo/logo@3x.png",
              width: 110,
            ),
            SizedBox(
              width: 15,
            ),
            Image.asset(
              "assets/images/home/flag/khmer@3x.png",
              height: 100,
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppDimen.value2),
              child: Image.asset(
                "assets/images/home/flag/chinese@3x.png",
                height: 100,
                width: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppDimen.value2),
              child: Image.asset(
                "assets/images/home/flag/united-kingdom@3x.png",
                height: 100,
                width: 40,
              ),
            ),
            Spacer(),
            Container(
              height: 40,
              width: 40,
              child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchView()));
                  },
                  child: Image.asset("assets/images/home/icon/search.png")),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int i) {
          setState(() {
            curIndex = i;
          });
        },
        currentIndex: curIndex,
        backgroundColor: Theme.of(context).primaryColor,
        showSelectedLabels: false,
        selectedItemColor: Colors.black,
        // unselectedItemColor: Colors.black,
        showUnselectedLabels: false,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "",
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.branding_watermark_outlined,
            ),
            label: "",
            activeIcon: Icon(
              Icons.branding_watermark,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined ,
            ),
            label: "",
            activeIcon: Icon(
              Icons.account_circle,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: curIndex,
        children: _widgetOptions,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}