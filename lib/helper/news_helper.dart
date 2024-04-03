import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:nwesify/modal/news_modal.dart';

class NewsApiHelper {
  NewsApiHelper._();

  static final NewsApiHelper newsApiHelper = NewsApiHelper._();

  Future<List<NewsModal>?> fatcheadline(String country, String category) async {
    String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=87e487d01f214bfe9619e471fc33da77';
    print(apiUrl);
    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        List data = responseData['articles'];
        List<NewsModal> headline =
            data.map((e) => NewsModal.fromMap(e)).toList();
        Logger().i(headline[0].title);
        return headline;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception while fetching data: $e');
      return null;
    }
  }

  Future<List<NewsModal>?> searchnews(String query) async {
    String apiUrl =
        'https://newsapi.org/v2/everything?q=$query&from=2024-03-31&to=2024-03-31&sortBy=popularity&apiKey=87e487d01f214bfe9619e471fc33da77';
    print(apiUrl);
    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        List data = responseData['articles'];
        List<NewsModal> search = data.map((e) => NewsModal.fromMap(e)).toList();
        Logger().w(search[0].title);
        return search;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception while fetching data: $e');
      return null;
    }
  }
}
