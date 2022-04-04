import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/resources/resources.dart';
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
              children: [
                const _TrailersWidget(),
                const SizedBox(height: 20),
                const _NowPlayingWidget(),
                // _TabsWidget(),
                const _PopularsWidget(),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
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
      items: model.popularMovies.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    ImageDownloader.imageUrl(
                      i.backdropPath!,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                  colors: [background, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Text(
                i.title! + '//\n///В РАЗРАБОТКЕ',
                style: const TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    backgroundColor: Colors.black),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

// class _TabsWidget extends StatefulWidget {
//   _TabsWidget({Key? key}) : super(key: key);
//   @override
//   State<_TabsWidget> createState() => __TabsWidgetState();
// }

// class __TabsWidgetState extends State<_TabsWidget>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     TabController _tabController = TabController(length: 2, vsync: this);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: AppText(
//             size: 22,
//             text: 'Категории',
//             isBold: FontWeight.bold,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: TabBar(
//             labelColor: primaryText,
//             labelStyle:
//                 const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//             unselectedLabelColor: secondaryText,
//             indicatorSize: TabBarIndicatorSize.tab,
//             indicator: BoxDecoration(
//               gradient: const LinearGradient(colors: [
//                 Color(0xff945df9),
//                 Color(0xffc75eef),
//               ]),
//               borderRadius: BorderRadius.circular(50),
//             ),
//             controller: _tabController,
//             tabs: const [
//               Tab(text: 'Смотрят сейчас'),
//               Tab(text: 'Популярные'),
//             ],
//             isScrollable: true,
//           ),
//         ),
//         SizedBox(
//           height: 300,
//           child: TabBarView(
//             controller: _tabController,
//             children: const [
//               _LatestWidget(),
//               _LatestWidget(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

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
          child: AppText(
            size: 22,
            text: 'Сейчас смотрят',
            isBold: FontWeight.bold,
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
          child: AppText(
            size: 22,
            text: 'Популярные',
            isBold: FontWeight.bold,
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
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
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
                  child: Text('${movie.voteAvarage! * 10}',
                      style: const TextStyle(color: whiteColor)),
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
