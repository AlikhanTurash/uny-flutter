import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/logic/reg_screen/auth_cubit.dart';
import 'package:unyapp/logic/x_status.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/action_error.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/action_success.dart';

class NextButtonPhoneProgress extends StatelessWidget {
  final void Function() successCallback;
  final void Function() errorCallback;

  const NextButtonPhoneProgress({
    super.key,
    required this.successCallback,
    required this.errorCallback,
  });

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    switch (authState.status) {
      case XStatus.initial:
        return const SizedBox(height: kDoneButtonHeight);
      //---
      case XStatus.inProgress:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: kDoneButtonHeight,
              width: kDoneButtonWidth,
              decoration: kDoneButtonDecoration,
              child: const Center(
                child: SizedBox(
                  width: kDoneButtonProgressIndicatorHeight,
                  height: kDoneButtonProgressIndicatorHeight,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        );
      //---
      case XStatus.failure:
        return ActionError(
          errorMessage: authState.errorMessage ?? 'Error',
          errorCallback: errorCallback,
        );
      //---
      case XStatus.success:
        return ActionSuccess(
          successCallback: successCallback,
          successAction: () => RegScreenPhoneActions.gotoSmsCodeScreen(context),
        );
    }
  }
}
