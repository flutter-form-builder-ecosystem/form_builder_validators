import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template has_lowercase_chars_template}
/// [HasLowercaseCharsValidator] extends [BaseValidator] to validate if a string
/// contains a specified minimum number of lowercase characters.
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of lowercase characters required.
/// - [regex] The regular expression used to identify lowercase characters.
/// - [errorText] The error message returned if the validation fails.
///
/// {@macro lower_case_template}
/// {@endtemplate}
class HasLowercaseCharsValidator extends BaseValidator<String> {
  /// Constructor for the lowercase characters validator.
  HasLowercaseCharsValidator({
    this.atLeast = 1,

    /// {@macro lower_case_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _lowerCase;

  /// The minimum number of lowercase characters required.
  final int atLeast;

  /// The regular expression used to identify lowercase characters.
  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsLowercaseCharErrorText(atLeast);

  /// {@template lower_case_template}
  /// This regex matches any character that is a lowercase letter (a-z).
  ///
  /// - It includes all lowercase letters.
  /// - It can be used to find lowercase characters.
  ///
  /// Examples: a, b, c
  /// {@endtemplate}
  static final RegExp _lowerCase = RegExp('[a-z]');

  @override
  String? validateValue(String valueCandidate) {
    return lowercaseCharLength(valueCandidate) >= atLeast ? null : errorText;
  }

  /// Calculates the number of lowercase characters in the given value.
  ///
  /// ## Parameters:
  /// - [value] The string to be evaluated.
  ///
  /// ## Returns:
  /// The count of lowercase characters in the string.
  int lowercaseCharLength(String value) {
    return regex.allMatches(value).length;
  }
}
