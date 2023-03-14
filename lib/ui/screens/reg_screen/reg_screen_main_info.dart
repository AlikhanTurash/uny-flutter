import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/city_input_area.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/main_info_input_area.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/next_button_main_info.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/reg_back_button.dart';
import 'package:unyapp/ui/utils.dart';

class RegScreenMainInfo extends StatefulWidget {
  const RegScreenMainInfo({super.key});

  @override
  State<RegScreenMainInfo> createState() => _RegScreenMainInfoState();
}

class _RegScreenMainInfoState extends State<RegScreenMainInfo> {
  final _scrollController = ScrollController();
  late final StreamSubscription<bool> _keyboardSubscription;

  bool _isBackButtonVisible = true;
  bool _isBigCaptionVisible = true;
  bool _isSubCaptionVisible = true;
  bool _isMainDataCaptionVisible = true;

  @override
  void initState() {
    super.initState();

    final keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        _isBackButtonVisible = true;
        _isBigCaptionVisible = true;
        _isSubCaptionVisible = true;
        _isMainDataCaptionVisible = true;
        setState(() {});
      }
    });

    _scrollController.addListener(() {
      _isBackButtonVisible = (_scrollController.offset < 15);
      _isBigCaptionVisible = (_scrollController.offset < 55);
      _isSubCaptionVisible = (_scrollController.offset < 90);
      _isMainDataCaptionVisible = (_scrollController.offset < 145);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = isPhoneScreenSmall(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      backgroundColor: kStopGradientColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: kScreenDecoration,
            padding: const EdgeInsets.symmetric(horizontal: kHorizPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: isSmallScreen ? kTopPaddingStepScreenSmall : kTopPaddingStepScreen,
                ),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 350),
                  opacity: _isBackButtonVisible ? 1 : 0,
                  child: const RegBackButton(),
                ),

                isSmallScreen
                    ? const SizedBox(height: kTopPaddingTitleStepScreenSmall)
                    : const SizedBox(height: kTopPaddingTitleStepScreen),
                //
                Opacity(
                  opacity: _isBigCaptionVisible ? 1 : 0,
                  child: const Text('Как тебя зовут? 😇', style: kBigTextStyle),
                ),
                const SizedBox(height: kBigTextBottomMargin),

                Opacity(
                  opacity: _isSubCaptionVisible ? 1 : 0,
                  child: Text('Укажи свои имя, возраст', maxLines: 3, style: kSubTextStyle),
                ),
                //
                isSmallScreen ? const SizedBox(height: 35) : const SizedBox(height: 47),

                Opacity(
                  opacity: _isMainDataCaptionVisible ? 1 : 0,
                  child: Text('Основные данные', style: kBigTextStyle.copyWith(fontSize: 20)),
                ),
                //
                isSmallScreen ? const SizedBox(height: 16) : const SizedBox(height: 22),
                const MainInfoInputArea(),
                //
                isSmallScreen ? const SizedBox(height: 8) : const SizedBox(height: 14),
                Text('Местоположение', style: kBigTextStyle.copyWith(fontSize: 20)),
                //
                isSmallScreen ? const SizedBox(height: 16) : const SizedBox(height: 20),
                CityInputArea(isSmallScreen: isSmallScreen),
                //
                const Spacer(),
                const NextButtonMainInfo(),
                isSmallScreen ? const SizedBox(height: 33) : const SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
