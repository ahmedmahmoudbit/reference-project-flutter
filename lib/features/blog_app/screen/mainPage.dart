import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/blog_app/screen/article.dart';
import 'package:reference_project_flutter/features/blog_app/screen/home.dart';
import 'package:reference_project_flutter/features/blog_app/screen/new_article.dart';
import 'package:reference_project_flutter/features/blog_app/screen/profile.dart';
import 'package:reference_project_flutter/features/blog_app/screen/search.dart';

class MainPageBlog extends StatefulWidget {
  const MainPageBlog({Key? key}) : super(key: key);

  @override
  State<MainPageBlog> createState() => _MainPageBlogState();
}

class _MainPageBlogState extends State<MainPageBlog> {
  int selectedIndexPage = homePageIndex;
  bool lastPageIsSelected = false;
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _articleKey = GlobalKey();
  final GlobalKey<NavigatorState> _menuKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _newArticleKey = GlobalKey();

  final List<int> _history = [];

  late final keyMap = {
    homePageIndex: _homeKey,
    articlePageIndex: _articleKey,
    searchPageIndex: _searchKey,
    menuPageIndex: _menuKey,
    newArticlePageIndex: _newArticleKey
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectNavigatorState =
    keyMap[selectedIndexPage]!.currentState!;
    if (currentSelectNavigatorState.canPop()) {
      currentSelectNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedIndexPage = _history.last;
        _history.removeLast();
      });
      return false;
    } else if (_history.isEmpty &&
        !lastPageIsSelected &&
        selectedIndexPage != homePageIndex) {
      setState(() {
        selectedIndexPage = homePageIndex;
        lastPageIsSelected = true;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: 65,
              child: IndexedStack(
                index: selectedIndexPage,
                children: [
                  _navigatorItem(_homeKey, homePageIndex, const HomePage()),
                  _navigatorItem(
                      _articleKey, articlePageIndex, const ArticlePage()),
                  _navigatorItem(
                      _searchKey, searchPageIndex, const SearchPage()),
                  _navigatorItem(_menuKey, menuPageIndex, const ProfilePage()),
                  _navigatorItem(_newArticleKey, newArticlePageIndex,
                      const NewArticlePage())
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BottomNavigationView(
                onTab: (int index) {
                  if (index != selectedIndexPage) {
                    setState(
                          () {
                        _history.remove(selectedIndexPage);
                        _history.remove(index);
                        _history.add(selectedIndexPage);
                        selectedIndexPage = index;
                      },
                    );
                  }
                },
                selectIndexPage: selectedIndexPage,
                onBackTab: () {
                  setState(
                        () {
                      _history.remove(selectedIndexPage);
                      selectedIndexPage = _history.last;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigatorItem(GlobalKey key, int index, Widget child) {
    return key.currentState == null && index != selectedIndexPage
        ? Container()
        : Navigator(
      key: key,
      onGenerateRoute: (setting) => MaterialPageRoute(
          builder: (context) => Offstage(
              offstage: selectedIndexPage != index, child: child)),
    );
  }
}

const homePageIndex = 0;
const articlePageIndex = 1;
const searchPageIndex = 2;
const menuPageIndex = 3;
const newArticlePageIndex = 4;

class _BottomNavigationView extends StatelessWidget {
  const _BottomNavigationView({
    Key? key,
    required this.onTab,
    required this.onBackTab,
    required this.selectIndexPage,
  }) : super(key: key);
  final Function(int index) onTab;
  final Function() onBackTab;
  final int selectIndexPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 85,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      color: const Color(0xff9b8487).withOpacity(0.3)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _BottomNavigationViewItem(
                        title: 'Home',
                        iconFileName: Icons.home_outlined,
                        isActive: selectIndexPage == homePageIndex,
                        onTap: () {
                          onTab(homePageIndex);
                        },
                        actionIconFileName: Icons.home),
                    _BottomNavigationViewItem(
                        title: 'Article',
                        iconFileName: Icons.article,
                        isActive: selectIndexPage == articlePageIndex,
                        onTap: () {
                          onTab(articlePageIndex);
                        },
                        actionIconFileName: Icons.article_rounded),
                    const Expanded(child: SizedBox()),
                    _BottomNavigationViewItem(
                        title: 'Search',
                        iconFileName: Icons.search,
                        onTap: () {
                          onTab(searchPageIndex);
                        },
                        isActive: selectIndexPage == searchPageIndex,
                        actionIconFileName: Icons.search_rounded),
                    _BottomNavigationViewItem(
                        title: 'Menu',
                        onTap: () {
                          onTab(menuPageIndex);
                        },
                        isActive: selectIndexPage == menuPageIndex,
                        iconFileName: Icons.menu,
                        actionIconFileName: Icons.menu_book)
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.topCenter,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.5),
              ),
              child: InkWell(
                onTap: () {
                  selectIndexPage != newArticlePageIndex
                      ? onTab(newArticlePageIndex)
                      : onBackTab();
                },
                child: Container(
                    margin: const EdgeInsets.all(4),
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                      color: selectIndexPage != newArticlePageIndex
                          ? const Color(0xff376AED)
                          : const Color(0xff0D253C),
                      borderRadius: BorderRadius.circular(32.5),
                    ),
                    child: Transform.rotate(
                      angle: selectIndexPage != newArticlePageIndex ? 0 : 0.75,
                      child: Icon(
                        CupertinoIcons.add,
                        size: 28,
                        color: selectIndexPage != newArticlePageIndex
                            ? const Color(0xFF8FE6FF)
                            : Colors.white,
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomNavigationViewItem extends StatelessWidget {
  const _BottomNavigationViewItem(
      {Key? key,
        required this.title,
        required this.iconFileName,
        required this.actionIconFileName,
        required this.isActive,
        required this.onTap})
      : super(key: key);
  final String title;
  final IconData iconFileName;
  final IconData actionIconFileName;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/img/icons/${isActive ? actionIconFileName : iconFileName}',
            //   height: 24,
            //   width: 24,
            // ),
            Icon(
              isActive ? actionIconFileName : iconFileName,
              size: 24,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: themeData.textTheme.caption!.apply(
                  color: isActive
                      ? themeData.colorScheme.primary
                      : themeData.textTheme.caption!.color),
            )
          ],
        ),
      ),
    );
  }
}