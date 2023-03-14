import 'package:flutter/material.dart';

class AddNewInterestButton extends StatelessWidget {
  const AddNewInterestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
          height: 44,
          width: 300,
          decoration: const BoxDecoration(
            color: Color(0xFF910AFB),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          alignment: Alignment.center,
          child: Row(
            children: const [
              Spacer(),
              Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Добавить новый интерес',
                style: TextStyle(color: Colors.white, fontSize: 17.2),
              ),
              SizedBox(width: 4),
              Spacer(),
            ],
          )),
    );
  }
}
