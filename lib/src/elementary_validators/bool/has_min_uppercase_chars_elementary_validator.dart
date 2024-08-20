import '../../../localization/l10n.dart';
import 'has_min_regex_matches_chars_elementary_base_validator.dart';

/// {@template has_uppercase_chars_template}
/// This validator checks whether the user input has more than or equal to
/// [atLeast] uppercase chars.
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of uppercase characters required.
/// - [regex] The regular expression used to identify uppercase characters.
/// - [errorText] The error message returned if the validation fails.
///
/// {@macro upper_case_template}
/// {@endtemplate}
final class HasMinUppercaseCharsElementaryValidator
    extends HasMinRegexMatchesCharsElementaryValidator {
  /// {@macro has_uppercase_chars_template}
  HasMinUppercaseCharsElementaryValidator({
    this.atLeast = 1,

    // TODO(ArturAssisComp): clarify what is the use case for this regex?
    /// {@macro upper_case_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,
  }) : regex = regex ?? defaultUpperCaseCharRegex;

  /// The minimum number of uppercase characters required.
  @override
  final int atLeast;

  /// The regular expression used to identify uppercase characters.
  @override
  final RegExp regex;

  /// {@template upper_case_template}
  /// This regex matches any character that is an uppercase letter (A-Z).
  ///
  /// - It includes all uppercase letters.
  /// - It can be used to find uppercase characters.
  ///
  /// Examples: A, B, C
  /// {@endtemplate}
  static final RegExp defaultUpperCaseCharRegex = RegExp('[A-Z]');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsUppercaseCharErrorText(atLeast);
}
