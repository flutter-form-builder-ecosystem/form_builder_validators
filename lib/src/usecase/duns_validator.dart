import '../../localization/l10n.dart';
import '../base_validator.dart';

class DunsValidator extends BaseValidator<String> {
  DunsValidator({
    /// {@macro duns_template}
    RegExp? regex,
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _duns;

  final RegExp regex;

  /// {@template duns_template}
  /// This regex matches a valid DUNS number format.
  ///
  /// - It requires exactly 9 digits.
  ///
  /// Examples: 123456789, 987654321
  /// {@endtemplate}
  static final RegExp _duns = RegExp(r'^\d{9}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.dunsErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    return null;
  }
}
