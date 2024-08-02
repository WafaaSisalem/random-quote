import 'package:dio/dio.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:test_quote_api/utils/constants.dart';

import '../my_keys.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  Dio dio = Dio();
  static const String quoteApiUrl = 'https://api.quotable.io';
  static const String unsplashApiUrl = 'https://api.unsplash.com/photos/random';
  static const String unsplashAccessKey = unsplashKey;
////////////////////////////////RANDOM IMAGE ////////////////////
  Future<List<String>> fetchRandomImages(String quoteText) async {
    List<String> words =
        quoteText.replaceAll(RegExp(r'[^\w\s]'), '').split(' ');
    // Join the words with commas
    String result = words.join(',');

    // const query = 'dark,moon,stars,night,galaxy,inspiration,lights';

    try {
      Response response = await dio.get(
        '$unsplashApiUrl?count=10&query=$result',
        // '$unsplashApiUrl?count=10&query=$query',
        options:
            Options(headers: {'Authorization': 'Client-ID $unsplashAccessKey'}),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((img) => img['urls']['regular'] as String).toList();
      } else {
        throw Exception('Failed to load images');
      }
      // ignore: unused_catch_clause
    } on DioException catch (e) {
      throw Exception('Failed to load images');
    }
  }

  //////////////////////////////RANDOM QUOTE //////////////////////
  Future<Map<String, dynamic>> fetchRandomQuote() async {
    String url = '$quoteApiUrl/random?maxLength=80';
    try {
      Response response = await dio.get(url);

      Map<String, dynamic> data = response.data;

      return data;
      // ignore: unused_catch_clause
    } on DioException catch (e) {
      //TODO: handle error
    }
    return <String, dynamic>{};
  }

  getQuoteById(String id) async {
    String url = '$quoteApiUrl/quotes/:$id';

    Response response = await dio.get(url);
    Map<String, dynamic> data = response.data;
    return data;
  }

///////////////////////////TRANSLATION ///////////////////////////
  Future<String> fetchTranslation(String text) async {
    String translation = Constants.cantGetTrans;
    // const apiKey = String.fromEnvironment('API_KEY');
    // if (apiKey.isEmpty) {
    //   print('api key is not set');
    //   throw AssertionError('api key is not set');
    // }
    try {
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

      final content = [Content.text(' ما هو ترجمة هذا الاقتباس $text')];

      final response = await model.generateContent(content);

      translation = response.text ?? Constants.cantGetTrans;
    } catch (e) {
      rethrow;
    }
    return translation;
  }
}
