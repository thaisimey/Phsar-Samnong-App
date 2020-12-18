import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'file:///D:/Flutter/phsar_samnong/lib/view/screen/categories_view.dart';
import 'package:phsar_samnong/view/screen/detail_view.dart';

class ComponentPro {
  static Widget movieItem(Item item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailView(item)),
        );
      },
      child: Container(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: Column(
            children: [
              Container(
                height: 120,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CachedNetworkImage(
                  imageUrl: item.itemImg == null
                      ? ""
                      : "${Constant.baseURL}/" +
                      item.itemImg,
                  placeholder: (_, __) {
                    return Image.asset('assets/images/home/logo/logo.png',color: Colors.grey);
                  },
                  errorWidget: (_, __, ___) {
                    return Image.asset('assets/images/home/logo/logo.png',color: Colors.grey,);
                  },
                ),
              ),
              Container(
                width: 90,
                height: 5,
                child: Text(
                  '${item.nameEn}',
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget tabBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CategoriesView()));
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width/4.5,
            child: Image.asset("assets/images/home/icon/menu.png"),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/30,
          height: 40,
          child: VerticalDivider(thickness: 2,),
        ),

        Container(
          height: 50,
          width: MediaQuery.of(context).size.width/4.5,
          // color: Colors.red,
          child: Image.asset("assets/images/home/icon/fav.png"),
        ),
        Container(
          width: MediaQuery.of(context).size.width/30,
          height: 40,
          child: VerticalDivider(thickness: 2,),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width/4.5,

          child: Image.asset("assets/images/home/icon/chat.png"),
        ),
        Container(
          width: MediaQuery.of(context).size.width/30,
          height: 40,
          child: VerticalDivider(thickness: 2,),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width/4.5,
          child: Image.asset("assets/images/home/icon/po.png"),
        ),

      ],
    );
  }

  static Widget movieGridItem(Item item,BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailView(item)),
        );
      },
      child: Container(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: item.itemImg == null
                        ? ""
                        : "https://image.tmdb.org/t/p/original/" +
                        item.itemImg,
                    placeholder: (_, __) {
                      return Image.asset('assets/images/logoMovie.jpg');
                    },
                    errorWidget: (_, __, ___) {
                      return Image.asset('assets/images/logoMovie.jpg');
                    },
                  ),
                ),
              ),
              Container(
                height: 30,
                child: Text(
                  '${item.nameEn}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}