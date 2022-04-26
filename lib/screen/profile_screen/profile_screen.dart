import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => ProfileScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        // automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColorDark,
        title: const Text('My Profile'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/placeholder-image-400x300.jpg',
                    fit: BoxFit.fill,
                    height: 200,
                  ),
                )
              ],
            ),
            CustomContainer(
              preText: 'Name',
              suffixText: 'Muhammad Hasan Mubarak',
              suffixIcon: Icon(Icons.keyboard_arrow_right),
            ),
            CustomContainer(
              preText: 'Email',
              suffixText: 'has8ultimate@gmail.com',
              suffixIcon: Icon(Icons.keyboard_arrow_right),
            ),
            CustomContainer(
              preText: 'Phone',
              suffixText: '01117641494',
              suffixIcon: Icon(Icons.keyboard_arrow_right),
            ),
            CustomContainer(
              preText: 'Gender',
              suffixText: 'Male',
              suffixIcon: Icon(Icons.keyboard_arrow_right),
            ),
          ]),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {Key? key,
      required this.preText,
      required this.suffixText,
      required this.suffixIcon})
      : super(key: key);

  final String preText;
  final String suffixText;
  final dynamic suffixIcon;
  final double textSize = 16;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Colors.red,
        onTap: () {
          print('sdfsdfsdf');
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.black12))),
          height: 60,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      preText,
                      style: TextStyle(fontSize: textSize),
                    ),
                  )),
              Expanded(
                  flex: 0,
                  child: Container(
                    child: Text(
                      suffixText,
                      style: TextStyle(fontSize: textSize),
                    ),
                  )),
              Expanded(
                  flex: 0,
                  child: Container(
                    child: suffixIcon,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
