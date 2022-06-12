import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class CustomPlaceholderImage extends StatelessWidget {
  const CustomPlaceholderImage(
      {Key? key, bool? isCircle, bool? isCar, this.normalHeight})
      : isCircle = isCircle ?? false,
        isCar = isCar ?? false,
        super(key: key);

  final bool isCircle;
  final bool isCar;
  final double? normalHeight;

  @override
  Widget build(BuildContext context) {
    return isCircle
        ? Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: kSecondaryColorDark,
                width: 1,
              ),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/placeholder-image-400x300.jpg',
                ),
              ),
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
          )
        : isCar
            ? Container(
                height: 100,
                width: 70,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/placeholder-image-400x300.jpg'),
                        fit: BoxFit.cover),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
              )
            : Image.asset(
                'assets/images/placeholder-image-400x300.jpg',
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: normalHeight ?? 250,
              );
  }
}
