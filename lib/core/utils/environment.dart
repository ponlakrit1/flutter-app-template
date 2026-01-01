import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  final String baseUrl;

  Environment({required this.baseUrl});

  factory Environment.fromDotEnv() {
    return Environment(baseUrl: dotenv.env['BASE_URL'] ?? '');
  }
}
