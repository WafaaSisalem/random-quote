import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/quote_model.dart';
import '../../providers/favorite_quotes_provider.dart';
import '../../providers/quote_provider.dart';
import '../../providers/translation_provider.dart';
import '../../utils/constants.dart';
import 'quote_widget.dart';

class QuoteFavListItem extends ConsumerWidget {
  final QuoteModel quote;

  const QuoteFavListItem({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTranslationSide = ref.watch(translationStateProvider(quote.id));
    return QuoteWidget(
      translation: Align(
        alignment: Alignment.centerRight,
        child: Text(
          quote.translation,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              height: 1.7,
              fontFamily: 'Expo',
              fontSize: 13,
              fontWeight: FontWeight.w500),
          textDirection: TextDirection.rtl,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      isTranslationSide: isTranslationSide,
      quote: quote,
      isFavorite: true,
      backgroundImg: quote.image == Constants.defaultImagePath
          ? Image.asset(
              Constants.defaultImagePath,
              fit: BoxFit.cover,
            )
          : Image.network(
              quote.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                Constants.defaultImagePath,
                fit: BoxFit.cover,
              ),
            ),
      onSharePressed: (bytes) {
        ref.read(randomQuoteProvider.notifier).onShare(bytes, quote);
      },
      onFavoritePressed: () {
        ref.read(favoriteQuotesProvider.notifier).deleteFavorite(quote.id);
        if (quote.id == ref.read(randomQuoteProvider).value?.id) {
          ref.read(isFavoriteProvider.notifier).state = false;
        }
      },
      onTranslatePressed: () {
        ref
            .read(translationStateProvider(quote.id).notifier)
            .update((state) => !state);
      },
    );
  }
}
