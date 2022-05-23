import 'package:flutter/Material.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/gender_option_container.dart';

class CustomProfileContainer extends StatelessWidget {
  const CustomProfileContainer(
      {Key? key,
      editType,
      required preText,
      required suffixText,
      required suffixIcon,
      required loginViewModel,
      required navigator,
      onGoBack})
      : _editType = editType,
        _preText = preText,
        _suffixText = suffixText,
        _suffixIcon = suffixIcon,
        _loginViewModel = loginViewModel,
        _navigator = navigator,
        _onGoBack = onGoBack,
        super(key: key);

  final String? _editType;
  final String _preText;
  final String _suffixText;
  final bool _navigator;
  final dynamic _suffixIcon;
  final double textSize = 16;
  final dynamic _onGoBack;
  final LoginViewModel _loginViewModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: InkWell(
        onTap: () async {
          if (_navigator != null) {
            if (_navigator == true) {
              await Navigator.pushNamed(context, '/editProfile',
                  arguments: _editType);
              _onGoBack();
            } else {
              showDialog(
                  useRootNavigator: true,
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => AlertDialog(
                        content: SizedBox(
                          height: 180,
                          child: Column(
                            children: [
                              SizedBox(
                                child: Text(
                                  'Gender',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: textSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                width: double.maxFinite,
                                height: 30,
                              ),
                              GenderOptionContainer(
                                  title: 'Male',
                                  loginViewModel: _loginViewModel),
                              GenderOptionContainer(
                                  title: 'Female',
                                  loginViewModel: _loginViewModel),
                              GenderOptionContainer(
                                  title: 'Other',
                                  loginViewModel: _loginViewModel),
                            ],
                          ),
                        ),
                      ));
            }
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.black12))),
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: Text(
                    _preText,
                    style: TextStyle(fontSize: textSize),
                  )),
              Expanded(
                  flex: 0,
                  child: Text(
                    _suffixText,
                    style: TextStyle(fontSize: textSize),
                  )),
              Expanded(
                  flex: 0,
                  child: Container(
                    child: _navigator
                        ? _suffixIcon
                        : const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.transparent,
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
