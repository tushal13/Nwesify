import 'package:flutter/material.dart';

import '../helper/news_helper.dart';
import '../modal/news_modal.dart';

class NewsController extends ChangeNotifier {
  List<NewsModal> headline = [];
  List<NewsModal> search = [];
  String country = 'in';
  String category = 'Business';
  String query = 'apple';

  void changeCategory(String newCategory) {
    category = newCategory;
    notifyListeners();
  }

  void searchtext(String query) {
    this.query = query;
    notifyListeners();
  }

  NewsController() {
    fatcheadline();
    searchnews();
  }

  Future<List<NewsModal>?> fatcheadline() async {
    headline =
        await NewsApiHelper.newsApiHelper.fatcheadline(country, category) ?? [];
    notifyListeners();
    return headline;
  }

  Future<List<NewsModal>?> searchnews() async {
    search = await NewsApiHelper.newsApiHelper.searchnews(query) ?? [];
    notifyListeners();
    return search;
  }
}
