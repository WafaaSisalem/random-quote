import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/quote_model.dart';
import '../../providers/favorite_quotes_provider.dart';
import '../../providers/img_path_provider.dart';
import '../../providers/quote_provider.dart';
import '../../providers/translation_provider.dart';
import '../../utils/constants.dart';
import 'quote_widget.dart';

class HomeQuoteCardWidget extends ConsumerWidget {
  const HomeQuoteCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String bgPath = ref.watch(selectedImagePathProvider);
    AsyncValue<QuoteModel> asyncQuote = ref.watch(randomQuoteProvider);

    // if translated button is not pressed the value will be empty
    AsyncValue translation = ref.watch(translationProvider);
    bool isTransPressed = ref.watch(translatePressedProvider);
    bool isFavorite = ref.watch(isFavoriteProvider);

    return asyncQuote.when(data: (quote) {
      return QuoteWidget(
          iconsDisabled: (translation.isLoading) ||
                  ((translation.value == Constants.cantGetTrans ||
                          translation.value.isEmpty) &&
                      isTransPressed) ||
                  asyncQuote.hasError ||
                  asyncQuote.value!.content.isEmpty
              ? true
              : false,
          isFavorite: isFavorite,
          backgroundImg: bgPath == Constants.defaultImagePath
              ? Image.asset(
                  Constants.defaultImagePath,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  bgPath,
                  fit: BoxFit.cover,
                ),
          onSharePressed: (bytes) async {
            ref
                .read(randomQuoteProvider.notifier)
                .onShare(bytes, quote.copyWith(translation: translation.value));
          },
          onFavoritePressed: () async {
            ref.read(favoriteQuotesProvider.notifier).onFavoritePressed();
          },
          onTranslatePressed: () async {
            ref.read(translationProvider.notifier).onTranslationPressed(quote);
          },
          quote: quote,
          isTranslationSide: isTransPressed ? true : false,
          translation: translation.when(
              data: (data) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    data,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        height: 1.7,
                        fontFamily: 'Expo',
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                    textDirection: TextDirection.rtl,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              error: (error, stack) {
                return const Text(
                  Constants.cantGetTrans,
                  textDirection: TextDirection.rtl,
                );
              },
              loading: () => const CircularProgressIndicator()));
    }, error: (error, stack) {
      return const Text('Something went wrong, try again!');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
