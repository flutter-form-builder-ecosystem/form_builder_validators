import '../../localization/l10n.dart';
import '../base_validator.dart';

class HasNumericCharsValidator extends BaseValidator<String> {
  HasNumericCharsValidator({
    this.atLeast = 1,

    /// {@macro numeric_chars_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _number;

  final int atLeast;

  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsNumberErrorText(atLeast);

  /// {@template numeric_chars_template}
  /// This regex matches any character that is not a digit (0-9).
  ///
  /// - It includes special characters, letters, and other non-numeric characters.
  /// - It can be used to find non-digit characters.
  ///
  /// Examples: a, A, @
  /// {@endtemplate}
  static final RegExp _number = RegExp('[0-9]');

  @override
  String? validateValue(String valueCandidate) {
    return numberCharLength(valueCandidate) >= atLeast ? null : errorText;
  }

  int numberCharLength(String value) {
    return regex.allMatches(value).length;
  }
}
