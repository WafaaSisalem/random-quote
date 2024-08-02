import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_quote_api/models/quote_model.dart';
import 'package:test_quote_api/providers/favorite_quotes_provider.dart';
import 'package:test_quote_api/providers/quote_provider.dart';
import 'package:test_quote_api/utils/constants.dart';
import 'package:test_quote_api/view/widgets/card_widget.dart';
import '../../providers/img_path_provider.dart';
import '../../providers/translation_provider.dart';
import '../widgets/gridview_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String bgPath = ref.watch(selectedImagePathProvider);
    AsyncValue<QuoteModel> asyncQuote = ref.watch(randomQuoteProvider);

    // if translated button is not pressed the value will be empty
    AsyncValue translation = ref.watch(translationProvider);
  bool isTransPressed = ref.watch(translatePressedProvider);
    bool isFavorite = ref.watch(isFavoriteProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: const Text('Get a Quote!'),
              onPressed: () async {
                ref.read(randomQuoteProvider.notifier).updateQuote();
              },
            ),
            const SizedBox(
              height: 25,
            ),
            asyncQuote.when(data: (quote) {
              return CardWidget(
                  iconsDisabled: (translation.isLoading)
                      //  || ref.watch(isSharingState)
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
                    // ref.read(isSharingState.notifier).update(
                    //       (state) => true,
                    //     );

                    await Share.file(
                        'quote image', 'quote.png', bytes, 'image/png',
                        text: translation.value.isNotEmpty
                            ? translation.value!
                            : quote.content);
                    // ref.read(isSharingState.notifier).update(
                    //       (state) => false,
                    //     );
                  },
                  onFavoritePressed: () async {
                    ref.read(isFavoriteProvider.notifier).update((state) {
                      return !state;
                    });
                    String transText = translation.value;
                    QuoteModel newQuote = quote;
                    //we check if we have translation then we add it to the quote then we add
                    //the quote to the favorite with the translation

                    newQuote =
                        quote.copyWith(translation: transText, image: bgPath);
                    ref
                        .read(favoriteQuotesProvider.notifier)
                        .onFavoritePressed(newQuote);
                  },
                  onTranslatePressed: () async {
                    ref
                        .read(translationProvider.notifier)
                        .onTranslationPressed(quote);
                  },
                  quote: quote,
                  isTranslationSide:
                      isTransPressed ? true : false,
                  translation: translation.when(
                      data: (data) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            data,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
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
            }),
            const SizedBox(
              height: 50,
            ),
            const Expanded(child: BackgroundGridWidget())
          ],
        ),
      ),
    );
  }
}
