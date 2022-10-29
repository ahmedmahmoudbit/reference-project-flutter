import 'package:flutter/material.dart';
import '../../../constants/text_style.dart';
import '../../../models/model_movies.dart';

class MovieInfoTable extends StatelessWidget {
  const MovieInfoTable({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MovieInfoTableItem(title: 'Type', content: movie.type),
        MovieInfoTableItem(title: 'Hour', content: '${movie.hours} hour'),
        MovieInfoTableItem(title: 'Director', content: movie.director),
      ],
    );
  }
}

class MovieInfoTableItem extends StatelessWidget {
  const MovieInfoTableItem({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(title, style: AppTextStyles.infoTitleStyle),
        ),
        Text(content, style: AppTextStyles.infoContentStyle),
      ],
    );
  }
}