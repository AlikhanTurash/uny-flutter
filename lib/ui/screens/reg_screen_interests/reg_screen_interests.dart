import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/categories.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/const.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/categories_selector.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/fill_progress_indicator.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/interests_area_loading.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/next_button.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/next_button_interests.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/search_interest_text_field.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/selected_interests.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/watcher_add_interest.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/watcher_delete_interest.dart';

class RegScreenInterests extends StatefulWidget {
  const RegScreenInterests({super.key});

  @override
  State<RegScreenInterests> createState() => _RegScreenInterestsState();
}

class _RegScreenInterestsState extends State<RegScreenInterests> {
  @override
  Widget build(BuildContext context) {
    //final isSmallScreen = isPhoneScreenSmall(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: kBackgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //-------------
            SizedBox(
                height: kTopPadding,
                width: double.infinity,
                child: Row(children: const [WatcherAddInterest(), WatcherDeleteInterest()])),
            //-------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizPadding),
              child: SearchInterestTextField(),
            ),
            //---
            const SizedBox(height: 17),
            //---
            //const Categories(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizPadding),
              child: Text('Выбери категорию', style: kSelectCategoryLabelStyle),
            ),
            //---
            const SizedBox(height: 7),
            //---
            const CategoriesSelector(),
            //---
            const SizedBox(height: 15),
            //---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizPadding + 1),
              child: FillProgressIndicator(
                width: MediaQuery.of(context).size.width,
              ),
            ),
            //---
            const SizedBox(height: 3),
            //---
            const SelectedInterests(),
            //---
            Container(height: 2, width: double.infinity, color: Colors.black.withOpacity(0.12)),
            //---
            const SizedBox(height: 20),
            //---
            const Expanded(child: InterestsAreaLoading()),
            //---
            const SizedBox(
              height: 100,
              width: double.infinity,
              child: Center(child: NextButtonInterests()),
            ),
            //---
          ],
        ),
      ),
    );
  }
}
