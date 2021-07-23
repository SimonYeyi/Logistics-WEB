import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_navigator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final List<String> bannerImageAssets = const [
    "images/official_banner_1.png",
    "images/official_banner_2.png",
    "images/official_banner_3.png",
    "images/official_banner_4.png",
  ];

  List<Widget> get bannerImagesWithPadding {
    final banners = <Widget>[];
    for (int i = 0; i < bannerImageAssets.length; i++) {
      banners.add(Image.asset(bannerImageAssets[i], fit: BoxFit.fill));
      if (i != bannerImageAssets.length - 1) {
        banners.add(SizedBox(width: 10));
      }
    }
    return banners;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "images/official_top.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 360,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [...bannerImagesWithPadding],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () => BoostNavigator.of().push("track"),
                  child: Image.asset(
                    "images/official_input.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "images/official_bottom.png",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
