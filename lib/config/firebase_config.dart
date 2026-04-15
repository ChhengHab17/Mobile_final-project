import 'package:flutter_dotenv/flutter_dotenv.dart';
class FirebaseConfig {
  static Uri get baseUri => Uri.parse(dotenv.env['FIREBASE_DB_URL']!);
}
