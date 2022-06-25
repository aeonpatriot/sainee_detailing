import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/dashboard_screen/chart/bar_booking_status.dart';
import 'package:sainee_detailing/screen/dashboard_screen/chart/bar_service.dart';
import 'package:sainee_detailing/screen/dashboard_screen/chart/doughnut_payment_type.dart';
import 'package:sainee_detailing/viewmodels/dashboard_viewmodel.dart';
import 'package:sainee_detailing/widget/dashboard_status_box.dart';

class DashboardScreenBody extends StatelessWidget {
  const DashboardScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel dashboardViewModel =
        Provider.of<DashboardViewModel>(context);
    // final LoginViewModel loginViewModel =
    //     Provider.of<LoginViewModel>(context, listen: false);

    final TextTheme themeStyle = Theme.of(context).textTheme;

    return FutureBuilder(
        future: dashboardViewModel.futureDashboardData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                  child: SpinKitCubeGrid(
                color: kPrimaryColorDarker,
                size: 50.0,
              ));
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 63, bottom: 75, right: 20, left: 20),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [kPrimaryColor, kPrimaryColorDark]),
                              color: kPrimaryColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: const Text(''),
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Dashboard',
                                          style: themeStyle.headline6
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        onPressed: () {
                                          dashboardViewModel
                                              .setFutureDashboardData();
                                        },
                                        icon: const Icon(Icons.refresh_sharp),
                                        color: kColorWhite,
                                      ),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          shape: BoxShape.circle),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    'Total Revenue',
                                    style: themeStyle.bodyText1
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // const Icon(Icons.abc),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Text(
                                            'RM',
                                            style: themeStyle.headline2
                                                ?.copyWith(
                                                    color: kColorWhite,
                                                    fontSize: 30),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            double.parse(dashboardViewModel
                                                    .dashboardData
                                                    .totalRevenue!)
                                                .toStringAsFixed(2),
                                            style: themeStyle.headline2
                                                ?.copyWith(color: kColorWhite),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    DashboardStatusBox(
                                      statusText: 'Pending',
                                      statusValue: dashboardViewModel
                                          .dashboardData.totalPending!,
                                      isYellow: true,
                                      color: Colors.yellow,
                                    ),
                                    const SizedBox(width: 10),
                                    DashboardStatusBox(
                                      statusText: 'Confirmed',
                                      statusValue: dashboardViewModel
                                          .dashboardData.totalConfirmed!,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    DashboardStatusBox(
                                      statusText: 'Completed',
                                      statusValue: dashboardViewModel
                                          .dashboardData.totalCompleted!,
                                      color: Colors.deepPurple,
                                    ),
                                    const SizedBox(width: 10),
                                    DashboardStatusBox(
                                      statusText: 'Cancelled',
                                      statusValue: dashboardViewModel
                                          .dashboardData.totalCancelled!,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            bottom: -1,
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: kColorWhite,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: kSecondaryColorDark, width: 5)),
                        child: Column(children: [
                          Container(
                            // color: kColorWhite,
                            padding: const EdgeInsets.only(top: 0),
                            height: 350,
                            // child: Container(),
                            child: PageView(
                              controller: dashboardViewModel.chartController,
                              children: const [
                                DoughNutPaymentType(),
                                BarBookingStatus(),
                                BarServiceBooked()
                              ],
                            ),
                            decoration: const BoxDecoration(
                              color: kColorWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              // border: Border.all(
                              //     color: kTertiaryColorDark, width: 0)
                            ),
                          ),
                        ]),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(10),
                      //   width: double.infinity,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Chart',
                      //         style: Theme.of(context).textTheme.headline6,
                      //       ),
                      //       const SizedBox(height: 15),
                      //       Container(
                      //         width: double.infinity,
                      //         decoration: BoxDecoration(
                      //             border:
                      //                 Border.all(color: Colors.red, width: 2)),
                      //         child: const Text('sdfhsdkjfkjsdhf'),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: Text('Having some problem to load data'));
              }
          }
        });
  }
}
