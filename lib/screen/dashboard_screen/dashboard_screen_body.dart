import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/dashboard_viewmodel.dart';
import 'package:sainee_detailing/widget/dashboard_status_box.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                            padding: const EdgeInsets.only(top: 0),
                            height: 350,
                            // child: Container(),
                            child: PageView(
                              controller: dashboardViewModel.chartController,
                              onPageChanged: (index) {
                                dashboardViewModel.setChartActiveIndex(index);
                              },
                              children:
                                  dashboardViewModel.dashboardPageViewList,
                            ),
                            decoration: const BoxDecoration(
                              color: kColorWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              // border: Border.all(
                              //     color: kTertiaryColorDark, width: 0)
                            ),
                          ),
                          Container(
                            height: 20,
                            width: double.infinity,
                            color: kColorWhite,
                            child: Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex:
                                    dashboardViewModel.chartActiveIndex,
                                count: dashboardViewModel
                                    .dashboardPageViewList.length,
                                effect: CustomizableEffect(
                                  activeDotDecoration: DotDecoration(
                                    width: 19,
                                    height: 8,
                                    color: Colors.indigo,
                                    rotationAngle: 180,
                                    verticalOffset: -10,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  dotDecoration: DotDecoration(
                                    width: 12,
                                    height: 6,
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(16),
                                    verticalOffset: 0,
                                  ),
                                  spacing: 6.0,
                                  // activeColorOverride: (i) => colors[i],
                                  inActiveColorOverride: (i) =>
                                      dashboardViewModel.sliderColors[i],
                                ),
                                // const ExpandingDotsEffect(
                                //     activeDotColor: kSecondaryColorDark,
                                //     dotHeight: 5,
                                //     dotWidth: 5),
                              ),
                            ),
                          ),
                          Container(color: kColorWhite, height: 10)
                        ]),
                      ),
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
