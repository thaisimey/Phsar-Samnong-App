import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ClipOval(
          child: CachedNetworkImage(imageUrl: "http://phsar-samnong.com/uploads/photos/x78IeKhzTOIfrKAC77cOy2R0aOz168dec0UTBbfT.jpeg",
            width: 80.0,
            height: 80.0,
          ),
        ),
      ),

    );
  }
}
