import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';

class ReAuthError extends StatefulWidget {
  final String message;

  const ReAuthError({super.key, required this.message});

  @override
  State<ReAuthError> createState() => _ReAuthErrorState();
}

class _ReAuthErrorState extends State<ReAuthError> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTopSnackBar(
        Overlay.of(context)!,
        CustomSnackBar.error(message: widget.message),
        animationDuration: const Duration(milliseconds: 700),
        displayDuration: const Duration(milliseconds: 1700),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ошибка',
            style: kInputAreaCaptionTextStyle.copyWith(color: kErrorTextColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
