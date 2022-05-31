import 'package:flutter/Material.dart';
import 'package:sainee_detailing/constant.dart';

class SuccessSnackBar {
  static show({
    required BuildContext context,
    String? title,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 95,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 38, 126, 41),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? 'Success!',
                        style:
                            const TextStyle(color: kColorWhite, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style:
                            const TextStyle(color: kColorWhite, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 23,
            left: 7,
            child: Icon(
              Icons.thumb_up_rounded,
              color: Color.fromARGB(255, 13, 78, 15),
              size: 50,
            ),
          ),
          // Positioned(
          //   top: -10,
          //   right: 8,
          //   child: GestureDetector(
          //     onTap: () {
          //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //     },
          //     child: Container(
          //       height: 30,
          //       width: 30,
          //       decoration: const BoxDecoration(
          //           color: Color.fromARGB(255, 13, 78, 15),
          //           shape: BoxShape.circle),
          //       child: const Align(
          //         alignment: Alignment.center,
          //         child: Icon(
          //           Icons.clear_sharp,
          //           color: kColorWhite,
          //           size: 20,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      elevation: 0,
    ));
  }
}

class FailedSnackBar {
  static show({
    required BuildContext context,
    String? title,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 95,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 175, 47, 38),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? 'Oh Snap!',
                        style:
                            const TextStyle(color: kColorWhite, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style:
                            const TextStyle(color: kColorWhite, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 23,
            left: 7,
            child: Icon(
              Icons.thumb_down_rounded,
              color: Color.fromARGB(255, 128, 34, 28),
              size: 50,
            ),
          ),
          // Positioned(
          //   top: -10,
          //   right: 8,
          //   child: GestureDetector(
          //     onTap: () {
          //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //     },
          //     child: Container(
          //       height: 30,
          //       width: 30,
          //       decoration: const BoxDecoration(
          //           color: Color.fromARGB(255, 128, 34, 28),
          //           shape: BoxShape.circle),
          //       child: const Align(
          //         alignment: Alignment.center,
          //         child: Icon(
          //           Icons.clear_sharp,
          //           color: kColorWhite,
          //           size: 20,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 3000),
      elevation: 0,
    ));
  }
}
