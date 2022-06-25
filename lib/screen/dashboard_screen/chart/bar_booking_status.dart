import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/viewmodels/dashboard_viewmodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarBookingStatus extends StatelessWidget {
  const BarBookingStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel dashboardViewModel =
        Provider.of<DashboardViewModel>(context);

    return SfCartesianChart(
      title: ChartTitle(text: 'Overall Booking Status'),
      // legend:
      //     Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: dashboardViewModel.tooltipBehavior,
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        ColumnSeries<BarData, String>(
          name: 'Status',
          pointColorMapper: (BarData data, _) => data.color,
          dataSource: dashboardViewModel.barBookingStatusData,
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

class BarData {
  BarData({required this.label, required this.value, required this.color});
  final String label;
  final int value;
  final Color color;
}
