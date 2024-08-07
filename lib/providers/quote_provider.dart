import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:test_quote_api/models/quote_model.dart';
import 'package:test_quote_api/providers/favorite_quotes_provider.dart';
import 'package:test_quote_api/providers/translation_provider.dart';
import 'package:test_quote_api/utils/constants.dart';
import '../data/api_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'quote_provider.g.dart';

@Riverpod(keepAlive: true)
class RandomQuote extends _$RandomQuote {
  Future<QuoteModel> getQuote() async {
    Map<String, dynamic> data = await ApiHelper.apiHelper.fetchRandomQuote();

    return QuoteModel.fromMap(data);
  }

  @override
  FutureOr<QuoteModel> build() {
    return getQuote();
  }

  Future<void> updateQuote() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => getQuote());
    //in each time we call updateQuote we will reset the translation to its initial state
    //so we have to invalidate it, and set the translation pressed to false because
    // we want the card return to the English side.
    ref.invalidate(translationProvider);
    ref.read(translatePressedProvider.notifier).state = false;
    ref.read(isFavoriteProvider.notifier).state = false;
  }

  onShare(bytes, QuoteModel quote) async {
    await Share.file('quote image', 'quote.png', bytes, 'image/png',
        text: quote.translation.isNotEmpty
            ? quote.translation == Constants.cantGetTrans
                ? ''
                : quote.translation
            : quote.content);
  }
}
