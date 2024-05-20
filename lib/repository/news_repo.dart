import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channlles_headlines_models.dart';


class NewsRepo {                              // fetch data

  Future<NewsChannalsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=34c17ba2b8dd482abeba7021474a2a2d';
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
    print(response.body);
    }
    if(response.statusCode == 200){   
      final body = jsonDecode(response.body);
      return NewsChannalsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error'); 
  }



  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=34c17ba2b8dd482abeba7021474a2a2d';
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
    print(response.body);
    }
    if(response.statusCode == 200){   
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error'); 
  }





} 