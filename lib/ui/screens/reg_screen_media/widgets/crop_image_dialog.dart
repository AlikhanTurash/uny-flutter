import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unyapp/ui/libs/crop_image/lib/crop_image.dart';
import 'package:unyapp/ui/screens/reg_screen_media/const.dart';

Future<Image?> cropImageDialog(BuildContext context, XFile image) {
  final controller = CropController(
    aspectRatio: 2 / 3,
    defaultCrop: const Rect.fromLTRB(0.05, 0.05, 0.95, 0.95),
  );

  return showDialog<Image?>(
    context: context,
    barrierColor: kBarrierColor,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Builder(
        builder: (context) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width - 2 * kHorizPadding,
              //height: 250,
              height: MediaQuery.of(context).size.height - 2 * 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 2, color: Colors.black38),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  Text(
                    'Обрезка фото',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: Center(
                      child: CropImage(
                        controller: controller,
                        image: Image.file(
                          File(image.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kNextButtonDecoration.color,
                          elevation: 0,
                          minimumSize: const Size(130, 36),
                        ),
                        onPressed: () async {
                          final img = await controller.croppedImage();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop(img);
                        },
                        child: const Text(
                          'Ok',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 6),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            elevation: 0,
                            minimumSize: const Size(130, 36),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          },
                          child: Text(
                            'Отмена',
                            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                          )),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 14),
                ],
              ));
        },
      ),
    ),
  );
}
