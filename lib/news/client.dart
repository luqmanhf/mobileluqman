import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobileluqman/news/response_articles.dart';

class Client {
  static Future<List<Article>> fetchArticle() async {
    const url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1f376c1cfa664adc9380e64c81e4e161";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ResponseArticles responseArticles =
        ResponseArticles.fromJson(responseBody);
      return responseArticles.articles;
    } else {
        throw Exception ("Gagal memuat artikel");
    }
  }
}