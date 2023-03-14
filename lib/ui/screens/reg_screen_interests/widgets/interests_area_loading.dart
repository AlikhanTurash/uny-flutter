import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/data/categories.dart';
import 'package:unyapp/logic/reg_screen_interests/interests_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/logic/x_status.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/interests_area.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/warning_18_plus.dart';

class InterestsAreaLoading extends StatelessWidget {
  const InterestsAreaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final interestsState = context.watch<InterestsCubit>().state;

    // if (interestsState.status == XStatus.initial) {
    //   BlocProvider.of<InterestsCubit>(context, listen: false).getInterests();
    //   return const SizedBox.shrink();
    // }

    switch (interestsState.status) {
      case XStatus.initial:
        return Center(
          child: Warning18Plus(
            onAgreePress: () {
              BlocProvider.of<InterestsCubit>(context, listen: false).getInterests();
            },
          ),
        );
      //---
      case XStatus.inProgress:
        return Center(
          child: SpinKitSpinningLines(
            color: unyCategories[0].mainColor.withOpacity(0.5),
            size: 80,
            lineWidth: 6,
          ),
        );
      //---
      case XStatus.failure:
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  interestsState.errorMessage ?? 'Error',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.red.shade400),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<InterestsCubit>(context, listen: false).getInterests();
                  },
                  child: const Text(
                    'Попробовать снова',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
        );
      //---
      case XStatus.success:
        final provider = Provider.of<RegScreenInterestsProvider>(context);
        provider.allInterestsInitialization(interestsState.interests);

        return const InterestsArea();
    }
  }
}
