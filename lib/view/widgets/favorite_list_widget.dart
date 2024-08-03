import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_quote_api/models/quote_model.dart';
import 'package:test_quote_api/view/widgets/card_widget.dart';

import '../../providers/favorite_quotes_provider.dart';
import '../../providers/quote_provider.dart';
import '../../providers/translation_provider.dart';
import '../../utils/constants.dart';
import 'quote_list_item.dart';

class FavoriteListWidget extends ConsumerWidget {
  const FavoriteListWidget({super.key, required this.quotes});
  final List<QuoteModel> quotes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('favorite list build method');

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 30),
      separatorBuilder: ((context, index) => const SizedBox(height: 30)),
      itemBuilder: (context, index) {
        final quote = quotes[index];
        return QuoteListItem(
          quote: quote,
          // onFavoritePressed: () {
          //   ref.read(favoriteQuotesProvider.notifier).deleteFavorite(quote.id);
          //   if (quote.id == ref.read(randomQuoteProvider).value?.id) {
          //     ref.read(isFavoriteProvider.notifier).state = false;
          //   }
          // },
          // onSharePressed: (bytes) async {
          //   ref.read(randomQuoteProvider.notifier).onShare(bytes, quote);
          // },
        );
      },
      itemCount: quotes.length,
    );
  }
}
