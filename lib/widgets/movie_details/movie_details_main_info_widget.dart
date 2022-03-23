import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/resources/resources.dart';

import '../elements/circle_progress_bar.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TopPostersWidget(),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: _MovieNameWidget(),
          ),
        ),
        const _ScoreWidget(),
        const _SummeryWidget(),
        // overview
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: AppText(text: 'Обзор', size: 18, color: whiteColor),
        ),
        // overview text
        ColoredBox(
          color: const Color.fromRGBO(22, 21, 25, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: AppText(
                color: whiteColor,
                size: 16,
                text:
                    'Более чем через год после тех событий журналист Эдди Брок пытается приспособиться к жизни в качестве хозяина инопланетного симбиота Венома, который наделяет его сверхчеловеческими способностями. Брок пытается возродить свою карьеру и берет интервью у серийного убийцы Клетуса Касади, который по воле случая становится хозяином Карнажа и сбегает из тюрьмы после неудавшейся казни.'),
          ),
        ),
        const SizedBox(height: 25),
        const _PeopleWidget(),
        const SizedBox(height: 25),
      ],
    );
  }
}

class _TopPostersWidget extends StatelessWidget {
  const _TopPostersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Image(image: AssetImage(AppImages.topHeader)),
        Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: Image(image: AssetImage(AppImages.topHeaderSubImage))),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Веном 2',
            style: TextStyle(
              color: whiteColor,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: ' (2021)',
            style: TextStyle(
              color: whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: RadialPercentWidget(
                      child: const Text('72'),
                      percent: 0.72,
                      fillColor: const Color.fromARGB(255, 10, 23, 25),
                      lineColor: const Color.fromARGB(255, 37, 203, 103),
                      freeColor: const Color.fromARGB(255, 25, 54, 31),
                      lineWidth: 3),
                ),
                const SizedBox(width: 10),
                const Text('User Score'),
              ],
            )),
        Container(
          color: Colors.grey,
          width: 1,
          height: 15,
        ),
        TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Icon(Icons.play_arrow),
                Text('Play Trailer'),
              ],
            )),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: AppText(
            alignCenter: true,
            maxLines: 3,
            text: '16+ 30/09/2021 (RU) 1h 36m фантастика, боевик, приключения',
            size: 14,
            color: whiteColor),
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: 'Stefano Sollima', size: 16, color: whiteColor),
                AppText(text: 'Director', size: 16, color: whiteColor),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: 'Stefano Sollima', size: 16, color: whiteColor),
                AppText(text: 'Director', size: 16, color: whiteColor),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: 'Stefano Sollima', size: 16, color: whiteColor),
                AppText(text: 'Director', size: 16, color: whiteColor),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: 'Stefano Sollima', size: 16, color: whiteColor),
                AppText(text: 'Director', size: 16, color: whiteColor),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
