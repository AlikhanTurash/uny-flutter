import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/logic/reg_screen/update_gender_cubit.dart';
import 'package:unyapp/logic/x_status.dart';

class UpdateGenderProgress extends StatelessWidget {
  const UpdateGenderProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final updateGenderState = context.watch<UpdateGenderCubit>().state;

    switch (updateGenderState.status) {
      //---
      case XStatus.initial:
        return IgnorePointer(child: Container(color: Colors.transparent));
      //---
      case XStatus.inProgress:
        return AbsorbPointer(
          child: Container(
            color: Colors.white.withOpacity(0.03),
            child: Transform.translate(
              offset: const Offset(-5.5, 20),
              child: const Center(
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
              ),
            ),
          ),
        );
      //---
      case XStatus.failure:
        Future.delayed(const Duration(milliseconds: 1000), () {
          RegScreenGenderActions.selectGenderErrorCallback(context);
        });
        return _UpdateGenderError(message: updateGenderState.errorMessage!);
      //---
      case XStatus.success:
        Future.delayed(const Duration(milliseconds: 100), () {
          RegScreenGenderActions.gotoMainInfoInputScreen(context);
        });
        return AbsorbPointer(child: Container(color: Colors.white.withOpacity(0.03)));
      //---
    }
  }
}

//--------------------

class _UpdateGenderError extends StatefulWidget {
  final String message;

  const _UpdateGenderError({required this.message});

  @override
  State<_UpdateGenderError> createState() => _UpdateGenderErrorState();
}

class _UpdateGenderErrorState extends State<_UpdateGenderError> {
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
    return AbsorbPointer(child: Container(color: Colors.white.withOpacity(0.03)));
  }
}
