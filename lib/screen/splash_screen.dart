import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const SplashScreen());

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Timer(const Duration(seconds: 3),
    //     () => Navigator.pushReplacement(context, LoginScreen.route()));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            // kSecondaryColor,
            Color.fromRGBO(241, 160, 39, 1.0),
            Color.fromRGBO(255, 119, 0, 1),
            Color.fromRGBO(224, 77, 1, 1)
            // kSecondaryColorDark,
          ])),
      height: double.infinity,
      width: double.infinity,
    );
    //   const Scaffold(
    //   backgroundColor: Colors.transparent,
    //   // body:
    //   // Image.asset(
    //   //   'assets/images/logo_magicwand.png',
    //   //   semanticLabel: 'Sainee Detailing Logo',
    //   //   height: 150.0,
    //   // ),
    //   // Container(
    //   //   decoration: const BoxDecoration(
    //   //       gradient: LinearGradient(
    //   //           begin: Alignment.topRight,
    //   //           end: Alignment.bottomLeft,
    //   //           colors: [
    //   //         // kSecondaryColor,
    //   //         Color.fromRGBO(241, 160, 39, 1.0),
    //   //         Color.fromRGBO(255, 119, 0, 1),
    //   //         Color.fromRGBO(224, 77, 1, 1)
    //   //         // kSecondaryColorDark,
    //   //       ])),
    //   //   height: double.infinity,
    //   //   width: double.infinity,
    //   //   child: Center(
    //   //     child: Container(
    //   //       height: 100,
    //   //       decoration: BoxDecoration(
    //   //           color: kColorBlack.withOpacity(0.8),
    //   //           borderRadius: BorderRadius.circular(15)),
    //   //       child: Image.asset(
    //   //         'assets/images/logo_magicwand.png',
    //   //         semanticLabel: 'Sainee Detailing Logo',
    //   //         height: 150.0,
    //   //       ),
    //   //     ),
    //   //   ),
    //   // ),
    // );
  }
}
