import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final Function(String) onSearch;

  const FilterBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Search transactions...",
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: onSearch,
    );
  }
}