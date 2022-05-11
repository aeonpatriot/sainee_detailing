import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    Key? key,
  }) : super(key: key);

  final Icon rightArrowIcon = const Icon(Icons.keyboard_arrow_right);

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return Column(
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
            suffixText: '${loginViewModel.userDetails!.name}',
            suffixIcon: rightArrowIcon,
          ),
          CustomContainer(
            preText: 'Email',
            suffixText: '${loginViewModel.userDetails!.email}',
            suffixIcon: rightArrowIcon,
          ),
          CustomContainer(
            preText: 'Phone',
            suffixText: '${loginViewModel.userDetails!.gender}',
            suffixIcon: rightArrowIcon,
          ),
          CustomContainer(
            preText: 'Gender',
            suffixText: loginViewModel.userDetails!.gender == null
                ? 'Not Set'
                : '${loginViewModel.userDetails!.gender}',
            suffixIcon: rightArrowIcon,
          ),
        ]);
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
      color: Color.fromARGB(255, 255, 255, 255),
      child: InkWell(
        // splashColor: Colors.red,
        onTap: () {
          print('sdfsdfsdf');
        },
        child: Container(
          decoration: const BoxDecoration(
              // color: Color.fromARGB(255, 255, 255, 255),
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
