import 'package:flutter/material.dart';
import 'package:sainee_detailing/models/service.dart';
import 'package:sainee_detailing/validation/validation_item.dart';

class ServiceValidation extends ChangeNotifier {
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _details = ValidationItem(null, null);
  ValidationItem _smallPrice = ValidationItem(null, null);
  ValidationItem _mediumPrice = ValidationItem(null, null);
  ValidationItem _largePrice = ValidationItem(null, null);
  ValidationItem _suvPrice = ValidationItem(null, null);
  ValidationItem _mpvPrice = ValidationItem(null, null);

  ValidationItem get name => _name;
  ValidationItem get details => _details;
  ValidationItem get smallPrice => _smallPrice;
  ValidationItem get mediumPrice => _mediumPrice;
  ValidationItem get largePrice => _largePrice;
  ValidationItem get suvPrice => _suvPrice;
  ValidationItem get mpvPrice => _mpvPrice;

  void setName(String name) {
    if (name.isNotEmpty) {
      _name = ValidationItem(name, null);
    } else {
      _name = ValidationItem(null, 'Please insert details');
    }
    notifyListeners();
  }

  void setDetails(String details) {
    if (details.isNotEmpty) {
      _details = ValidationItem(details, null);
    } else {
      _details = ValidationItem(null, 'Please insert details');
    }
    notifyListeners();
  }

  List<String> convertStringtoList(String details) {
    if (details.endsWith('|')) {
      String newDetails = details.substring(0, details.length - 1);
      return newDetails.split('|');
    } else {
      return details.split('|');
    }
  }

  String convertListtoString(List<String> details) {
    String converted = '';
    for (String detail in details) {
      converted = converted + '|' + detail;
    }
    return converted.substring(1);
  }

  void setSmallPrice(String smallPrice) {
    if (smallPrice.isNotEmpty) {
      _smallPrice = ValidationItem(smallPrice, null);
    } else {
      _smallPrice = ValidationItem(null, 'Please insert details');
    }
    notifyListeners();
  }

  void setMediumPrice(String mediumPrice) {
    if (mediumPrice.isNotEmpty) {
      _mediumPrice = ValidationItem(mediumPrice, null);
    } else {
      _mediumPrice = ValidationItem(null, 'Please insert details');
    }
    notifyListeners();
  }

  void setLargePrice(String largePrice) {
    if (largePrice.isNotEmpty) {
      _largePrice = ValidationItem(largePrice, null);
    } else {
      _largePrice = ValidationItem(null, 'Please insert details');
    }
    notifyListeners();
  }

  void setSUVPrice(String suvPrice) {
    if (suvPrice.isNotEmpty) {
      _suvPrice = ValidationItem(suvPrice, null);
    } else {
      _suvPrice = ValidationItem(null, 'Please insert details');
    }
    notifyListeners();
  }

  void setMPVPrice(String mpvPrice) {
    if (mpvPrice.isNotEmpty) {
      _mpvPrice = ValidationItem(mpvPrice, null);
    } else {
      _mpvPrice = ValidationItem(null, 'Please insert details');
    }
    notifyListeners();
  }

  Service getValidatedService() {
    final Service service = Service(
      name: name.value,
      details: [...convertStringtoList(details.value!)],
      smallPrice: smallPrice.value,
      mediumPrice: mediumPrice.value,
      largePrice: largePrice.value,
      suvPrice: suvPrice.value,
      mpvPrice: mpvPrice.value,
    );
    return service;
  }

  bool isDetailsChanged(
      {required Service editedService, required Service originalService}) {
    if (originalService.name != editedService.name ||
        convertListtoString(originalService.details!) !=
            convertListtoString(editedService.details!) ||
        originalService.smallPrice != editedService.smallPrice ||
        originalService.mediumPrice != editedService.mediumPrice ||
        originalService.largePrice != editedService.largePrice ||
        originalService.suvPrice != editedService.suvPrice ||
        originalService.mpvPrice != editedService.mpvPrice) {
      return true;
    } else {
      return false;
    }
  }

  bool isServiceDetailsValid() {
    if (name.value == null ||
        details.value == null ||
        smallPrice.value == null ||
        mediumPrice.value == null ||
        largePrice.value == null ||
        suvPrice.value == null ||
        mpvPrice.value == null) {
      return false;
    } else {
      return true;
    }
  }

  void setValidationItemEdit({required Service service}) {
    _name = ValidationItem(service.name, null);
    _details = ValidationItem(convertListtoString(service.details!), null);
    _smallPrice = ValidationItem(service.smallPrice, null);
    _mediumPrice = ValidationItem(service.mediumPrice, null);
    _largePrice = ValidationItem(service.largePrice, null);
    _suvPrice = ValidationItem(service.suvPrice, null);
    _mpvPrice = ValidationItem(service.mpvPrice, null);
  }

  void resetValidationItem() {
    _name = ValidationItem(null, null);
    _details = ValidationItem(null, null);
    _smallPrice = ValidationItem(null, null);
    _mediumPrice = ValidationItem(null, null);
    _largePrice = ValidationItem(null, null);
    _suvPrice = ValidationItem(null, null);
    _mpvPrice = ValidationItem(null, null);
  }

  bool isDetailsEmpty() {
    final bool isNameEmpty =
        (name.value == null || name.value == '') ? true : false;
    final bool isDetailsEmpty =
        (details.value == null || details.value == '') ? true : false;
    final bool isSmallPriceEmpty =
        (smallPrice.value == null || smallPrice.value == '') ? true : false;
    final bool isMediumPriceEmpty =
        (mediumPrice.value == null || mediumPrice.value == '') ? true : false;
    final bool isLargePriceEmpty =
        (largePrice.value == null || largePrice.value == '') ? true : false;
    final bool isSuvPriceEmpty =
        (suvPrice.value == null || suvPrice.value == '') ? true : false;
    final bool isMpvPriceEmpty =
        (mpvPrice.value == null || mpvPrice.value == '') ? true : false;
    if (isNameEmpty &&
        isDetailsEmpty &&
        isSmallPriceEmpty &&
        isMediumPriceEmpty &&
        isLargePriceEmpty &&
        isSuvPriceEmpty &&
        isMpvPriceEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
