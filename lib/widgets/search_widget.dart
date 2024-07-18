import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

final _search = TextEditingController();

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 20,
          )),
          labelText: "tadbir_nomi_bo'yicha...".tr(),
          suffixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
          prefixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))),
    );
  }
}
