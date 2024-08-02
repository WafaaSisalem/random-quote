import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_quote_api/providers/img_path_provider.dart';

class BackgroundGridWidget extends ConsumerWidget {
  const BackgroundGridWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imgsPathsAsyncValue = ref.watch(imgsPathsProvider);
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Choose Background',
              style: Theme.of(context).textTheme.titleLarge!),
          TextButton(
              onPressed: () {
                ref.invalidate(imgsPathsProvider);
              },
              child: const Text('refresh'))
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Expanded(
        child: imgsPathsAsyncValue.when(
            data: (data) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15,
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      mainAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ref
                            .read(selectedImagePathProvider.notifier)
                            .setImg(data[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                  data[index],
                                ),
                                fit: BoxFit.cover)),
                      ),
                    );
                  },
                  itemCount: 10,
                ),
            error: (error, stackTrace) => Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Cannot load images, ',
                      children: [
                        TextSpan(
                          text: 'try again!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ref.invalidate(imgsPathsProvider);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
            loading: () => const Center(child: CircularProgressIndicator())),
      )
    ]);
  }
}
