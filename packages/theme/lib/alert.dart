import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

enum SnackBarType { success, error, warning, info }

extension on SnackBarType {
  // Change this according to type
  Color get bgColor => switch (this) {
        SnackBarType.info => AppColors.primaryColor,
        SnackBarType.error => AppColors.red,
        SnackBarType.success => AppColors.green,
        SnackBarType.warning => AppColors.warning,
      };
}

extension SnackBarX on BuildContext {
  Size get size => MediaQuery.of(this).size;
  void showSnackBar(String message, {SnackBarType type = SnackBarType.info}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: AppColors.primaryWhiteColor),
        ),
        backgroundColor: AppColors.primaryBlackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: size.width > 1200 ? (size.width - 400) / 2 : 16,
          vertical: 16,
        ),
      ),
    );
  }
}


// ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text(
//           'OTP sent to your mobile number',
//           style: TextStyle(color: AppColors.primaryWhiteColor),
//         ),
//         backgroundColor: AppColors.primaryBlackColor,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         margin: const EdgeInsets.all(16),
//       ),
//     );