import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/widget/custom_cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider(
      {Key? key,
      required this.imageList,
      this.height,
      this.onPageChanged,
      required this.activeIndex,
      this.width,
      bool? isGear})
      : isGear = isGear ?? false,
        super(key: key);

  final List imageList;
  final double? height;
  final double? width;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final int activeIndex;
  final bool isGear;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: imageList.length,
            itemBuilder: (context, index, realIndex) {
              final image = imageList[index];
              return isGear
                  ? Container(
                      width: width ?? double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: CustomCachedNetworkImage(
                        imageUrl: image,
                        isHome: true,
                      ),
                    )
                  : Container(
                      height: 90,
                      width: width ?? double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(image), fit: BoxFit.cover)),
                    );
            },
            options: CarouselOptions(
                viewportFraction: 1,
                height: height ?? 180,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: onPageChanged)),
        const SizedBox(height: 5),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: imageList.length,
          effect: const ExpandingDotsEffect(
              activeDotColor: kSecondaryColorDark, dotHeight: 5, dotWidth: 5),
        )
      ],
    );
  }
}
