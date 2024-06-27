import '../../localization/l10n.dart';
import '../base_validator.dart';

class AlphabeticalValidator extends BaseValidator<String> {
  AlphabeticalValidator({
    /// {@macro alphabetical_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _alphabetical;

  final RegExp regex;

  /// {@template alphabetical_template}
  /// This regex matches only alphabetical characters.
  ///
  /// - It allows both uppercase and lowercase letters.
  ///
  /// Examples: abcdef, XYZ
  /// {@endtemplate}
  static final RegExp _alphabetical = RegExp(r'^[a-zA-Z]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.alphabeticalErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return regex.hasMatch(valueCandidate!) ? null : errorText;
  }
}
