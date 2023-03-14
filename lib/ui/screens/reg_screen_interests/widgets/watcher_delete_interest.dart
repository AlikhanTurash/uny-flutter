import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:unyapp/logic/reg_screen_interests/delete_interest_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/logic/x_status.dart';

class WatcherDeleteInterest extends StatelessWidget {
  const WatcherDeleteInterest({super.key});

  //-----
  void _deleteInterestFromSelected(BuildContext context, int interestId) {
    print('deleteInterestFromSelected: $interestId');
    Future.delayed(const Duration(milliseconds: 50), () {
      final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);
      provider.deleteInterestFromSelected(interestId);
    });
  }

  //-----
  void _showErrorMessage(BuildContext context, String msg) {
    Future.delayed(const Duration(milliseconds: 50), () {
      showTopSnackBar(
        Overlay.of(context)!,
        CustomSnackBar.error(message: msg),
        animationDuration: const Duration(milliseconds: 500),
        displayDuration: const Duration(milliseconds: 1500),
      );
    });
  }
  //-----

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DeleteInterestCubit>().state;

    print('DeleteInterestCubit:  ' + state.status.toString());

    if (state.status == XStatus.success) {
      _deleteInterestFromSelected(context, state.interestId!);
    }

    if (state.status == XStatus.failure) {
      if (state.errorCode == 422) {
        print('Error code: 422');
        //_showErrorMessage(context, 'Интерес уже удален');
        _deleteInterestFromSelected(context, state.interestId!);
      } else {
        _showErrorMessage(context, state.errorMessage!);
      }
    }

    return const SizedBox.shrink();
  }
}
