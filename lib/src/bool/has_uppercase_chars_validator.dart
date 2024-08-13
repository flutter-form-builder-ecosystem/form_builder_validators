import '../../form_builder_validators.dart';
import '../elementary_validators/bool/bool.dart';

/// {@template has_uppercase_chars_template}
/// [HasUppercaseCharsValidator] extends [TranslatedValidator] to validate if a string
/// contains a specified minimum number of uppercase characters.
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of uppercase characters required.
/// - [regex] The regular expression used to identify uppercase characters.
/// - [errorText] The error message returned if the validation fails.
///
/// {@macro upper_case_template}
/// {@endtemplate}
class HasUppercaseCharsValidator extends TranslatedValidator<String> {
  /// Constructor for the uppercase characters validator.
  HasUppercaseCharsValidator({
    this.atLeast = 1,

    // TODO(ArturAssisComp): clarify what is the use case for this regex?
    /// {@macro upper_case_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _upperCase;

  /// The minimum number of uppercase characters required.
  final int atLeast;

  /// The regular expression used to identify uppercase characters.
  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsUppercaseCharErrorText(atLeast);

  /// {@template upper_case_template}
  /// This regex matches any character that is an uppercase letter (A-Z).
  ///
  /// - It includes all uppercase letters.
  /// - It can be used to find uppercase characters.
  ///
  /// Examples: A, B, C
  /// {@endtemplate}
  static final RegExp _upperCase = RegExp('[A-Z]');

  @override
  String? validateValue(String valueCandidate) {
    final HasMinUppercaseCharsElementaryValidator elementaryValidator =
        HasMinUppercaseCharsElementaryValidator(
      atLeast: atLeast,
      errorText: errorText,
      regex: regex,
    );

    return elementaryValidator.transformValueIfValid(valueCandidate).$1
        ? null
        : elementaryValidator.errorText;
  }

  /// Calculates the number of uppercase characters in the given value.
  ///
  /// ## Parameters:
  /// - [value] The string to be evaluated.
  ///
  /// ## Returns:
  /// The count of uppercase characters in the string.
  int uppercaseCharLength(String value) {
    return regex.allMatches(value).length;
  }
}
