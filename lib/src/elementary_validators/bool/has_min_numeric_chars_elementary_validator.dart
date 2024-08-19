import '../../../localization/l10n.dart';
import 'has_min_regex_matches_chars_elementary_base_validator.dart';

/// {@template has_min_numeric_chars_template}
/// This validator checks whether the user input has more than or equal to
/// [atLeast] numeric chars.
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of numeric characters required.
/// - [regex] The regular expression used to identify numeric characters.
/// - [errorText] The error message returned if the validation fails.
///
/// {@macro numeric_chars_template}
/// {@endtemplate}
final class HasMinNumericCharsElementaryValidator
    extends HasMinRegexMatchesCharsElementaryValidator {
  /// {@macro has_min_numeric_chars_template}
  HasMinNumericCharsElementaryValidator({
    this.atLeast = 1,

    // TODO(ArturAssisComp): clarify what is the use case for this regex?
    /// {@macro numeric_chars_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,
  }) : regex = regex ?? defaultNumericCharRegex;

  /// The minimum number of numeric characters required.
  @override
  final int atLeast;

  /// The regular expression used to identify numeric characters.
  @override
  final RegExp regex;

  /// {@template numeric_chars_template}
  /// This regex matches any character that is a digit (0-9).
  ///
  /// - It includes all numeric digits.
  /// - It can be used to find numeric characters.
  ///
  /// Examples: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
  /// {@endtemplate}
  static final RegExp defaultNumericCharRegex = RegExp('[0-9]');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsNumberErrorText(atLeast);
}
