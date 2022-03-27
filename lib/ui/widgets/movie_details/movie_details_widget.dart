import 'package:flutter/material.dart';
import 'package:themoviedb/Libarary/Widgets/Inherited/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/ui/widgets/app/my_app_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

import 'movie_details_main_info_widget.dart';
import 'movie_details_main_screen_cast_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({Key? key}) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final appModel = Provider.read<MyAppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

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
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1),
        child: _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(children: const [
      MovieDetailsMainInfoWidget(),
      MovieDetailsMainScreenCastWidget(),
    ]);
  }
}
