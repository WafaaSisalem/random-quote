import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_quote_api/data/api_helper.dart';
import 'package:test_quote_api/providers/quote_provider.dart';

import '../data/db_helper.dart';
import '../models/quote_model.dart';
import '../utils/constants.dart';
import 'img_path_provider.dart';
import 'translation_provider.dart';

part 'favorite_quotes_provider.g.dart';

final isFavoriteProvider = StateProvider<bool>((ref) => false);

@Riverpod(keepAlive: true)
class FavoriteQuotes extends _$FavoriteQuotes {
  @override
  Future<List<QuoteModel>> build() {
    return getAllFavorites();
  }

  Future<List<QuoteModel>> getAllFavorites() async {
    List<Map<String, dynamic>> favoritesMap =
        await DBHelper.dbHelper.getAllFavorites();
    List<QuoteModel> favoriteQuotes =
        favoritesMap.map((e) => QuoteModel.fromMap(e)).toList();
    return favoriteQuotes.reversed.toList();
  }

  addToFavorites(QuoteModel quote) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // if the image is exist in favorites, delete it then add it again (because the pics maybe changed)
      final ids = state.value?.map((q) => q.id).toList() ?? [];

      if (ids.contains(quote.id)) {
        await DBHelper.dbHelper.deleteFavorite(quote.id);
      }
      await DBHelper.dbHelper.addToFavorites(quote.toMap());

      return getAllFavorites();
    });
  }

  deleteFavorite(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await DBHelper.dbHelper.deleteFavorite(id);
      return getAllFavorites();
    });
  }

  onFavoritePressed() async {
    ref.read(isFavoriteProvider.notifier).update((state) {
      return !state;
    });

    AsyncValue translation = ref.read(translationProvider);
    String bgPath = ref.read(selectedImagePathProvider);
    AsyncValue<QuoteModel> asyncQuote = ref.read(randomQuoteProvider);

    //we check if we have translation then we add it to the quote then we add
    //the quote to the favorite with the translation
    QuoteModel quote = asyncQuote.value!
        .copyWith(translation: translation.value, image: bgPath);
    //////////add the new quote with new translation and bgpath to favorite
    if (ref.read(isFavoriteProvider)) {
      if (quote.translation.isEmpty ||
          quote.translation == Constants.cantGetTrans) {
        try {
          String translation =
              await ApiHelper.apiHelper.fetchTranslation(quote.content);
          quote = quote.copyWith(translation: translation);
        } catch (e) {
          quote = quote.copyWith(translation: Constants.cantGetTrans);
        }
      }
      addToFavorites(quote);
    } else {
      deleteFavorite(quote.id);
    }
  }
}
