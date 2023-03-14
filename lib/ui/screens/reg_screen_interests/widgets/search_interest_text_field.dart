import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';

class SearchInterestTextField extends StatefulWidget {
  const SearchInterestTextField({super.key});

  @override
  State<SearchInterestTextField> createState() => _SearchInterestTextFieldState();
}

class _SearchInterestTextFieldState extends State<SearchInterestTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchStringIsEmpty =
        context.select<RegScreenInterestsProvider, bool>((pr) => pr.searchString.trim().isEmpty);

    final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);

    if (searchStringIsEmpty) _controller.text = '';

    return TextField(
      controller: _controller,
      cursorColor: Colors.black,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        isDense: true,
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        hintText: '  Поиск интересов',
        hintStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 17, color: Colors.grey),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 10),
            Icon(Icons.search, color: Colors.grey, size: 21),
            SizedBox(width: 8),
          ],
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      onTap: () {},
      onChanged: (value) {
        provider.setSearchString(value);
      },
    );
  }
}
