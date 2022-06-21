import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
    this.onTap,
    required this.imageUrl,
    required this.label,
    circleIcon,
    height,
    width,
  })  : circleIcon = circleIcon ?? false,
        height = height ?? 55,
        width = width ?? 55,
        super(key: key);

  final void Function()? onTap;
  final String imageUrl;
  final String label;
  final bool circleIcon;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return circleIcon
        ? Column(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color:
                                kSecondaryColorDark.withOpacity(0.1), //shadow
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2))
                      ],
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(image: AssetImage(imageUrl))),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          )
        : Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: kSecondaryColorDark.withOpacity(0.1), //shadow
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2))
                ],
                shape: BoxShape.rectangle,
                color: Colors.white,
                image: DecorationImage(image: AssetImage(imageUrl))),
          );
  }
}
