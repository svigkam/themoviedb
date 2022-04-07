import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);
  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final _screenFactory = ScreenFactory();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.makeNewsList(),
          _screenFactory.makeMovieList(),
          _screenFactory.makeFavorite(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        elevation: 0,
        backgroundColor: lightPrimary,
        selectedItemColor: bottomNavUnselect,
        unselectedItemColor: bottomNavUnselect,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: _selectedTab == 0
                ? Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondary,
                    ),
                    child: const Icon(Icons.newspaper_outlined, size: 30),
                  )
                : const Icon(Icons.newspaper_outlined, size: 30),
            label: 'Лента',
          ),
          BottomNavigationBarItem(
            icon: _selectedTab == 1
                ? Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondary,
                    ),
                    child: const Icon(Icons.search, size: 30),
                  )
                : const Icon(Icons.search, size: 30),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: _selectedTab == 2
                ? Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondary,
                    ),
                    child: const Icon(Icons.favorite, size: 30),
                  )
                : const Icon(Icons.favorite, size: 30),
            label: 'Закладки',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
