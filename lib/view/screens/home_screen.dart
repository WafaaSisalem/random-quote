import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_quote_api/providers/quote_provider.dart';
import '../widgets/gridview_widget.dart';
import '../widgets/home_quote_card_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGetQuoteButton(context, ref),
            const SizedBox(
              height: 25,
            ),
            const HomeQuoteCardWidget(),
            const SizedBox(
              height: 50,
            ),
            const Expanded(child: BackgroundGridWidget())
          ],
        ),
      ),
    );
  }

  ElevatedButton buildGetQuoteButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: const Text('Get a Quote!'),
      onPressed: () async {
        ref.read(randomQuoteProvider.notifier).updateQuote();
      },
    );
  }
}
