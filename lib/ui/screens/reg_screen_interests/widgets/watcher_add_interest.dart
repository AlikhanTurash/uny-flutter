import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:unyapp/logic/reg_screen_interests/add_interest_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/logic/x_status.dart';

class WatcherAddInterest extends StatelessWidget {
  const WatcherAddInterest({super.key});

  //-----
  void _addInterestToSelected(BuildContext context, int interestId) {
    print('addInterestToSelected: $interestId');
    Future.delayed(const Duration(milliseconds: 50), () {
      final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);
      provider.addInterestToSelected(interestId);
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
    final state = context.watch<AddInterestCubit>().state;

    print('AddInterestCubit:  ' + state.status.toString());

    if (state.status == XStatus.success) {
      _addInterestToSelected(context, state.interestId!);
    }

    if (state.status == XStatus.failure) {
      if (state.errorCode == 422) {
        print('Error code: 422');
        /*
        // Уже есть такой интерес. Всё равно добавляем, т.к. по сути это не ошибка
        _addInterestToSelected(context, state.interestId!);
        */
        // Не добавляем!
        _showErrorMessage(context, 'Интерес уже добавлен \nЛибо превышен лимит');
      } else {
        _showErrorMessage(context, state.errorMessage!);
      }
    }

    return const SizedBox.shrink();
  }
}
