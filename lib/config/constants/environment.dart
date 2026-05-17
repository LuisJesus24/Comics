import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String comicVineKey = dotenv.env['COMIC_VINE_KEY'] ?? 'No API Key';
}
