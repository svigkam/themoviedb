import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/resources/resources.dart';

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
          SizedBox(
            height: 260,
            child: Scrollbar(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  itemCount: 20,
                  itemExtent: 140,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
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
                              const Image(image: AssetImage(AppImages.actor)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                        size: 16,
                                        text: 'Tom Hardy',
                                        isBold: FontWeight.bold),
                                    const SizedBox(height: 7),
                                    AppText(
                                        size: 15,
                                        text: 'Eddy Brook / Venom',
                                        color: greyColor),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
