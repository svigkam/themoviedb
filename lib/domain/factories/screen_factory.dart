import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/favorites/favorite_model.dart';
import 'package:themoviedb/ui/widgets/favorites/favorite_widget.dart';
import 'package:themoviedb/ui/widgets/loader/loader_model.dart';
import 'package:themoviedb/ui/widgets/loader/loader_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:themoviedb/ui/widgets/news/news_model.dart';
import 'package:themoviedb/ui/widgets/news/news_widget.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderModel(context),
      child: const LoaderWidget(),
      lazy: false,
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsModel(movieId: movieId),
      child: const MovieDetailsWidget(),
    );
  }

  Widget makeNewsList() {
    return ChangeNotifierProvider(
      create: (_) => NewsModel(),
      child: const NewsWidget(),
    );
  }

  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListModel(),
      child: const MovieListWidget(),
    );
  }

  Widget makeFavorite() {
    return ChangeNotifierProvider(
      create: (_) => FavoriteModel(),
      child: const FavoriteWidget(),
    );
  }
}
