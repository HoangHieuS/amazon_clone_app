import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();
    double smallAdDimension = screenSize.width / 5;
    return Column(
      children: [
        CarouselSlider(
          items: GlobalVariables.carouselImages.map(
            (e) {
              return Builder(
                builder: (BuildContext context) => Image.network(
                  e,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            height: 200,
            autoPlay: true,
          ),
        ),
        Container(
          height: smallAdDimension,
          width: screenSize.width,
          color: const Color(0xffebecee),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getSmallAd(
                index: 0,
                size: smallAdDimension,
              ),
              getSmallAd(
                index: 1,
                size: smallAdDimension,
              ),
              getSmallAd(
                index: 2,
                size: smallAdDimension,
              ),
              getSmallAd(
                index: 3,
                size: smallAdDimension,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget getSmallAd({required int index, required double size}) {
  return Container(
    height: size,
    width: size,
    decoration: ShapeDecoration(
      color: Colors.white,
      shadows: [
        BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              GlobalVariables.smallAdsImage[index],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                GlobalVariables.smallAdsTitle[index],
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
