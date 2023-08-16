import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  /// Callback triggered when the content of the search input changes.
  final Function(String) onChanged;

  /// Callback triggered when the search input is submitted.
  final Function() onSubmitted;

  /// Custom decoration for styling the search input field.
  final InputDecoration? decoration;

  /// TextStyle for customizing the appearance of the search input.
  final TextStyle? style;

  /// The color of the default search input icon.
  final Color? defaultSearchInputIconColor;

  const SearchInput({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    this.decoration,
    this.style,
    this.defaultSearchInputIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted(),
      cursorColor: style?.color,
      style: style,
      decoration: decoration ??
          InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.search,
              color: defaultSearchInputIconColor ??
                  (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white54
                      : Colors.black38),
            ),
            filled: true,
          ),
    );
  }
}
