import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channlles_headlines_models.dart';
import 'package:news_app/repository/news_repo.dart';

class NewsViewModel {
  final _rep = NewsRepo();

  Future<NewsChannalsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlinesApi(channelName);
    return response;
  }


   Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}