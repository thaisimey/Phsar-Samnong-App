import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phsar_samnong/constant/app_dimen.dart';
import 'package:phsar_samnong/constant/const.dart';
import 'package:phsar_samnong/model/product/item.dart';
import 'package:phsar_samnong/view/screen/detail_view.dart';
import '../view/screen/categories_view.dart';

class ComponentPro {
  static Widget movieItem(Item item, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: AppDimen.value2,right: AppDimen.value2,bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(AppDimen.radiusOfRipple)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.1,
            blurRadius: 1,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: AppDimen.value100,
                width: AppDimen.value90,
                padding: EdgeInsets.only(left: AppDimen.value4,right: AppDimen.value4),

                child: CachedNetworkImage(
                  imageUrl: item.itemImg == null
                      ? ""
                      : "${Constant.baseURL}/" +
                      item.itemImg,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 10,
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
              Text(
                '\$ ${item.prices[0].price}',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Positioned.fill(
            top: 0,
              child: new Material(
                  color: Colors.transparent,
                  child: new InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(AppDimen.radiusOfRipple)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailView(item.id)),
                      );
                    },
                  ))),

        ],
      ),
    );

  }

  static Widget tabBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.8),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.1)),),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
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
            child: VerticalDivider(thickness: 0.5,),
          ),

          InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width/4.5,
              // color: Colors.red,
              child: Image.asset("assets/images/home/icon/fav.png"),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width/30,
            height: 40,
            child: VerticalDivider(thickness: 0.5,),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width/4.5,

              child: Image.asset("assets/images/home/icon/chat.png"),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width/30,
            height: 40,
            child: VerticalDivider(thickness: 0.5,),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width/4.5,
              child: Image.asset("assets/images/home/icon/po.png"),
            ),
          ),

        ],
      ),

    );
  }

  static Widget movieGridItem(Item item,BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailView(item.id)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                height: 90,
                child: CachedNetworkImage(
                  imageUrl: item.itemImg == null
                      ? ""
                      : "${Constant.baseURL}/" +
                      item.itemImg,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 90,
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
              Padding(
                padding: const EdgeInsets.only(top: AppDimen.value10),
                child: Container(
                  height: 30,
                  child: Text(
                    '\$ ${item.prices[0].price}',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




}