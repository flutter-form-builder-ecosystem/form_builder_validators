import '../../localization/l10n.dart';
import '../base_validator.dart';

class PassportNumberValidator extends BaseValidator<String> {
  PassportNumberValidator({
    /// {@macro passport_number_template}
    RegExp? regex,
    this.passportNumberWhitelist = const <String>[],
    this.passportNumberBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _passportNumber;

  final RegExp regex;

  final List<String> passportNumberWhitelist;

  final List<String> passportNumberBlacklist;

  /// {@template passport_number_template}
  /// This regex matches a valid passport number format.
  ///
  /// - It requires alphanumeric characters.
  /// - The length of the passport number can vary but typically falls between 6 to 9 characters.
  ///
  /// Examples: A1234567, 123456789, AB123456
  /// {@endtemplate}
  static final RegExp _passportNumber = RegExp(r'^[A-Za-z0-9]{6,9}$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.passportNumberErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (passportNumberBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (passportNumberWhitelist.isEmpty ||
        passportNumberWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
