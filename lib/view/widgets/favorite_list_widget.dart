import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_quote_api/providers/favorite_quotes_provider.dart';

import 'quote_fav_list_item.dart';

final pageBucket = PageStorageBucket();

class FavoriteListWidget extends ConsumerWidget {
  const FavoriteListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue asyncFavQuotes = ref.watch(favoriteQuotesProvider);
    return asyncFavQuotes.when(
        data: (quotes) => PageStorage(
              bucket: pageBucket,
              child: ListView.separated(
                key: const PageStorageKey('favorites'),
                padding: const EdgeInsets.only(bottom: 30),
                separatorBuilder: ((context, index) =>
                    const SizedBox(height: 30)),
                itemBuilder: (context, index) {
                  final quote = quotes[index];
                  return QuoteFavListItem(
                    quote: quote,
                  );
                },
                itemCount: quotes.length,
              ),
            ),
        error: (error, stack) => const Text('can not get favorites'),
        loading: () => const CircularProgressIndicator());
  }
}
