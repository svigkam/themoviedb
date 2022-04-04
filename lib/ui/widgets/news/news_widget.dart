import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/resources/resources.dart';

import 'news_free_to_watch_widget.dart';
import 'news_popular_widget.dart';
import 'news_trailers_widget.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background,
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.trailerBg),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: const NewsTrailersWidget(),
            ),
            const NewsPopularWidget(),
            const NewsFreeToWatchWidget(),
          ],
        ),
      ),
    );
  }
}
