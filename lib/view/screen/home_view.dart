import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/app_image.dart';
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
      appBar: CustomSearchBar(),
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

class CustomSearchBar extends StatelessWidget with PreferredSizeWidget {
  String keyword = "";
  int page = 1;
  int limit;
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
                height: 80,
                width: 100,
                // color: Colors.grey,
                child: Image(image: AssetImage(AppImage.logoMedium),)),
            SizedBox(
              width: 15,
            ),
            Image.asset(
              AppImage.khmer,
              height: 36,
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppDimen.value2),
              child: Image.asset(
                AppImage.chinese,
                height: 100,
                width: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppDimen.value2),
              child: Image.asset(
                AppImage.uk,
                height: 100,
                width: 40,
              ),
            ),
            Spacer(),
            Material(
              color: Colors.transparent,
              child: Container(
                // color: Colors.red,
                height: 80,
                width: 80,

                child: Center(
                  child: InkResponse(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchView()));
                    },
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image(image: AssetImage(AppImage.search),)),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}