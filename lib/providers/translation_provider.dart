// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../data/api_helper.dart';
// import '../models/quote_model.dart';
// import '../utils/constants.dart';
// import 'quote_provider.dart';

// class TranslationNotifier extends AsyncNotifier<String> {
//   Future<String> getTranslation() async {
//     AsyncValue<QuoteModel> value = ref.read(randomQuoteProvider);

//     return switch (value) {
//       AsyncData(:final value) =>
//         await ApiHelper.apiHelper.getTranslation(value.content),
//       AsyncError() => Constants.cantGetTrans,
//       _ => Constants.loading
//     };
//   }

//   @override
//   FutureOr<String> build() {
//     return getTranslation();
//   }
// }

// final translationProvider =
//     AsyncNotifierProvider<TranslationNotifier, String>(() {
//   return TranslationNotifier();
// });
// Future<String> getTranslation() async {
//   QuoteModel value = ref.watch(asyncRandomQuoteProvider).value!;
//   late String translation;
//   state = const AsyncValue.loading();
//   state = await AsyncValue.guard(() async {
//     translation = await ApiHelper.apiHelper.getTranslation(value.content);
//     return translation;
//   });
//   return translation;
// }
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_quote_api/utils/constants.dart';

import '../data/api_helper.dart';
import '../models/quote_model.dart';

part 'translation_provider.g.dart';

final translatePressedProvider = StateProvider<bool>((ref) => false);
final translationStateProvider =
    StateProvider.family<bool, String>((ref, id) => false);

@Riverpod(keepAlive: true)
class Translation extends _$Translation {
  onTranslationPressed(QuoteModel quote) async {
    //change the state of translatePressedProvider when translate button is pressed
    ref.read(translatePressedProvider.notifier).update((state) {
      return !state;
    });
    //if translate button is pressed and translation is not available or empty
    //which means this is the first time getting a translation because the build method
    //in translateProvider returns '', then get Translation
    //we must check is this the first time to get translation or not to avoid unnecessary api calls

    if (ref.read(translatePressedProvider) == true &&
        (state.value == '' || state.value == Constants.cantGetTrans)) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        String translation =
            await ApiHelper.apiHelper.fetchTranslation(quote.content);
        return translation;
      });
    }
  }

  @override
  FutureOr<String> build() async {
    return '';
  }
}
