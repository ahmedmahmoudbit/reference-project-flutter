class StoryData {
  final int id;
  final String name;
  final String imageFileName;
  final String iconFileName;
  final int size;
  final List<StoryItem> storyItems;
  final bool isViewed;

  StoryData(
      {required this.id,
        required this.size,
        required this.name,
        required this.storyItems,
        required this.imageFileName,
        required this.iconFileName,
        required this.isViewed});
}

class StoryItem {
  final String time;
  final String imageFile;
  final String like;

  StoryItem({required this.time, required this.imageFile, required this.like});
}

class Category {
  final int id;
  final String title;
  final String imageFileName;

  Category(
      {required this.id, required this.title, required this.imageFileName});
}

class PostData {
  final int id;
  final String caption;
  final String title;
  final String likes;
  final String time;
  final bool isBookmarked;
  final String imageFileName;

  PostData(
      {required this.id,
        required this.caption,
        required this.title,
        required this.likes,
        required this.time,
        required this.isBookmarked,
        required this.imageFileName});
}

class OnBoardingData {
  String title;
  String desc;

  OnBoardingData(this.title, this.desc);
}

class AppData {
  static List<StoryData> get stories {
    return [
      StoryData(
          size: 2,
          id: 1001,
          name: 'Emilia',
          storyItems: [
            StoryItem(time: '4m ago', imageFile: 'assets/img/background/story.png.jpg', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'assets/img/background/story.png.jpg', like: '450k')
          ],
          imageFileName: 'assets/img/background/story.png.jpg',
          iconFileName: 'category_2.png',
          isViewed: false),
      StoryData(
          size: 3,
          storyItems: [
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k')
          ],
          id: 1002,
          name: 'Richard',
          imageFileName: 'assets/img/background/onboarding.png',
          iconFileName: 'category_2.png',
          isViewed: false),
      StoryData(
          size: 5,
          storyItems: [
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
          ],
          id: 1003,
          name: 'Jasmine',
          imageFileName: 'assets/img/background/single_post.png',
          iconFileName: 'category_3.png',
          isViewed: true),
      StoryData(
          size: 1,
          id: 1004,
          storyItems: [
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
          ],
          name: 'Lucas',
          imageFileName: 'assets/img/background/story.png.jpg',
          iconFileName: 'category_4.png',
          isViewed: false),
      StoryData(
          size: 10,
          storyItems: [
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k')
          ],
          id: 1005,
          name: 'Isabella',
          imageFileName: 'assets/img/background/story-content.png',
          iconFileName: 'category_2.png',
          isViewed: false),
      StoryData(
          size: 3,
          storyItems: [
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k')
          ],
          id: 1006,
          name: 'Olivia',
          imageFileName: 'assets/img/background/story-content.png',
          iconFileName: 'category_1.png',
          isViewed: false),
      StoryData(
          size: 2,
          storyItems: [
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
          ],
          id: 1007,
          name: 'Amelia',
          imageFileName: 'assets/img/background/story-content.png',
          iconFileName: 'category_4.png',
          isViewed: false),
      StoryData(
          size: 7,
          storyItems: [
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
            StoryItem(time: '4m ago', imageFile: 'story.png', like: '450k'),
          ],
          id: 1008,
          name: 'Grace',
          imageFileName: 'assets/img/background/story-content.png',
          iconFileName: 'category_3.png',
          isViewed: false),
    ];
  }

  static List<Category> get categories {
    return [
      Category(
        id: 101,
        title: 'Technology',
        imageFileName: 'assets/img/background/story.png.jpg',
      ),
      Category(id: 102, title: 'Cinema', imageFileName: 'assets/img/background/story.png.jpg'),
      Category(
          id: 103, title: 'Transportation', imageFileName: 'assets/img/background/story.png.jpg'),
      Category(id: 104, title: 'Adventure', imageFileName: 'assets/img/background/story.png.jpg'),
      Category(
          id: 105,
          title: 'Artificial Intelligence',
          imageFileName: 'assets/img/background/story.png.jpg'),
      Category(id: 106, title: 'Economy', imageFileName: 'assets/img/background/story.png.jpg'),
    ];
  }

  static List<PostData> get posts {
    return [
      PostData(
          id: 1,
          title: 'BMW M5 Competition Review 2021',
          caption: 'TOP GEAR',
          isBookmarked: false,
          likes: '3.1k',
          time: '1hr ago',
          imageFileName: 'assets/img/background/onboarding.png'),
      PostData(
          id: 0,
          title: 'MacBook Pro with M1 Pro and M1 Max review',
          caption: 'THE VERGE',
          isBookmarked: false,
          likes: '1.2k',
          time: '2hr ago',
          imageFileName: 'assets/img/background/onboarding.png'),
      PostData(
          id: 2,
          title: 'Step design sprint for UX beginner',
          caption: 'Ux Design',
          isBookmarked: true,
          likes: '2k',
          time: '41hr ago',
          imageFileName: 'assets/img/background/onboarding.png'),
    ];
  }

  static List<OnBoardingData> get onBoardings {
    return [
      OnBoardingData('Read the article you want instantly',
          'You can read thousands of articles on Blog Club, save them in the application and share them with your loved ones.'),
      OnBoardingData('Read the article you want instantly',
          'You can read thousands of articles on Blog Club, save them in the application and share them with your loved ones.'),
      OnBoardingData('Read the article you want instantly',
          'You can read thousands of articles on Blog Club, save them in the application and share them with your loved ones.'),
      OnBoardingData('Read the article you want instantly',
          'You can read thousands of articles on Blog Club, save them in the application and share them with your loved ones.'),
    ];
  }
}