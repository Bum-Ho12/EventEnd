import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showSearchBar = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedPadding(
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.only(top: 60, bottom: 20, left: 8, right: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: showSearchBar ? 360 : 50,
          decoration: BoxDecoration(
            color: showSearchBar
                ? backgroundColor.withOpacity(0.25)
                : backgroundColor2.withOpacity(0.5),
            boxShadow: [
              if (showSearchBar)
                BoxShadow(
                  color: backgroundColor,
                  blurRadius: 0.1,
                  spreadRadius: 0.1,
                ),
            ],
            borderRadius: BorderRadius.circular(showSearchBar ? 360 : 360),
          ),
          child: showSearchBar ? searchField() : searchIcon(),
        ),
      ),
    );
  }

  Widget searchField() {
    return Row(
      children: [
        searchEntry(),
        clearButton(),
      ],
    );
  }

  Widget searchEntry() {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search..',
          ),
        ),
      ),
    );
  }

  Widget searchIcon() {
    return IconButton(
      onPressed: () {
        if (mounted) {
          setState(() {
            showSearchBar = true;
          });
        }
      },
      tooltip: 'Search',
      icon: Icon(
        Icons.search,
        color: backgroundColor2,
      ),
    );
  }

  Widget clearButton() {
    return IconButton(
      tooltip: 'Clear',
      onPressed: () {
        if (mounted) {
          setState(() {
            showSearchBar = false;
          });
        }
      },
      icon: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(360),
        ),
        child: Icon(
          Icons.close,
          color: backgroundColor,
        ),
      ),
    );
  }
}
