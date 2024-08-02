import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_quote_api/providers/quote_provider.dart';
import 'package:test_quote_api/utils/constants.dart';

import '../data/api_helper.dart';
import 'favorite_quotes_provider.dart';

part 'img_path_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<String>> imgsPaths(ImgsPathsRef ref) async {
  return await ApiHelper.apiHelper.fetchRandomImages(
      ref.read(randomQuoteProvider).value == null
          ? ''
          : ref.read(randomQuoteProvider).value!.content);
}

@Riverpod(keepAlive: true)
class SelectedImagePath extends _$SelectedImagePath {
  @override
  String build() {
    return Constants.defaultImagePath;
  }

  setImg(String img) {
    //this line to reset favorite button to unfavorite
    ref.read(isFavoriteProvider.notifier).state = false;
    state = img;
  }
}
