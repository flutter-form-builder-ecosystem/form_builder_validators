import '../../../localization/l10n.dart';
import '../../elementary_validator.dart';

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
    extends BaseElementaryValidator<String, String> {
  /// {@macro has_uppercase_chars_template}
  HasMinUppercaseCharsElementaryValidator({
    this.atLeast = 1,

    // TODO(ArturAssisComp): clarify what is the use case for this regex?
    /// {@macro upper_case_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,
  }) : regex = regex ?? _upperCase;

  /// The minimum number of uppercase characters required.
  final int atLeast;

  /// The regular expression used to identify uppercase characters.
  final RegExp regex;

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
  (bool, String?) transformValueIfValid(String value) {
    final bool isValid = regex.allMatches(value).length >= atLeast;
    return (isValid, isValid ? value : null);
  }

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsUppercaseCharErrorText(atLeast);
}
