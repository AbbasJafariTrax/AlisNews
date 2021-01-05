import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';

class NewsApiProvider {
  Future<List<NewsModel>> getTopNews({String category}) async {
    String url =
        "http://newsapi.org/v2/top-headlines?apiKey=589bb9f8ad824daba583328e8d0d000d&language=en&category=$category";
    var response = await http.get(url);
    print("this is the url $url");
    //Error in connection or unexpected error
    if (response.statusCode != 200)
      throw Exception("Status code: ${response.statusCode}");
    //decode json file
    Map parsedJson = json.decode(response.body);
    //Error in sending parameters or apikey or other unexpected error
    if (parsedJson['status'] != 'ok')
      throw Exception("Status code: $parsedJson");
    print("response $parsedJson['articles']");
    //change articls to list of NewsModel
    return (parsedJson['articles'] as List)
        .map((article) => NewsModel.fromJson(article))
        .toList();
  }

  Future<List<NewsModel>> searchNews({
    String q,
    String lang = "en",
    String country,
  }) async {
    String url =
        "http://newsapi.org/v2/top-headlines?apiKey=589bb9f8ad824daba583328e8d0d000d&category=$q&language=$lang&country=$country";
    var response = await http.get(url);
    //Error in connection or unexpected error
    if (response.statusCode != 200)
      throw Exception("Status code: ${response.statusCode}");
    //decode json file
    Map parsedJson = json.decode(response.body);
    //Error in sending parameters or apikey or other unexpected error
    if (parsedJson['status'] != 'ok')
      throw Exception("Status code: $parsedJson");
    //change articls to list of NewsModel
    return (parsedJson['articles'] as List)
        .map((article) => NewsModel.fromJson(article))
        .toList();
  }
}
