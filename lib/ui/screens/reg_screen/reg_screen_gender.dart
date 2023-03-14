import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/models/gender.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/update_gender_progress.dart';
import 'package:unyapp/ui/utils.dart';

class RegScreenGender extends StatelessWidget {
  const RegScreenGender({super.key});

  static const kGenderAssetsPath = 'assets/images/gender_screen';

  final String _genderPageLinesAsset = '$kGenderAssetsPath/gender_page_lines.svg';
  final String _dotAsset = '$kGenderAssetsPath/dot.svg';
  final String _avatarAsset = '$kGenderAssetsPath/avatar.svg';
  final String _heartAsset = '$kGenderAssetsPath/heart.svg';
  final String _heart1Asset = '$kGenderAssetsPath/heart_1.svg';
  final String _pcAsset = '$kGenderAssetsPath/pc.svg';
  final String _moneyAsset = '$kGenderAssetsPath/money.svg';
  final String _womanAsset = '$kGenderAssetsPath/woman.png';
  final String _manAsset = '$kGenderAssetsPath/man.png';
  final String _anotherGenderAsset = '$kGenderAssetsPath/another_gender.png';
  final String _logoAsset = '$kGenderAssetsPath/logo_no_background.png';

  static const kGenderTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = isPhoneScreenSmall(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: kScreenDecoration,
          padding: const EdgeInsets.symmetric(horizontal: kHorizPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   width: double.infinity,
              //   height: isSmallScreen ? kTopPaddingStepScreenSmall : kTopPaddingStepScreen,
              // ),
              // const RegBackButton(),
              // isSmallScreen
              //     ? const SizedBox(height: kTopPaddingTitleStepScreenSmall)
              //     : const SizedBox(height: kTopPaddingTitleStepScreen),
              SizedBox(
                width: double.infinity,
                height: isSmallScreen ? kTopPaddingSmall : kTopPadding,
              ),
              const Text('Укажи свой пол ☺', style: kBigTextStyle),
              const SizedBox(height: kBigTextBottomMargin),
              Text(
                'Это нужно, чтобы мы могли правильно подобрать тебе единомышленника',
                maxLines: 3,
                style: kSubTextStyle,
              ),
              Expanded(
                child: Transform.scale(
                  scale: isSmallScreen ? 0.8 : 0.97,
                  child: Center(
                    child: Transform.translate(
                      offset: isSmallScreen ? const Offset(-12, 0) : const Offset(-4, 0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const SizedBox(height: 500, width: 350),
                          Positioned(
                              left: 0, top: 45, child: SvgPicture.asset(_genderPageLinesAsset)),
                          Positioned(
                            left: 41,
                            top: -19,
                            child: GestureDetector(
                              onTap: () {
                                RegScreenGenderActions.setGender(context, Gender.female);
                              },
                              child: Column(
                                children: [
                                  Image.asset(_womanAsset),
                                  Transform.translate(
                                      offset: const Offset(-5, 0),
                                      child: const Text('Женский', style: kGenderTextStyle)),
                                ],
                              ),
                            ),
                          ),
                          Positioned(left: 125, top: 221, child: Image.asset(_logoAsset)),
                          Positioned(
                              left: 77,
                              top: 415,
                              child: GestureDetector(
                                onTap: () {
                                  RegScreenGenderActions.setGender(context, Gender.other);
                                },
                                child: Column(
                                  children: [
                                    Image.asset(_anotherGenderAsset),
                                    const Text('Другое', style: kGenderTextStyle)
                                  ],
                                ),
                              )),
                          Positioned(
                              left: 278,
                              top: 126,
                              child: GestureDetector(
                                onTap: () {
                                  RegScreenGenderActions.setGender(context, Gender.male);
                                },
                                child: Column(
                                  children: [
                                    Image.asset(_manAsset),
                                    Transform.translate(
                                        offset: const Offset(-3, 0),
                                        child: const Text('Мужской', style: kGenderTextStyle))
                                  ],
                                ),
                              )),
                          Positioned(left: 250, top: 428, child: SvgPicture.asset(_heartAsset)),
                          Positioned(left: 40, top: 285, child: SvgPicture.asset(_pcAsset)),
                          Positioned(left: 0, top: 295, child: SvgPicture.asset(_moneyAsset)),
                          Positioned(left: 208, top: 175, child: SvgPicture.asset(_heart1Asset)),
                          Positioned(left: 240, top: 98, child: SvgPicture.asset(_avatarAsset)),
                          Positioned(left: 156, top: 124, child: SvgPicture.asset(_dotAsset)),
                          Positioned(left: 24, top: 240, child: SvgPicture.asset(_dotAsset)),
                          Positioned(left: 148, top: 354, child: SvgPicture.asset(_dotAsset)),

                          //
                          const Positioned.fill(child: UpdateGenderProgress()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (!isSmallScreen) const SizedBox(height: 45),
            ],
          ),
        ),
      ),
      //),
    );
  }
}
