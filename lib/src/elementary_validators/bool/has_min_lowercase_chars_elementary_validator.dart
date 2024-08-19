import '../../../localization/l10n.dart';
import '../../elementary_validator.dart';

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
    extends BaseElementaryValidator<String, String> {
  /// {@macro has_lowercase_chars_template}
  HasMinLowercaseCharsElementaryValidator({
    this.atLeast = 1,

    // TODO(ArturAssisComp): clarify what is the use case for this regex?
    /// {@macro lower_case_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,
  }) : regex = regex ?? _lowerCase;

  /// The minimum number of lowercase characters required.
  final int atLeast;

  /// The regular expression used to identify lowercase characters.
  final RegExp regex;

  /// {@template lower_case_template}
  /// This regex matches any character that is an lowercase letter (A-Z).
  ///
  /// - It includes all lowercase letters.
  /// - It can be used to find lowercase characters.
  ///
  /// Examples: a, b, c
  /// {@endtemplate}
  static final RegExp _lowerCase = RegExp('[a-z]');

  @override
  (bool, String?) transformValueIfValid(String value) {
    // TODO (ArturAssisComp): remember to cover the edge case when length is
    // equal to atLeast
    final bool isValid = regex.allMatches(value).length >= atLeast;
    return (isValid, isValid ? value : null);
  }

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsLowercaseCharErrorText(atLeast);
}
