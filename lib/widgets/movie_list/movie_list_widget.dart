import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/resources/resources.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.imageName,
  });
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);
  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      id: 1,
      title: 'Эта фарфоровая кукла влюбилась',
      description:
          'Вакана Годзё — пятнадцатилетний ученик старшей школы, в прошлом получивший серьезную психологическую травму на фоне своего увлечения.',
      time: '9 января 2022',
      imageName: AppImages.farfor,
    ),
    Movie(
      id: 2,
      title: 'Шан-Чи и легенда десяти колец',
      description:
          'Мастеру боевых искусств Шан-Чи предстоит противостоять призракам из собственного прошлого, по мере того как его втягивают в паутину интриг таинственной организации «Десять колец».',
      time: '2 сентября 2021',
      imageName: AppImages.shanchi,
    ),
    Movie(
      id: 3,
      title: 'Веном 2',
      description:
          'Более чем через год после тех событий журналист Эдди Брок пытается приспособиться к жизни в качестве хозяина инопланетного симбиота Венома, который наделяет его сверхчеловеческими способностями. Брок ',
      time: '30 сентября 2021',
      imageName: AppImages.venom2,
    ),
  ];

  var _filteredMovies = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  void _onMovieTap(int index) {
    final id = _filteredMovies[index].id;
    Navigator.of(context)
        .pushNamed('/main_screen/movie_details', arguments: id);
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filteredMovies.length,
          itemExtent: 163,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final movie = _filteredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: blackColor.withOpacity(.2)),
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: blackColor.withOpacity(.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image(image: AssetImage(movie.imageName)),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              AppText(
                                  size: 18,
                                  text: movie.title,
                                  isBold: FontWeight.bold,
                                  maxLines: 1,
                                  overflow: true),
                              const SizedBox(height: 5),
                              AppText(
                                  size: 16,
                                  text: movie.time,
                                  color: Colors.grey,
                                  maxLines: 1,
                                  overflow: true),
                              const SizedBox(height: 20),
                              Text(
                                movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _onMovieTap(index),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: whiteColor.withAlpha(235),
              label: const Text('Поиск'),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
