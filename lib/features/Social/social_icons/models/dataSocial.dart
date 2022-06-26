class SocialModel {
  final String name;
  final List images;
  final String temp;
  final String pot;
  final String description;
  final String price;
  final String height;

  SocialModel({
    required this.name,
    required this.images,
    required this.temp,
    required this.pot,
    required this.description,
    required this.price,
    required this.height,
  });
}

List<SocialModel> socialData = [
  SocialModel(
    name: 'Facebook',
    images: [
      'assets/images/social/ic_facebook.png',
      'assets/images/social/ic_gmail.png',
      'assets/images/social/ic_google_play.png',
    ],
    temp: '18 C to 25 C',
    pot: 'Self Watering Pot',
    description:
    'Small leaf plant in a turf pot for your home or office decor.',
    price: '\$85 ',
    height: '40cm - 50cm',
  ),
  SocialModel(
    name: 'instgram',
    images: [
      'assets/images/social/ic_instgram.png',
      'assets/images/social/ic_maps.png',
      'assets/images/social/ic_phone.png',
    ],
    temp: '18 C to 25 C',
    pot: 'Self Watering Pot',
    description: 'Low maintenance flower in a white ceramic pot.',
    price: '\$45 ',
    height: '40cm - 50cm',
  ),
  SocialModel(
    name: 'snapchat',
    images: [
      'assets/images/social/ic_snapchat.png',
      'assets/images/social/ic_tiregram.png',
      'assets/images/social/ic_twitter.png',
    ],
    temp: '18 C to 25 C',
    pot: 'Self Watering Pot',
    description:
    'SocialModel in a glass bowl, it can be mounted on a wall or ceiling (holders include).',
    price: '\$85 ',
    height: '40cm - 50cm',
  ),
];
