import 'package:flutter/Material.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class GenderOptionContainer extends StatelessWidget {
  const GenderOptionContainer({
    required title,
    required loginViewModel,
    Key? key,
  })  : _title = title,
        _loginViewModel = loginViewModel,
        super(key: key);

  final String _title;
  final double textSize = 16;
  final LoginViewModel _loginViewModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: InkWell(
        onTap: () {
          // print(_title);
          _loginViewModel.userDetailsCopy.gender = _title;
          Navigator.pop(context);
          _loginViewModel.checkGender();
          _loginViewModel.onGoBack();
        },
        child: Container(
          child: Text(
            _title,
            style: TextStyle(fontSize: textSize),
          ),
          width: double.maxFinite,
          padding: const EdgeInsets.only(top: 15.5, left: 7.0),
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
