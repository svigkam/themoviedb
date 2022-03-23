import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'movie_details_main_info_widget.dart';
import 'movie_details_main_screen_cast_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;
  const MovieDetailsWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Image(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person, color: whiteColor),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: secondaryColor),
          ),
        ],
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1),
        child: ListView(children: const [
          MovieDetailsMainInfoWidget(),
          MovieDetailsMainScreenCastWidget(),
        ]),
      ),
    );
  }
}
