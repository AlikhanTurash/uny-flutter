import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/logic/reg_screen/update_main_info_cubit.dart';
import 'package:unyapp/logic/x_status.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/action_error.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/action_success.dart';

class NextButtonMainInfoProgress extends StatelessWidget {
  final void Function() successCallback;
  final void Function() errorCallback;

  const NextButtonMainInfoProgress({
    super.key,
    required this.successCallback,
    required this.errorCallback,
  });

  @override
  Widget build(BuildContext context) {
    final userUpdateState = context.watch<UpdateMainInfoCubit>().state;

    switch (userUpdateState.status) {
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
          errorMessage: userUpdateState.errorMessage ?? 'Error',
          errorCallback: errorCallback,
        );
      //---
      case XStatus.success:
        return ActionSuccess(
          successCallback: successCallback,
          successAction: () => RegScreenMainInfoActions.gotoAddPhotosScreen(context),
        );
    }
  }
}
