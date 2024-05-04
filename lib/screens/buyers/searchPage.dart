import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.user});
  final KFUser user;

  @override
  State<SearchPage> createState() => _SearchPageState(user);
}

class _SearchPageState extends State<SearchPage> {
  _SearchPageState(this.user);
  final KFUser user;

  final int _selectedIndex = 1;

  bool _showSearchResults = false;
  final _searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void switchToSearchResult() {
      _showSearchResults = true;
      print('Callback Called - Current state: $_showSearchResults');
      setState(() {});
    }

    void switchToSearchBar() {
      _showSearchResults = true;
      print('Callback Called - Current state: $_showSearchResults');
      setState(() {});
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: KickFlipAppBar(),

      //
      body: (_showSearchResults)
          ? // Search Results
          Column(
              children: [
                const SizedBox(height: 5),
                SearchBar(
                  callback: switchToSearchResult,
                  controller: _searchBarController,
                ),
                SearchPageResult(
                  callback: switchToSearchResult,
                  controller: _searchBarController,
                ),
              ],
            )
          : // Search Bar
          Column(
              children: [
                const SizedBox(height: 5),
                SearchBar(
                  callback: switchToSearchResult,
                  controller: _searchBarController,
                ),
              ],
            ),

      //
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedIndex: _selectedIndex, user: user),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar(
      {super.key, required this.callback, required this.controller});

  final VoidCallback callback;
  final TextEditingController controller;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              child: TextField(
                controller: widget.controller,
                cursorColor: Colors.grey,
                style: const TextStyle(
                    color: Colors.black, letterSpacing: 2, fontSize: 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  hintText: (widget.controller.text.isEmpty)
                      ? ' Search for your favourite kicks...'
                      : ' ${widget.controller.text}',
                  hintStyle: const TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),

          // Search button
          SizedBox(
            height: 45,
            width: 45,
            child: Center(
              child: IconButton(
                onPressed: () {
                  print(
                      "Search button pressed. Values are: ${widget.controller.text}");
                  widget.callback();
                },
                icon: const Icon(
                  Icons.send_rounded,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchPageResult extends StatefulWidget {
  const SearchPageResult({
    super.key,
    required this.callback,
    required this.controller,
  });

  final VoidCallback callback;
  final TextEditingController controller;

  @override
  State<SearchPageResult> createState() => _SearchPageResultState();
}

class _SearchPageResultState extends State<SearchPageResult> {
  // Basis for sorting the search results
  String sortingFactor = 'Latest';

  // Dummy Data
  List<MySearchResultItem> searchResults = [
    MySearchResultItem(
        pID: 1232,
        imageURL: 'a.jpg',
        sellerName: 'Seller 1',
        title: 'Nike Random Shoes Hehe'),
    MySearchResultItem(
        pID: 3643,
        imageURL: 'a.jpg',
        sellerName: 'Seller 2',
        title: 'Nike Random Shoes Hehe'),
    MySearchResultItem(
        pID: 7878,
        imageURL: 'b.jpg',
        sellerName: 'Seller 3',
        title: 'Nike Random Shoes Hehe'),
    MySearchResultItem(
        pID: 3242,
        imageURL: 'c.jpg',
        sellerName: 'Seller 4',
        title: 'Nike Random Shoes Hehe',
        fav: true),
    MySearchResultItem(
        pID: 2342,
        imageURL: 'd.jpg',
        sellerName: 'Seller 5',
        title: 'Nike Random Shoes Hehe'),
    MySearchResultItem(
        pID: 1232,
        imageURL: 'a.jpg',
        sellerName: 'Seller 1',
        title: 'Nike Random Shoes Hehe',
        fav: true),
    MySearchResultItem(
        pID: 3643,
        imageURL: 'a.jpg',
        sellerName: 'Seller 2',
        title: 'Nike Random Shoes Hehe'),
    MySearchResultItem(
        pID: 7878,
        imageURL: 'b.jpg',
        sellerName: 'Seller 3',
        title: 'Nike Random Shoes Hehe'),
    MySearchResultItem(
        pID: 3242,
        imageURL: 'c.jpg',
        sellerName: 'Seller 4',
        title: 'Nike Random Shoes Hehe'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          kBottomNavigationBarHeight - // bottomNavBar height
          kToolbarHeight - // toolBar height
          38 - // suspense
          100, // accountable -> sized box 5 + search bar 45 + filters 50

      // height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          // Filters section
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Result Count
                MyText(
                  'Found ${searchResults.length} results',
                  size: 14,
                  color: const Color(0xFF4B4949),
                ),

                // Dropdown for sorting factor
                Container(
                  color: Colors.white,
                  child: DropdownButton<String>(
                    items: <String>[
                      'Latest',
                      'Oldest',
                      'A - Z',
                      'Z - A',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: MyText(value, size: 13),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Do something when the dropdown value changes
                      // Todo: Sorting
                      sortingFactor = newValue!;
                      setState(() {});
                    },
                    hint: MyText('Sort by:   $sortingFactor', size: 12),
                    underline: const SizedBox(), // Hide the underline
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                  ),
                ),
              ],
            ),
          ),

          // Search Results
          if (searchResults.isEmpty)
            Center(
              child: MyText(
                'No results found for your search.\nRecheck the search parameters.',
                size: 12,
                color: const Color(0xFF666666),
              ),
            ),

          if (searchResults.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: [
                    for (int i = 0; i < searchResults.length; i++)
                      SearchResultItemWidget(
                        item: searchResults[i],
                        onTappingFavorites: () {
                          searchResults[i].fav = !searchResults[i].fav!;
                          setState(() {});
                          // update favorites factor on Firebase here
                        },
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SearchResultItemWidget extends StatelessWidget {
  const SearchResultItemWidget(
      {super.key, required this.item, required this.onTappingFavorites});
  final MySearchResultItem item;
  final VoidCallback onTappingFavorites;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(height: 315, child: Placeholder()),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: MyText(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  size: 12,
                ),
              ),

              // Favorites Button
              GestureDetector(
                onTap: onTappingFavorites,
                child: Icon(
                  Icons.favorite_rounded,
                  size: 17.5,
                  color: (item.fav!)
                      ? const Color(0xFFFA1D6E)
                      : const Color(0x739E9E9E),
                ),
              )
            ],
          ),
          MyText(item.sellerName, size: 10),
        ],
      ),
    );
  }
}
