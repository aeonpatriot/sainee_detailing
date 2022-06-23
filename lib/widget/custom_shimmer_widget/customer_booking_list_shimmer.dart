import 'package:flutter/material.dart';
import 'package:sainee_detailing/widget/custom_shimmer_widget/shimmer_widget.dart';

class CustomerBookingListShimmerWidget extends StatelessWidget {
  const CustomerBookingListShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[350]!))),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                ShimmerWidget(height: 16, width: 130),
                Expanded(child: SizedBox(height: 14)),
                ShimmerWidget(height: 14, width: 90),
              ],
            ),
            const SizedBox(height: 8),
            const ShimmerWidget(height: 14, width: 80),
            const SizedBox(height: 5),
            const ShimmerWidget(height: 14, width: 170),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: const [
                  Expanded(child: SizedBox(height: 2)),
                  ShimmerWidget(height: 16, width: 100),
                ],
              ),
            ),
          ],
        ));
  }
}
