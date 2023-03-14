import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/logic/reg_screen/reauth_cubit.dart';
import 'package:unyapp/logic/x_status.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/reauth_error.dart';

class ResendSmsCodeCountdown extends StatefulWidget {
  const ResendSmsCodeCountdown({super.key});

  @override
  State<ResendSmsCodeCountdown> createState() => _ResendSmsCodeCountdownState();
}

class _ResendSmsCodeCountdownState extends State<ResendSmsCodeCountdown> {
  late int _countDown;
  late Timer _timer;

  void _startCountDownTimer() {
    setState(() {
      _countDown = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        --_countDown;
      });
      if (_countDown == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startCountDownTimer();
  }

  @override
  void dispose() {
    try {
      _timer.cancel();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reAuthState = context.watch<ReAuthCubit>().state;

    if (reAuthState.status == XStatus.inProgress) {
      return const SpinKitWave(color: Colors.white, size: 21);
    }

    if (reAuthState.status == XStatus.failure) {
      RegScreenSmsCodeActions.resetAuthCubit(context);
      return ReAuthError(message: reAuthState.errorMessage!);
    }

    return GestureDetector(
      onTap: (_countDown > 0)
          ? null
          : () {
              RegScreenSmsCodeActions.reAuthPress(context);
              _startCountDownTimer();
            },
      child: Opacity(
        opacity: (_countDown > 0) ? 0.45 : 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (_countDown > 0)
                  ? 'Отправить повторно ($_countDown с)'
                  : 'Отправить повторно\u{00A0}',
              style: kInputAreaCaptionTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
