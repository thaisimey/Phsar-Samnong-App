import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/view/screen/detail_view.dart';
import '../view/screen/categories_view.dart';

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
              Stack(
                children: [
                  Container(
                    height: 140,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: item.itemImg == null
                          ? ""
                          : "${Constant.baseURL}/" +
                          item.itemImg,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80.0,
                        height: 10+0.0,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: imageProvider),
                        ),
                      ),
                      placeholder: (context, url) => Image.asset('assets/images/home/logo/logo.png',color: Colors.grey),
                      errorWidget: (context, url, error) => Image.asset('assets/images/home/logo/logo.png',color: Colors.grey,),
                    ),
                  ),
                  Positioned(
                    left: 25,
                    bottom: 4,
                    child: Text(
                      '\$ ${item.prices[0].price}',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),


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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailView(item)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: item.itemImg == null
                    ? ""
                    : "${Constant.baseURL}/" +
                    item.itemImg,
                imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 200+0.0,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider),
                  ),
                ),
                placeholder: (context, url) => Image.asset('assets/images/home/logo/logo.png',color: Colors.grey),
                errorWidget: (context, url, error) => Image.asset('assets/images/home/logo/logo.png',color: Colors.grey,),
              ),
            ),
            Container(
              height: 30,
              child: Text(
                '\$ ${item.prices[0].price}',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }




}