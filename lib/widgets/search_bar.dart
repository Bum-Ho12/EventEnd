import 'package:eventend/providers/search_provider.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showSearchBar = false;
  TextEditingController _searchText = TextEditingController();
  @override
  void initState() {
    final SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: false);
    super.initState();
    _searchText = TextEditingController(text: searchProvider.searched);
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedPadding(
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: showSearchBar ? 360 : 50,
          decoration: BoxDecoration(
            color: showSearchBar
                ? ThemeApplication.lightTheme.backgroundColor.withOpacity(0.25)
                : ThemeApplication.lightTheme.backgroundColor2.withOpacity(1),
            boxShadow: [
              if (showSearchBar)
                BoxShadow(
                  color: ThemeApplication.lightTheme.backgroundColor,
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
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          controller: _searchText,
          onChanged: searchProvider.setSearched,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search..',
          ),
        ),
      ),
    );
  }

  Widget searchIcon() {
    return IconButton(
      padding: const EdgeInsets.all(8),
      iconSize: 30,
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
        color: ThemeApplication.lightTheme.backgroundColor,
      ),
    );
  }

  Widget clearButton() {
    return IconButton(
      padding: const EdgeInsets.all(3),
      iconSize: 30,
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
          color: ThemeApplication.lightTheme.backgroundColor2,
          borderRadius: BorderRadius.circular(360),
        ),
        child: Icon(
          Icons.close,
          color: ThemeApplication.lightTheme.backgroundColor,
        ),
      ),
    );
  }
}
