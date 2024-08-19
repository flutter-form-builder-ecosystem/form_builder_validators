import '../../form_builder_validators.dart';
import '../elementary_validators/bool/bool.dart';

/// {@template has_numeric_chars_template}
/// [HasNumericCharsValidator] extends [TranslatedValidator] to validate if a string
/// contains a specified minimum number of numeric characters (digits).
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of numeric characters required.
/// - [regex] The regular expression used to identify numeric characters.
/// - [errorText] The error message returned if the validation fails.
///
/// {@macro numeric_chars_template}
/// {@endtemplate}
class HasNumericCharsValidator extends TranslatedValidator<String> {
  /// Constructor for the numeric characters validator.
  HasNumericCharsValidator({
    this.atLeast = 1,

    /// {@macro numeric_chars_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _number;

  /// The minimum number of numeric characters required.
  final int atLeast;

  /// The regular expression used to identify numeric characters.
  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsNumberErrorText(atLeast);

  /// {@template numeric_chars_template}
  /// This regex matches any character that is a digit (0-9).
  ///
  /// - It includes all numeric digits.
  /// - It can be used to find numeric characters.
  ///
  /// Examples: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
  /// {@endtemplate}
  static final RegExp _number =
      HasMinNumericCharsElementaryValidator.defaultNumericCharRegex;

  @override
  String? validateValue(String valueCandidate) {
    final HasMinNumericCharsElementaryValidator elementaryValidator =
        HasMinNumericCharsElementaryValidator(
      atLeast: atLeast,
      errorText: errorText,
      regex: regex,
    );

    return elementaryValidator.transformValueIfValid(valueCandidate).$1
        ? null
        : elementaryValidator.errorText;
  }
}
