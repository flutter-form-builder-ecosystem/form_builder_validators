import '../../../localization/l10n.dart';
import 'has_min_regex_matches_chars_elementary_base_validator.dart';

/// {@template has_lowercase_chars_template}
/// This validator checks whether the user input has more than or equal to
/// [atLeast] lowercase chars.
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of lowercase characters required.
/// - [regex] The regular expression used to identify lowercase characters.
/// - [errorText] The error message returned if the validation fails.
///
/// {@macro lower_case_template}
/// {@endtemplate}
final class HasMinLowercaseCharsElementaryValidator
    extends HasMinRegexMatchesCharsElementaryValidator {
  /// {@macro has_lowercase_chars_template}
  HasMinLowercaseCharsElementaryValidator({
    this.atLeast = 1,

    // TODO(ArturAssisComp): clarify what is the use case for this regex?
    /// {@macro lower_case_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,
  }) : regex = regex ?? defaultLowerCaseCharRegex;

  /// The minimum number of lowercase characters required.
  @override
  final int atLeast;

  /// The regular expression used to identify lowercase characters.
  @override
  final RegExp regex;

  /// {@template lower_case_template}
  /// This regex matches any character that is an lowercase letter (A-Z).
  ///
  /// - It includes all lowercase letters.
  /// - It can be used to find lowercase characters.
  ///
  /// Examples: a, b, c
  /// {@endtemplate}
  static final RegExp defaultLowerCaseCharRegex = RegExp('[a-z]');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsLowercaseCharErrorText(atLeast);
}
