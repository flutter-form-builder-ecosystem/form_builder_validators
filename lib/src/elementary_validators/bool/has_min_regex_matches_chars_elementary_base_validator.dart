import '../../base_elementary_validator.dart';

/// {@template has_min_regex_matcher_chars_template}
/// Extends this class to create a validator that checks whether there is a min
/// number of matches against the defined regex.
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of regex matches required.
/// - [regex] The regular expression to match against input chars.
/// - [errorText] The error message returned if the validation fails.
///
/// {@endtemplate}
abstract base class HasMinRegexMatchesCharsElementaryValidator
    extends BaseElementaryValidator<String, String> {
  /// {@macro has_min_regex_matcher_chars_template}
  HasMinRegexMatchesCharsElementaryValidator({
    /// {@macro base_validator_error_text}
    super.errorText,
  }) : super(ignoreErrorMessage: false);

  /// The minimum number of regex matches required.
  int get atLeast;

  /// Regex used to compute the number of matches.
  RegExp get regex;

  @override
  (bool, String?) transformValueIfValid(String value) {
    final bool isValid = regex.allMatches(value).length >= atLeast;
    return (isValid, isValid ? value : null);
  }
}
