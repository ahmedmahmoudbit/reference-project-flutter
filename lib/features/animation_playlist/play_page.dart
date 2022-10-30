import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/animation_playlist/widgets/image_wrapper.dart';
import 'package:reference_project_flutter/features/animation_playlist/widgets/song_action_buttons.dart';
import 'package:reference_project_flutter/features/animation_playlist/widgets/song_list_item.dart';

import 'animation/animation_manager.dart';
import 'main_page.dart';


class PlayPage extends StatefulWidget {
  const PlayPage({
    super.key,
    required this.routeAnimation,
    required this.image,
    required this.heroTag,
  });

  final Animation<double> routeAnimation;
  final String image;
  final String heroTag;

  @override
  State<PlayPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlayPage> {
  late final Animation<double> appBarOffsetAnimation;
  late final Animation<Offset> contentOffsetAnimation;

  @override
  void initState() {
    appBarOffsetAnimation = Tween(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: widget.routeAnimation,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );
    contentOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: widget.routeAnimation,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedBuilder(
            animation: appBarOffsetAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, appBarOffsetAnimation.value),
                child: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
              );
            },
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 240,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  flexibleSpace: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Hero(
                        tag: widget.heroTag,
                        child: Transform(
                          transform: AnimationManager.endTransformMatrix,
                          alignment: Alignment.center,
                          child: ImageWrapper(image: widget.image),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: SlideTransition(
                      position: contentOffsetAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Acoustic',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SongActionButtons(),
                          const SizedBox(height: 20),
                          const Text(
                            'Upcoming songs',
                            style: TextStyle(fontSize: 22),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom:
                              MediaQuery.of(context).padding.bottom + 20,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: LibraryData.playlistImages.length,
                            itemBuilder: (context, index) => SongListItem(
                              image: LibraryData.playlistImages[index],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}