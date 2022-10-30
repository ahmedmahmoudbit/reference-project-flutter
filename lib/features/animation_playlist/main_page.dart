import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/animation_playlist/widgets/featured_library_items.dart';
import 'package:reference_project_flutter/features/animation_playlist/widgets/image_wrapper.dart';
import 'animation/animation_manager.dart';

class LibraryData {
  static const List<String> playlistImages = [
    'assets/img/background/image-1.png',
    'assets/img/background/image-5.png',
    'assets/img/background/image-2.png',
    'assets/img/background/image-3.jpg',
    'assets/img/background/image-4.jpg',
    'assets/img/background/image-5.png',
  ];
}

class LibraryPage extends StatefulWidget {
const LibraryPage({super.key});

@override
State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<Offset> offsetAnimation;


  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      for (String image in LibraryData.playlistImages) {
        precacheImage(Image.asset(image).image, context);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: AnimationManager.pageElementsAnimationDuration,
    );
    offsetAnimation = Tween(
      begin: const Offset(0, 0),
      end: const Offset(0, 1),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: FeaturedLibraryItems(
              animationController: animationController,
            ),
          ),
          Expanded(
            child: SlideTransition(
              position: offsetAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'Recently Played',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: MediaQuery.of(context).padding.bottom + 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: LibraryData.playlistImages.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ImageWrapper(
                          image: LibraryData.playlistImages[index],
                          size: 100,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}