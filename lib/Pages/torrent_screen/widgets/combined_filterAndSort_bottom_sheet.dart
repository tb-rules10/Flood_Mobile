import 'package:flood_mobile/Pages/torrent_screen/widgets/sort_by_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../Blocs/theme_bloc/theme_bloc.dart';
import 'filter_by_bottom_sheet.dart';

class CombinedBottomSheet extends StatefulWidget {
  final int themeIndex;
  final int defaultPage;

  const CombinedBottomSheet({
    Key? key,
    required this.themeIndex,
    this.defaultPage = 0,
  }) : super(key: key);

  @override
  _CombinedBottomSheetState createState() =>
      _CombinedBottomSheetState(defaultPage);
}

class _CombinedBottomSheetState extends State<CombinedBottomSheet> {
  int _currentPage = 0;
  late PageController _pageController;

  _CombinedBottomSheetState(int defaultPage) {
    _currentPage = defaultPage;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _currentPage == 0
                                ? Colors.white
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Sort',
                          style: TextStyle(
                              fontSize: 18,
                              color: _currentPage == 0
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _currentPage == 1
                                ? Colors.white
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Filter',
                          style: TextStyle(
                              fontSize: 18,
                              color: _currentPage == 1
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                SortByBottomSheet(themeIndex: widget.themeIndex),
                FilterByStatus(themeIndex: widget.themeIndex),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
