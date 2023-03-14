import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unyapp/ui/screens/reg_screen_media/const.dart';
import 'package:unyapp/ui/screens/reg_screen_media/widgets/crop_image_dialog.dart';

class GridPhotoItem extends StatelessWidget {
  final bool isFirst;
  final Image? image;
  final void Function(Image img) onImageSelected;
  final void Function(Image img) onImageDeleted;

  const GridPhotoItem({
    super.key,
    required this.isFirst,
    this.image,
    required this.onImageSelected,
    required this.onImageDeleted,
  });

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    Navigator.of(context).pop();
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      await Future.delayed(const Duration(milliseconds: 100));

      // ignore: use_build_context_synchronously
      final croppedImage = await cropImageDialog(context, image);
      if (croppedImage == null) return;
      onImageSelected(croppedImage);
    } catch (e) {
      //print(e);
    }
  }

  void _showBottomSheetGalleryOrCameraSelection(BuildContext context) {
    const kCaptionTextStyle = TextStyle(fontSize: 20, color: Color(0xFF424242));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: kBarrierColor,
      builder: (_) {
        return Container(
          height: 180,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 110,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickImage(context, ImageSource.gallery),
                    child: Column(
                      children: [
                        Opacity(
                            opacity: 0.5,
                            child: Image.asset('assets/icons/gallery.png', width: 74, height: 74)),
                        const SizedBox(height: 10),
                        const Text('Галерея', style: kCaptionTextStyle)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickImage(context, ImageSource.camera),
                    child: Column(
                      children: [
                        Transform.scale(
                          scale: 1.10,
                          child: Opacity(
                              opacity: 0.52,
                              child:
                                  Image.asset('assets/icons/camera4.png', width: 74, height: 74)),
                        ),
                        const SizedBox(height: 10),
                        const Text('Камера', style: kCaptionTextStyle)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var caption = (isFirst) ? 'Фотография\nпрофиля' : 'Нажми\nдля загрузки';

    return GestureDetector(
      onTap: () {
        if (image == null) {
          _showBottomSheetGalleryOrCameraSelection(context);
        }
      },
      child: (image == null)
          ? Container(
              decoration: isFirst ? kGridFirstPhotoDecoration : kGridPhotoDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Icon(
                    Icons.add_circle_rounded,
                    color: isFirst ? const Color(0xFFFF9D0A) : const Color(0xFFC4C4C4),
                    size: 32,
                  ),
                  const SizedBox(height: 4),
                  Opacity(
                    opacity: isFirst ? 1.0 : 0.45,
                    child: Text(
                      caption,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
          : Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: isFirst
                      ? kGridFirstPhotoDecoration.copyWith(
                          image: DecorationImage(image: image!.image, fit: BoxFit.cover),
                        )
                      : kGridPhotoDecoration.copyWith(
                          image: DecorationImage(image: image!.image, fit: BoxFit.cover),
                          border: kGridPhotoImageBorder,
                        ),
                ),
                Positioned(
                  bottom: -3,
                  right: -3,
                  child: GestureDetector(
                    onTap: () => onImageDeleted(image!),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 2)
                          ]),
                      child: Center(
                        //child: Icon(Icons.close, size: 16, color: Colors.grey),
                        child: SvgPicture.asset('assets/icons/delete.svg', width: 10, height: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
