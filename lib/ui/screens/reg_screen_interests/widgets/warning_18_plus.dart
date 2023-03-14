import 'package:flutter/material.dart';

class Warning18Plus extends StatelessWidget {
  final void Function() onAgreePress;

  const Warning18Plus({super.key, required this.onAgreePress});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width - 100,
      width: 320,
      margin: const EdgeInsets.only(bottom: 40),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(
          width: 2,
          color: Colors.grey.shade400,
        ),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 3)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Раздел 18+',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Этот раздел содержит материалы, которые могут носить деликатный характер.  Желаешь продолжить?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(80, 80, 80, 1),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 44,
                  width: 128,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Отмена',
                    style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 17.2),
                  ),
                ),
              ),
              const SizedBox(width: 7),
              GestureDetector(
                onTap: () => onAgreePress(),
                child: Container(
                  height: 44,
                  width: 132,
                  decoration: const BoxDecoration(
                    color: Color(0xFF910AFB),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Продолжить',
                    style: TextStyle(color: Colors.white, fontSize: 17.2),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
