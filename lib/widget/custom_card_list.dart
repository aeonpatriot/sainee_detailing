import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/widget/custom_cached_network_image.dart';
import 'package:sainee_detailing/widget/custom_placeholder_image.dart';

class CustomCardList extends StatelessWidget {
  const CustomCardList(
      {Key? key,
      this.onTap,
      required this.isDefault,
      required this.textList,
      bool? hasImage,
      this.imageUrl,
      this.imageName})
      : hasImage = hasImage ?? false,
        super(key: key);

  final String isDefault;
  final void Function()? onTap;
  final List<Widget> textList;
  final bool hasImage;
  final String? imageUrl;
  final String? imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: kSecondaryColorDark.withOpacity(0.1), //shadow
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: kColorWhite,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Stack(children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                    height: 10,
                    width: 100,
                    decoration: BoxDecoration(
                        color: isDefault == 'N'
                            ? Colors.transparent
                            : kSecondaryColor,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20)))),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, left: 20, bottom: 20, right: 20),
                child: hasImage
                    ? Wrap(
                        children: [
                          Container(
                            // height: 30,
                            width: 48,
                            color: Colors.red,
                            margin: const EdgeInsets.only(right: 13),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: textList,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: textList,
                      ),
                // height: 150,
                // width: 100,
              ),
              hasImage
                  ? Positioned(
                      left: 1,
                      top: 1,
                      child: imageUrl != null
                          ? SizedBox(
                              height: 100,
                              width: 70,
                              child: Hero(
                                tag: '$imageName',
                                child: CustomCachedNetworkImage(
                                  imageUrl: imageUrl!,
                                  isCar: true,
                                ),
                              ),
                            )
                          : const CustomPlaceholderImage(isCar: true))
                  : Container(),
            ]),
          ),
        ),
      ),
    );
  }
}

class CustomCardListText extends StatelessWidget {
  const CustomCardListText({
    Key? key,
    required this.text,
    this.isHeading,
    this.isDefault,
    String? type,
  })  : type = type ?? 'Address',
        super(key: key);

  final String text;
  final bool? isHeading;
  final String? isDefault;
  final String type;

  static const maincontentTextColor = Color.fromRGBO(158, 158, 158, 1);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: TextStyle(
              // overflow: TextOverflow.fade,
              color: isHeading == null ? maincontentTextColor : kColorBlack,
              fontSize: kMaincontentFont),
          children: (isDefault == 'Y')
              ? [
                  TextSpan(
                      text: ' [Default $type]',
                      style: const TextStyle(color: kSecondaryColor))
                ]
              : []),
    );
  }
}
