import 'package:themoviedb/configuration/config.dart';

class ImageDownloader {
  static String imageUrl(String path) => Configuration.imageUrl + path;
}
