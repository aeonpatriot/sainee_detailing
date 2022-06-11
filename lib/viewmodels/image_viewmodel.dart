import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/services/user_service.dart';
import 'package:sainee_detailing/widget/custom_cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sainee_detailing/widget/custom_placeholder_image.dart';

class ImageViewModel extends ChangeNotifier {
  final userService = service<UserService>();

  // for header image
  XFile? headerImageFile;
  XFile? headerTempFile;
  bool isHeaderChanged = false;

  // for profile image
  XFile? profileImageFile;
  XFile? profileTempFile;
  bool isProfileChanged = false;

  // for car image
  XFile? carImageFile;
  XFile? carTempFile;
  bool isCarChanged = false;

  String? retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  setHeaderImageFile(XFile? value) {
    headerImageFile = value;
    // notifyListeners();
  }

  setProfileImageFile(XFile? value) {
    profileImageFile = value;
    // notifyListeners();
  }

  setCarImageFile(XFile? value) {
    carImageFile = value;
    // notifyListeners();
  }

  void resetImagePicker() {
    headerImageFile = null;
    headerTempFile = null;
    isHeaderChanged = false;
    profileImageFile = null;
    profileTempFile = null;
    isProfileChanged = false;
    carImageFile = null;
    carTempFile = null;
    isCarChanged = false;
  }

  void headerImagePicker() async {
    headerImageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    headerImageFile ??= headerTempFile;
    headerTempFile = headerImageFile;

    if (headerTempFile != null) {
      isHeaderChanged = true;
      notifyListeners();
    }
  }

  void profileImagePicker() async {
    profileImageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

    profileImageFile ??= profileTempFile;
    profileTempFile = profileImageFile;

    if (profileTempFile != null) {
      isProfileChanged = true;
      notifyListeners();
    }
  }

  void carImagePicker() async {
    carImageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

    carImageFile ??= carTempFile;
    carTempFile = carImageFile;

    if (carTempFile != null) {
      isCarChanged = true;
      notifyListeners();
    }
  }

  Widget previewCarImage(String? carImageUrl, String? carImageName) {
    if (carImageUrl != null && carImageFile == null) {
      print('image from netowrk in image vm');
      return Hero(
        tag: '$carImageName',
        child: CustomCachedNetworkImage(
          key: UniqueKey(),
          imageUrl: carImageUrl,
        ),
      );
    } else {
      if (carImageFile != null) {
        return Image.file(
          File(carImageFile!.path),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 250,
        );
      } else {
        return const CustomPlaceholderImage();
      }
    }
  }

  Widget previewHeaderImage(String? headerImageUrl) {
    if (headerImageUrl != null && headerImageFile == null) {
      print('image from netowrk in image vm');
      return CustomCachedNetworkImage(
        key: UniqueKey(),
        imageUrl: headerImageUrl,
      );
    } else {
      if (headerImageFile != null) {
        return Image.file(
          File(headerImageFile!.path),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 250,
        );
      } else {
        return const CustomPlaceholderImage();
      }
    }
  }

  Widget previewProfileImage(String? profileImageUrl) {
    if (profileImageUrl != null && profileImageFile == null) {
      return Hero(
        tag: 'profileImage',
        child: CustomCachedNetworkImage(
          key: UniqueKey(),
          imageUrl: profileImageUrl,
          isCircle: true,
        ),
      );
    } else {
      if (profileImageFile != null) {
        return Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: FileImage(
                File(profileImageFile!.path),
              ),
            ),
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
        );
      } else {
        return const CustomPlaceholderImage(
          isCircle: true,
        );
      }
    }
  }

  Future<void> retrieveLostData({required String imageType}) async {
    final LostDataResponse response = await _picker.retrieveLostData();

    if (imageType == 'headerImage') {
      if (response.isEmpty) {
        return;
      }
      if (response.file != null) {
        setHeaderImageFile(response.file);
      } else {
        retrieveDataError = response.exception!.code;
      }
    }

    if (imageType == 'profileImage') {
      if (response.isEmpty) {
        return;
      }
      if (response.file != null) {
        setProfileImageFile(response.file);
      } else {
        retrieveDataError = response.exception!.code;
      }
    }

    if (imageType == 'carImage') {
      if (response.isEmpty) {
        return;
      }
      if (response.file != null) {
        setCarImageFile(response.file);
      } else {
        retrieveDataError = response.exception!.code;
      }
    }
  }

  void clearCache() {
    DefaultCacheManager().emptyCache();
    imageCache.clear();
    imageCache.clearLiveImages();
    notifyListeners();
  }
}
