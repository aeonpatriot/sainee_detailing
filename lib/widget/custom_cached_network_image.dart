import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sainee_detailing/constant.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    bool? isCircle,
    bool? isCar,
    bool? isHome,
  })  : isCircle = isCircle ?? false,
        isCar = isCar ?? false,
        isHome = isHome ?? false,
        super(key: key);

  final String imageUrl;
  final bool isCircle;
  final bool isCar;
  final bool isHome;
  final String rootImageUrl = 'http://192.168.1.106:8080/storage';
  // final String rootImageUrl = 'http://192.168.1.107:8080/storage';
  // final String rootImageUrl = 'http://10.0.2.2:8000/storage';

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: key,
      // httpHeaders: const {'Connection': 'Keep-Alive'},
      imageUrl: "$rootImageUrl/$imageUrl",

      imageBuilder: isCircle
          ? (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              )
          : isCar
              ? (context, imageProvider) => Container(
                    height: 100,
                    width: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                  )
              : isHome
                  ? (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  : null,
      placeholder: (context, url) => Container(
          height: isCircle
              ? 60
              : isCar
                  ? 100
                  : 100,
          width: isCircle
              ? 60
              : isCar
                  ? 70
                  : 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: const Center(
              child: SpinKitThreeBounce(
            color: kSecondaryColor,
            size: 30.0,
          ))),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
      width: isCircle ? null : double.infinity,
    );
  }
}
