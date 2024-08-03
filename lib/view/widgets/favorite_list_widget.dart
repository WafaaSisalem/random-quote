import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_quote_api/models/quote_model.dart';
import 'package:test_quote_api/view/widgets/card_widget.dart';

import '../../providers/favorite_quotes_provider.dart';
import '../../providers/quote_provider.dart';
import '../../providers/translation_provider.dart';
import '../../utils/constants.dart';

class FavoriteListWidget extends ConsumerStatefulWidget {
  const FavoriteListWidget({super.key, required this.quotes});
  final List<QuoteModel> quotes;

  @override
  ConsumerState<FavoriteListWidget> createState() => _FavoriteListWidgetState();
}

class _FavoriteListWidgetState extends ConsumerState<FavoriteListWidget> {
  @override
  Widget build(BuildContext context) {
    print('favorite list build method');

    return ListView.separated(
        padding: const EdgeInsets.only(bottom: 30),
        separatorBuilder: ((context, index) => const SizedBox(
              height: 30,
            )),
        itemBuilder: (context, index) {
          return buildQuoteWidget(index, context);
        },
        itemCount: widget.quotes.length);
  }

  QuoteWidget buildQuoteWidget(int index, BuildContext context) {
    print(index);
    return QuoteWidget(
        translation: Align(
          alignment: Alignment.centerRight,
          child: Text(
            widget.quotes[index].translation,
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
        isTranslationSide:
            ref.watch(translationStateProvider(widget.quotes[index].id)),
        quote: widget.quotes[index],
        isFavorite: true,
        backgroundImg: widget.quotes[index].image == Constants.defaultImagePath
            ? Image.asset(
                Constants.defaultImagePath,
                fit: BoxFit.cover,
              )
            : Image.network(
                widget.quotes[index].image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  Constants.defaultImagePath,
                  fit: BoxFit.cover,
                ),
              ),
        onSharePressed: (bytes) async {
          ref
              .read(randomQuoteProvider.notifier)
              .onShare(bytes, widget.quotes[index]);
        },
        onFavoritePressed: () {
          ref
              .read(favoriteQuotesProvider.notifier)
              .deleteFavorite(widget.quotes[index].id);
          //check if the quote we display now in the home screen card is deleted
          //then set favorite button to false
          if (widget.quotes[index].id ==
              ref.watch(randomQuoteProvider).value!.id) {
            ref.read(isFavoriteProvider.notifier).state = false;
          }
        },
        onTranslatePressed: () async {
          ref
              .read(translationStateProvider(widget.quotes[index].id).notifier)
              .update((state) {
            return !state;
          });
        });
  }
}
