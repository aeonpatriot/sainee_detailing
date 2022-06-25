import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/viewmodels/dashboard_viewmodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughNutPaymentType extends StatelessWidget {
  const DoughNutPaymentType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel dashboardViewModel =
        Provider.of<DashboardViewModel>(context);

    return SfCircularChart(
      title: ChartTitle(text: 'Overall Payment Type'),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: dashboardViewModel.tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<DoughnutData, String>(
          dataSource: dashboardViewModel.doughPaymentStatusData,
          xValueMapper: (DoughnutData data, _) => data.paymentType,
          yValueMapper: (DoughnutData data, _) => data.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          animationDuration: 1,
        )
      ],
    );
  }
}

class DoughnutData {
  DoughnutData(this.paymentType, this.value);
  final String paymentType;
  final int value;
}

// class PaymentTypeDoughNut extends StatelessWidget {
//   const PaymentTypeDoughNut({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final DashboardViewModel dashboardViewModel =
//         Provider.of<DashboardViewModel>(context);

//     return SfCircularChart(
//       title: ChartTitle(text: 'Payment Type Data'),
//       legend:
//           Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
//       series: <CircularSeries>[
//         DoughnutSeries<DoughnutData, String>(
//           dataSource: dashboardViewModel.doughData,
//           xValueMapper: (DoughnutData data, _) => data.paymentType,
//           yValueMapper: (DoughnutData data, _) => data.value,
//           dataLabelSettings: const DataLabelSettings(
//             isVisible: true,
//           ),
//         )
//       ],
//     );
//   }
// }
