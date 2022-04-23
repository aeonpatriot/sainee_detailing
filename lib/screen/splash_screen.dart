import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Route route({user}) =>
      MaterialPageRoute(builder: (context) => SplashScreen());

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3),
    //     () => Navigator.pushReplacement(context, MainScreen.route()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.jpg',
                  semanticLabel: 'Sainee Detailing Logo',
                  height: 170.0,
                ),
              )
            ],
          ),
        ));
  }
}
