import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/widgets/elements/circle_progress_bar.dart';
import 'package:themoviedb/ui/widgets/news/news_model.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);
  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<NewsModel>().setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewsModel>();
    return model.playingMovies.isNotEmpty
        ? SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: const [
                _TopBarWidget(),
                _TabsWidget(),
                _NowPlayingWidget(),
                _PopularsWidget(),
              ],
            ),
          )
        : const Center(child: SpinKitSpinningLines(color: secondary));
  }
}

class _TopBarWidget extends StatelessWidget {
  const _TopBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: white),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.filter_alt_outlined, color: secondaryText),
              ),
              IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.notifications_none, color: secondaryText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrailersWidget extends StatelessWidget {
  const _TrailersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewsModel>();

    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 7),
        autoPlayAnimationDuration: const Duration(milliseconds: 400),
        autoPlayCurve: Curves.easeIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
      items: model.upcomingMovies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(movie.backdropPath != null
                            ? ImageDownloader.imageUrl(movie.backdropPath!)
                            : 'https://assets.atlanticbt.com/content/uploads/2016/02/404_atlanticbt_blog-1140x510.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primary,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]),
                          child: AppText(
                            size: 16,
                            text: movie.releaseDate!,
                            color: primaryText.withAlpha(220),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]),
                          child: AppText(
                              size: 24,
                              text: movie.title!,
                              isBold: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]),
                          child: AppText(
                            overflow: true,
                            size: 16,
                            maxLines: 3,
                            text: movie.overview!,
                            color: primaryText.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}

class _TabsWidget extends StatefulWidget {
  const _TabsWidget({Key? key}) : super(key: key);
  @override
  State<_TabsWidget> createState() => __TabsWidgetState();
}

class __TabsWidgetState extends State<_TabsWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);
    final model = context.read<NewsModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppText(
            size: 20,
            text: 'Самые популярные',
            isBold: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 235,
          child: TabBarView(
            controller: _tabController,
            children:  [
              _TopRatedWidget(movies: model.topRatedMovies),
              _TopRatedWidget(movies: model.playingMovies),
              _TopRatedWidget(movies: model.popularMovies),
              _TopRatedWidget(movies: model.upcomingMovies),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TabBar(
            labelColor: primaryText,
            labelStyle:
                const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            unselectedLabelColor: secondaryText,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            indicator: BoxDecoration(
              gradient: const LinearGradient(colors: [
                secondary,
                Color.fromARGB(255, 79, 130, 181),
              ]),
              borderRadius: BorderRadius.circular(50),
            ),
            controller: _tabController,
            tabs: const [
              Tab(text: 'Боевики'),
              Tab(text: 'Хорроры'),
              Tab(text: 'Семейные'),
              Tab(text: 'Комедии'),
            ],
            isScrollable: true,
          ),
        ),
      ],
    );
  }
}

class _TopRatedWidget extends StatelessWidget {
  final List<MovieListRowData> movies;
  const _TopRatedWidget({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewsModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 235,
          child: Scrollbar(
            child: ListView.builder(
              itemCount:movies.length,
              physics: const BouncingScrollPhysics(),
              itemExtent: 150,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () => model.onMovieTap(context, movie.id!),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: AspectRatio(
                            aspectRatio: 87 / 130,
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                ImageDownloader.imageUrl(
                                  movie.posterPath!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _NowPlayingWidget extends StatelessWidget {
  const _NowPlayingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewsModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                size: 20,
                text: 'Сейчас смотрят',
                isBold: FontWeight.bold,
              ),
              IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.arrow_forward_ios, color: white, size: 16),
              )
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: Scrollbar(
            child: ListView.builder(
              itemCount: model.playingMovies.length,
              physics: const BouncingScrollPhysics(),
              itemExtent: 150,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final playingMovie = model.playingMovies[index];

                return GestureDetector(
                    onTap: () => model.onMovieTap(context, playingMovie.id!),
                    child: _MovieTileWidget(movie: playingMovie));
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _PopularsWidget extends StatelessWidget {
  const _PopularsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewsModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                size: 20,
                text: 'Популярные',
                isBold: FontWeight.bold,
              ),
              IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.arrow_forward_ios, color: white, size: 16),
              )
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: Scrollbar(
            child: ListView.builder(
              itemCount: model.popularMovies.length,
              physics: const BouncingScrollPhysics(),
              itemExtent: 150,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final popularMovie = model.popularMovies[index];
                return GestureDetector(
                    onTap: () => model.onMovieTap(context, popularMovie.id!),
                    child: _MovieTileWidget(movie: popularMovie));
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _MovieTileWidget extends StatelessWidget {
  final MovieListRowData movie;
  const _MovieTileWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(10),
                // clipBehavior: Clip.hardEdge,
                child: AspectRatio(
                  aspectRatio: 87 / 130,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      ImageDownloader.imageUrl(
                        movie.posterPath!,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    AppText(
                        maxLines: 2,
                        size: 16,
                        text: movie.title!,
                        isBold: FontWeight.bold),
                    const SizedBox(height: 5),
                    AppText(
                        size: 14,
                        overflow: true,
                        text: movie.releaseDate!,
                        color: secondaryText),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 88,
            left: 10,
            child: SizedBox(
              width: 40,
              height: 40,
              child: RadialPercentWidget(
                  child: Text('${(movie.voteAvarage! * 10).round()}',
                      style:
                          const TextStyle(color: white, fontFamily: 'Georgia')),
                  percent: movie.voteAvarage! / 10,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3),
            ),
          )
        ],
      ),
    );
  }
}
