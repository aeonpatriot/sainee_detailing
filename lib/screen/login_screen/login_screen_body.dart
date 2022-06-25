import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/dashboard_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/centered_textbox.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context, listen: false);
    final DashboardViewModel dashboardViewModel =
        Provider.of<DashboardViewModel>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: 'header',
              child: Material(
                type: MaterialType.transparency,
                child: Stack(children: [
                  const SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                      color: kPrimaryColor,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [kPrimaryColor, kPrimaryColorDark]),
                    )),
                  ),
                  Positioned(
                    bottom: 100.0,
                    right: 100.0,
                    left: 100.0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: kColorBlack.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset(
                        'assets/images/logo_magicwand.png',
                        semanticLabel: 'Sainee Detailing Logo',
                        height: 150.0,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: kColorOffWhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                              ))),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              width: 310,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Hero(
                  tag: 'title',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text('Login',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColorDark)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<LoginViewModel>(
              builder: (context, notifier, child) => CenteredTextBox(
                  hint: 'Email',
                  isObscure: false,
                  onChanged: (value) => notifier.email = value,
                  prefixIcon: const Icon(Icons.mail)),
            ),
            const SizedBox(height: 20),
            Consumer<LoginViewModel>(
              builder: (context, notifier, child) => CenteredTextBox(
                hint: 'Password',
                onChanged: (value) => notifier.password = value,
                isObscure: notifier.hidePassword ? true : false,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: notifier.setHidePassword,
                  icon: notifier.hidePassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Hero(
              tag: 'mainButton',
              child: Consumer<LoginViewModel>(
                builder: (context, notifier, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColorDarker,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      minimumSize: const Size(310.0, 35.0),
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    notifier.setIsLoginLoading(true);
                    loginViewModel.onLoginPressed(
                        context, dashboardViewModel.setFutureDashboardData);
                    bookingListViewModel.customerBookingTab = 0;
                  },
                  child: notifier.isLoginLoading
                      ? SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Coming Right Up'.toUpperCase(),
                                style: Theme.of(context).textTheme.button,
                              ),
                              const SizedBox(width: 10),
                              const SizedBox(
                                height: 20,
                                width: 50,
                                child: SpinKitHourGlass(
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.button,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont\'t have an account?',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: Text(' Sign up',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: kSecondaryColor)),
                ),
              ],
            ),
            // const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
