import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:unyapp/ui/screens/reg_screen_media/const.dart';
import 'package:unyapp/ui/screens/reg_screen_media/widgets/grid_photo_item.dart';
import 'package:unyapp/ui/screens/reg_screen_media/widgets/next_button_photos.dart';
import 'package:unyapp/ui/utils.dart';

class RegScreenPhotos extends StatefulWidget {
  const RegScreenPhotos({super.key});

  @override
  State<RegScreenPhotos> createState() => _RegScreenPhotosState();
}

class _RegScreenPhotosState extends State<RegScreenPhotos> {
  final List<Image?> _images = List.generate(9, (i) => null);

  int _getImagesCount() {
    int imagesCount = 0;
    for (var img in _images) {
      if (img != null) {
        imagesCount++;
      }
    }
    return imagesCount;
  }

  // Упорядочиваем фотки, чтобы не было "дырок"
  void _orderImages() {
    final n = _getImagesCount();
    for (var i = 0; i < n; i++) {
      if (_images[i] == null) {
        var k = -1;
        for (var j = i + 1; j < 9; j++) {
          if (_images[j] != null) {
            k = j;
            break;
          }
        }
        var tmpImg = _images[k];
        _images[i] = tmpImg;
        _images[k] = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = isPhoneScreenSmall(context);
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: [
            Container(
              color: kBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: kHorizPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: isSmallScreen ? kTopPaddingSmall : kTopPadding,
                  ),
                  Text('Загрузи своё фото',
                      style: kBigTextStyle.copyWith(color: Colors.black)),
                  const SizedBox(height: kBigTextBottomMargin),
                  Text(
                    'Удерживай и перетаскивай фото\nдля изменения их порядка',
                    maxLines: 3,
                    style: kSubTextStyle,
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 27),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: ((screenW - 2 * kHorizPadding - 2 * 10) / 3) *
                                (3 / 2) *
                                3 +
                            140,
                        color: Colors.transparent,
                        child: ReorderableGridView.count(
                          padding: EdgeInsets.zero,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 11,
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: List.generate(
                            9,
                            (index) => GridPhotoItem(
                              key: ValueKey(index),
                              isFirst: (index == 0),
                              image: _images[index],
                              onImageSelected: (img) {
                                _images.removeAt(index);
                                _images.insert(index, img);
                                _orderImages();
                                setState(() {});
                              },
                              onImageDeleted: (img) {
                                if (_images.contains(img)) {
                                  final index = _images.indexOf(img);

                                  _images.removeAt(index);
                                  _images.insert(index, null);
                                  _orderImages();
                                  Future.delayed(
                                      const Duration(milliseconds: 50), () {});

                                  setState(() {});
                                }
                              },
                            ),
                          ),
                          onReorder: (oldIndex, newIndex) {
                            final element = _images.removeAt(oldIndex);
                            _images.insert(newIndex, element);
                            _orderImages();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 33, //38,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: NextButtonPhotos(
                    isEnabled: _getImagesCount() > 0,
                    onTap: () {
                      if (_getImagesCount() == 0) {
                        showTopSnackBar(
                          Overlay.of(context)!,
                          const CustomSnackBar.error(
                              message: 'Загрузи хотя бы одно фото'),
                          animationDuration: const Duration(milliseconds: 700),
                          displayDuration: const Duration(milliseconds: 1300),
                        );
                        return;
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
