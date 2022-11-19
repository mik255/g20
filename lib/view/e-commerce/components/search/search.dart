import 'package:flutter/material.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent(
      {Key? key, required this.onChanged})
      : super(key: key);
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: TextField(
        onChanged: (String value) {
          onChanged(value);
        },
        decoration:  InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Search Data",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
