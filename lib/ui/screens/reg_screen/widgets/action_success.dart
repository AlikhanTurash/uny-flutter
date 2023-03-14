import 'package:flutter/material.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';

class ActionSuccess extends StatefulWidget {
  final void Function() successAction;
  final void Function() successCallback;

  const ActionSuccess({
    super.key,
    required this.successAction,
    required this.successCallback,
  });

  @override
  State<ActionSuccess> createState() => _ActionSuccessState();
}

class _ActionSuccessState extends State<ActionSuccess> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        widget.successAction();
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          widget.successCallback();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: kDoneButtonHeight,
      child: Center(child: Icon(Icons.check, color: Color(0x80FFFFFF), size: 27)),
    );
  }
}
