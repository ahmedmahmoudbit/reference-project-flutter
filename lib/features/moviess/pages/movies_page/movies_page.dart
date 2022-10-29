import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/moviess/pages/movies_page/widgets/dot_indicator.dart';
import 'package:reference_project_flutter/features/moviess/pages/movies_page/widgets/slider.dart';


class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicator: const DotIndicator(),
          labelColor: Colors.black,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Colors.grey,
          overlayColor: MaterialStateProperty.all(Colors.transparent),

          tabs: const [
            Tab(text: 'Movie'),
            Tab(text: 'Series'),
            Tab(text: 'TV Show'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          MoviesView(),
          SizedBox.expand(),
          SizedBox.expand(),
        ],
      ),
    );
  }


}
