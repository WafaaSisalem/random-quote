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
  // final ScrollController _scrollController = ScrollController();

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    print('favorite list build method');
    // _scrollController.hasClients
    //     ? WidgetsBinding.instance.addPostFrameCallback((_) {
    //         _scrollController.jumpTo(ref.watch(scrollFavPos));
    //       })
    //     : null;
    return ListView.separated(
        // controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 30),
        separatorBuilder: ((context, index) => const SizedBox(
              height: 30,
            )),
        itemBuilder: (context, index) {
          bool isTransSide =
              ref.watch(translationStateProvider(widget.quotes[index].id));
          return CardWidget(
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
              isTranslationSide: isTransSide,
              quote: widget.quotes[index],
              isFavorite: true,
              backgroundImg: widget.quotes[index].image ==
                      Constants.defaultImagePath
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
                await Share.file('quote image', 'quote.png', bytes, 'image/png',
                    text: widget.quotes[index].translation);
              },
              onFavoritePressed: () {
                // Save the current scroll position
                // ref.read(scrollFavPos.notifier).update(
                //   (state) {
                //     return _scrollController.offset;
                //   },
                // );

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
                    .read(translationStateProvider(widget.quotes[index].id)
                        .notifier)
                    .update((state) {
                  return !state;
                });
              });
        },
        itemCount: widget.quotes.length);
  }
}
