import '../../../localization/l10n.dart';
import 'has_min_regex_matches_chars_elementary_base_validator.dart';

/// {@template has_min_special_chars_template}
/// This validator checks whether the user input has more than or equal to
/// [atLeast] special chars.
///
/// ## Parameters:
///
/// - [atLeast] The minimum number of special characters required.
/// - [regex] The regular expression used to identify special characters.
/// - [errorText] The error message returned if the validation fails.
///
/// {@macro special_chars_template}
/// {@endtemplate}
final class HasMinSpecialCharsElementaryValidator
    extends HasMinRegexMatchesCharsElementaryValidator {
  /// {@macro has_min_special_chars_template}
  HasMinSpecialCharsElementaryValidator({
    this.atLeast = 1,

    // TODO(ArturAssisComp): clarify what is the use case for this regex?
    /// {@macro special_chars_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,
  }) : regex = regex ?? defaultSpecialCharRegex;

  /// The minimum number of special characters required.
  @override
  final int atLeast;

  /// The regular expression used to identify special characters.
  @override
  final RegExp regex;

  /// {@template special_chars_template}
  /// This regex matches any character that is not a letter (A-Z, a-z) or a digit (0-9).
  ///
  /// - It includes special characters and symbols.
  /// - It can be used to find non-alphanumeric characters.
  ///
  /// Examples: @, #, %
  /// {@endtemplate}
  static final RegExp defaultSpecialCharRegex = RegExp('[^A-Za-z0-9]');

  // TODO (ArturAssisComp): add test cases for covering the translatedErrorText
  // default message.
  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsSpecialCharErrorText(atLeast);
}
