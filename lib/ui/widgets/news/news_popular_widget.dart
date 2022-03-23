import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/resources/resources.dart';


import '../elements/circle_progress_bar.dart';

class NewsPopularWidget extends StatelessWidget {
  const NewsPopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppText(
            size: 22,
            text: 'Что популярно',
            isBold: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 300,
          child: Scrollbar(
            child: ListView.builder(
              itemCount: 20,
              physics: const BouncingScrollPhysics(),
              itemExtent: 150,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
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
                            child: const Image(
                              image: AssetImage(AppImages.venom2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                AppText(
                                    size: 16,
                                    text: 'Веном 2',
                                    isBold: FontWeight.bold),
                                const SizedBox(height: 5),
                                AppText(size: 15, text: '11 мар 2022', color: greyColor),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 68,
                        left: 10,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: RadialPercentWidget(
                              child: const Text('72',
                                  style: TextStyle(color: whiteColor)),
                              percent: 0.72,
                              fillColor: const Color.fromARGB(255, 10, 23, 25),
                              lineColor:
                                  const Color.fromARGB(255, 37, 203, 103),
                              freeColor: const Color.fromARGB(255, 25, 54, 31),
                              lineWidth: 3),
                        ),
                      )
                    ],
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
