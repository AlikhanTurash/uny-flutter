import 'package:flutter/material.dart';

Future<void> showTooltipDialog(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return showDialog<String>(
    context: context,
    barrierColor: Colors.white.withOpacity(0.85),
    //barrierColor: Colors.black.withOpacity(0.2),
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      elevation: 8,
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      alignment: Alignment.topCenter,
      //insetPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.only(top: 216),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      title: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Center(
          child: Text(
            'Выбери свои интересы',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            //color: Colors.amber,
            constraints: BoxConstraints(maxWidth: width * 0.7),
            child: const Text(
                'Чем больше интересов ты добавишь, тем быстрее мы подберём для тебя пару '
                'и просчитаем совместимость',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.3)),
          ),
        ),
      ),
    ),
  );
}
