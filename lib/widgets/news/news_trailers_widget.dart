import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../resources/resources.dart';

class NewsTrailersWidget extends StatelessWidget {
  const NewsTrailersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(3, 37, 65, .75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: AppText(
                size: 22,
                text: 'Последние трейлеры',
                isBold: FontWeight.bold,
                color: whiteColor),
          ),
          SizedBox(
            height: 280,
            child: Scrollbar(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 2,
                itemExtent: 300,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          clipBehavior: Clip.hardEdge,
                          child: const Image(
                            image: AssetImage(AppImages.trailer),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              AppText(
                                  size: 18,
                                  text: 'Позолоченный век',
                                  alignCenter: true,
                                  color: whiteColor,
                                  isBold: FontWeight.bold),
                              const SizedBox(height: 5),
                              AppText(
                                  size: 15,
                                  color: whiteColor,
                                  text:
                                      'Позолоченный век | Трейлер | Амедиатека (2022)',
                                  alignCenter: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
