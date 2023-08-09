import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final Function(String) onChanged;
  final Function() onSubmitted;
  final bool autofocus;
  final InputDecoration? decoration;
  final TextStyle? style;
  final Color? defaultSearchInputIconColor;

  const SearchInput({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    required this.autofocus,
    this.decoration,
    this.style,
    this.defaultSearchInputIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        autofocus: autofocus,
        onChanged: onChanged,
        onSubmitted: (_) => onSubmitted(),
        cursorColor: style?.color,
        style: style,
        decoration: decoration ??
            InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: defaultSearchInputIconColor ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black38),
              ),
              filled: true,
            ),
      ),
    );
  }
}
