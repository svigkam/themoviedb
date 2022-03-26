import 'package:flutter/material.dart';
import 'package:themoviedb/Libarary/Widgets/Inherited/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  const MovieDetailsMainScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppText(
                size: 18, text: 'В главных ролях', isBold: FontWeight.w700),
          ),
          const SizedBox(
            height: 340,
            child: Scrollbar(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: _CastListWidget(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextButton(
              onPressed: () {},
              child: AppText(
                  size: 17, text: 'Полный актёрский и съёмочный состав'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CastListWidget extends StatelessWidget {
  const _CastListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var length = model!.movieDetailsCast!.cast.length;

    var cast = model.movieDetailsCast?.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      itemCount: length,
      itemExtent: 140,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _CastListItemWidget(castIndex: index);
      },
    );
  }
}

class _CastListItemWidget extends StatelessWidget {
  final int castIndex;
  const _CastListItemWidget({
    required this.castIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    var actor = model!.movieDetailsCast!.cast[castIndex];
    final profilePath = actor.profilePath;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 500 / 750,
                child: profilePath != null
                    ? Image.network(ApiClient.imageUrl(profilePath))
                    : Icon(
                        Icons.image_not_supported_outlined,
                        size: 70,
                        color: Colors.grey[400],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        size: 16, text: actor.name, isBold: FontWeight.bold),
                    const SizedBox(height: 7),
                    AppText(size: 15, text: actor.character, color: greyColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
