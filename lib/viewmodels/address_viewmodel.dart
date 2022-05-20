import 'package:flutter/cupertino.dart';

class AddressViewModel extends ChangeNotifier {
  late dynamic datadata;

  Future testGetFutureData() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final testData = List<String>.generate(5000, (i) => 'Item $i');
    datadata = testData;
    return datadata;
    // return 'Success';
  }
}
