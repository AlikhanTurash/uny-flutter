import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';

class LoginError extends StatefulWidget {
  final void Function() errorCallback;

  const LoginError({super.key, required this.errorCallback});

  @override
  State<LoginError> createState() => _LoginErrorState();
}

class _LoginErrorState extends State<LoginError> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 10), () {
        Provider.of<RegScreenProvider>(context, listen: false).setIsSmsCodeWrong(true);
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 20), () {
        widget.errorCallback();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: kDoneButtonHeight);
  }
}
