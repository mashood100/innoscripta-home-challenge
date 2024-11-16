import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class SnackbarHelper {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static SnackBar _getSnackbar(String message,
      {int? duration = 3,
      String? actionLabel = 'Undo',
      VoidCallback? action,
      bool isBottomSheetOpen = false}) {
    final BuildContext context = scaffoldMessengerKey.currentContext!;

    final colorScheme = Theme.of(context).colorScheme;

    return SnackBar(
      margin: EdgeInsets.only(
        bottom: isBottomSheetOpen
            ? MediaQuery.of(context).size.height * 0.525
            : 16.h,
        right: 34.w,
        left: 34.w,
      ),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: AppText.bodyMedium.cl(colorScheme.onInverseSurface),
      ),
      showCloseIcon: true,
      closeIconColor: colorScheme.onInverseSurface,
      backgroundColor: colorScheme.inverseSurface,
      duration: Duration(seconds: duration!),
      action: action != null
          ? SnackBarAction(
              textColor: colorScheme.inversePrimary,
              label: actionLabel!,
              onPressed: action,
            )
          : null,
    );
  }

  static void snackbarWithTextOnly(String message, {int? duration = 3}) {
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();

    scaffoldMessengerKey.currentState?.showSnackBar(
      _getSnackbar(message, duration: duration),
    );
  }

  static Future<SnackBarClosedReason> snackbarWithAction(
    String message, {
    int? duration = 3,
    String? actionLabel = 'Undo',
    required VoidCallback action,
  }) {
    scaffoldMessengerKey.currentState!.hideCurrentSnackBar();

    return scaffoldMessengerKey.currentState!
        .showSnackBar(
          _getSnackbar(
            message,
            duration: duration,
            actionLabel: actionLabel,
            action: action,
          ),
        )
        .closed;
  }
}
