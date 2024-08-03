import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../models/quote_model.dart';

// ignore: must_be_immutable
class QuoteWidget extends StatelessWidget {
  QuoteWidget({
    super.key,
    required this.quote,
    required this.onSharePressed,
    required this.onFavoritePressed,
    required this.onTranslatePressed,
    required this.backgroundImg,
    required this.isFavorite,
    required this.isTranslationSide,
    required this.translation,
    this.iconsDisabled = false,
  });
  final QuoteModel quote;
  final Widget translation;
  final Function(Uint8List bytes) onSharePressed;
  final Function() onFavoritePressed;
  final Function() onTranslatePressed;
  final Widget backgroundImg;
  late BuildContext context;
  final bool isFavorite;
  final bool isTranslationSide;
  final bool iconsDisabled;

  final WidgetsToImageController controller = WidgetsToImageController();
  // bool translationPressed = false;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    double width = MediaQuery.of(context).size.width * 2 / 3;
    double height = MediaQuery.of(context).size.width * 2 / 5;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        WidgetsToImage(
          controller: controller,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: width,
                height: height,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: backgroundImg,
              ),
              Card(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withAlpha(110),
                child: Container(
                    width: width,
                    height: height,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isTranslationSide
                            ? translation
                            : Text(
                                quote.content,
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: isTranslationSide
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Text(
                            quote.author,
                          ),
                        )
                      ],
                    ))),
              ),
            ],
          ),
        ),
        iconsDisabled
            ? const SizedBox()
            : Positioned(
                bottom: -15,
                child: Consumer(builder: (context, ref, child) {
                  // bool isFavorite = ref.watch(isFavoriteProvider);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCardIcon(
                          icon: isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          onPressed: () {
                            // ref.read(isFavoriteProvider.notifier).update((state) {
                            //   return !state;
                            // });
                            onFavoritePressed();
                          }),
                      const SizedBox(
                        width: 15,
                      ),
                      buildCardIcon(
                          icon: Icons.share,
                          onPressed: () async {
                            final bytes = await controller.capture();

                            onSharePressed(bytes!);
                          }),
                      const SizedBox(
                        width: 15,
                      ),
                      buildCardIcon(
                        icon: Icons.translate,
                        onPressed: () {
                          onTranslatePressed();
                        },
                      )
                    ],
                  );
                }),
              )
      ],
    );
  }

  buildCardIcon({required IconData icon, required Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          child: Icon(icon,
              size: 16, color: Theme.of(context).colorScheme.primaryContainer)),
    );
  }
}
