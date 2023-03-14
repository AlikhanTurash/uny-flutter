import 'package:flutter/material.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';

class ActionError extends StatelessWidget {
  final String errorMessage;
  final void Function() errorCallback;

  const ActionError({
    super.key,
    required this.errorMessage,
    required this.errorCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: kDoneButtonHeight, width: 8),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                errorMessage, //'Ошибка',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: kErrorTextColor, fontSize: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            onPressed: () => errorCallback(),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
