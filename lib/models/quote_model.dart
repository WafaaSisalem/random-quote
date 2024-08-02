import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_quote_api/utils/constants.dart';

part 'quote_model.freezed.dart';

@freezed
class QuoteModel with _$QuoteModel {
  const QuoteModel._();
  const factory QuoteModel(
      {required String id,
      required String content,
      required String author,
      required String image,
      required String translation}) = _QuoteModel;
  Map<String, dynamic> toMap() {
    return {
      Constants.idKey: id,
      Constants.contentKey: content,
      Constants.authorKey: author,
      Constants.imageKey: image,
      Constants.translationKey: translation
    };
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      id: map[Constants.idKey] ?? '',
      content: map[Constants.contentKey] ?? '',
      author: map[Constants.authorKey] ?? '',
      image: map[Constants.imageKey] ?? Constants.defaultImagePath,
      translation: map[Constants.translationKey] ?? '',
    );
  }
  factory QuoteModel.defaultQ() {
    return const QuoteModel(
      id: '0',
      author: Constants.defaultAuthor,
      content: Constants.defaultQuoteContent,
      image: Constants.defaultImagePath,
      translation: Constants.defaultTranslation,
    );
  }
}
