import 'package:dio/dio.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:test_quote_api/utils/constants.dart';

import '../my_keys.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  Dio dio = Dio();
  static const String quoteApiUrl = 'http://api.quotable.io';
  static const String unsplashApiUrl = 'https://api.unsplash.com/photos/random';
  static const String unsplashAccessKey = unsplashKey;

  List<String> devideQuote(String quote) {
    List<String> splittedQuote = [];
    int i = 0;
    while (i < quote.length) {
      int j = i;
      while ((j < quote.length) && (quote[j] != ' ')) {
        j++;
      }
      splittedQuote.add(quote.substring(i, j));
      i = j + 1;
    }
    List<String> finalList = [];
    for (int k = 0; k < splittedQuote.length - 1; k++) {
      finalList.add('${splittedQuote[k]} ${splittedQuote[k + 1]}');
    }
    return finalList;
  }

////////////////////////////////RANDOM IMAGE ////////////////////
  Future<List<String>> fetchRandomImages(String quoteText) async {
    // // Split the quote text into words
    // List<String> words =
    //     quoteText.replaceAll(RegExp(r'[^\w\s]'), '').split(' ');
    // // Join the words with commas to fit in the request
    // String result = words.join(',');
    List<String> words = devideQuote(quoteText);
    String result = words.join(',');
    try {
      Response response = await dio.get(
        '$unsplashApiUrl?count=10&query=$result',
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
    String url = '$quoteApiUrl/random?maxLength=78';
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;

        return data;
      } else {
        throw Exception('Failed to load a quote');
      }
      // ignore: unused_catch_clause
    } on DioException catch (e) {
      throw Exception('Failed to load a quote');
    }
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
      final safetySettings = [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
      ];
      final model = GenerativeModel(
          model: 'gemini-pro', apiKey: apiKey, safetySettings: safetySettings);

      final content = [Content.text(' ما هو ترجمة هذا الاقتباس $text')];

      final response = await model.generateContent(content);

      translation = response.text ?? Constants.cantGetTrans;
    } catch (e) {
      rethrow;
    }
    return translation;
  }
}
