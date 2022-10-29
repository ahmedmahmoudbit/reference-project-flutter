import 'package:flutter/material.dart';
import '../../../models/model_movies.dart';
import '../../booking/booking_page.dart';
import '../../movies_page/widgets/dot_indicator.dart';

class BookButton extends StatelessWidget {
  const BookButton({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        const transitionDuration = Duration(milliseconds: 200);

        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: transitionDuration,
            reverseTransitionDuration: transitionDuration,
            pageBuilder: (_, animation, ___) {
              return FadeTransition(
                opacity: animation,
                child: BookingPage(movie: movie),
                // child: GeeCoders(),
              );
            },
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}