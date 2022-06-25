import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/screen/dashboard_screen/chart/bar_booking_status.dart';
import 'package:sainee_detailing/viewmodels/dashboard_viewmodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarServiceBooked extends StatelessWidget {
  const BarServiceBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel dashboardViewModel =
        Provider.of<DashboardViewModel>(context);

    return SfCartesianChart(
      title: ChartTitle(text: 'Overall Service Booked'),
      // legend:
      //     Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: dashboardViewModel.tooltipBehavior,
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        ColumnSeries<BarData, String>(
          name: 'Service',
          pointColorMapper: (BarData data, _) => data.color,
          dataSource: dashboardViewModel.barServiceBookedData,
          xValueMapper: (BarData data, _) => data.label,
          yValueMapper: (BarData data, _) => data.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          animationDuration: 1,
          // color: kPrimaryColor,
        )
      ],
    );
  }
}
