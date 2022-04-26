import 'package:flutter/material.dart';

class MainMenuScreenBody extends StatelessWidget {
  const MainMenuScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home',
        style: TextStyle(fontSize: 60),
      ),
    );
  }
}
