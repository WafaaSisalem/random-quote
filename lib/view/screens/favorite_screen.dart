import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/quote_model.dart';
import '../../providers/favorite_quotes_provider.dart';
import '../widgets/favorite_list_widget.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});
  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    print('rebuilding');

    AsyncValue<List<QuoteModel>> asyncQuotes =
        ref.watch(favoriteQuotesProvider);
    return asyncQuotes.when(
        data: (List<QuoteModel> quotes) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: FavoriteListWidget(quotes: quotes),
              ),
            ],
          );
        },
        error: (error, stack) => const Text('can not get favorites'),
        loading: () => const CircularProgressIndicator());
  }
}
