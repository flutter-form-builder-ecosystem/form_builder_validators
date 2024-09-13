import '../../form_builder_validators.dart';

/// {@template has_special_chars_template}
/// [HasSpecialCharsValidator] extends [TranslatedValidator] to validate if a string
/// contains a specified minimum number of special characters.
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of special characters required.
/// - [regex] The regular expression used to identify special characters.
/// - [errorText] The error message returned if the validation fails.
///
/// {@macro special_chars_template}
/// {@endtemplate}
class HasSpecialCharsValidator extends TranslatedValidator<String> {
  /// Constructor for the special characters validator.
  HasSpecialCharsValidator({
    this.atLeast = 1,

    /// {@macro special_chars_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _specialChar;

  /// The minimum number of special characters required.
  final int atLeast;

  /// The regular expression used to identify special characters.
  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsSpecialCharErrorText(atLeast);

  /// {@template special_chars_template}
  /// This regex matches any character that is not a letter (A-Z, a-z) or a digit (0-9).
  ///
  /// - It includes special characters and symbols.
  /// - It can be used to find non-alphanumeric characters.
  ///
  /// Examples: @, #, %
  /// {@endtemplate}
  static final RegExp _specialChar = RegExp('[^A-Za-z0-9]');

  @override
  String? validateValue(String valueCandidate) {
    return specialCharLength(valueCandidate) >= atLeast ? null : errorText;
  }

  /// Calculates the number of special characters in the given value.
  ///
  /// ## Parameters:
  /// - [value] The string to be evaluated.
  ///
  /// ## Returns:
  /// The count of special characters in the string.
  int specialCharLength(String value) {
    return regex.allMatches(value).length;
  }
}
