import '../../localization/l10n.dart';
import '../base_validator.dart';

class TimeValidator extends BaseValidator<String> {
  TimeValidator({
    /// {@macro time_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _time;

  final RegExp regex;

  /// {@template time_template}
  /// This regex matches time in 24-hour or 12-hour format.
  ///
  /// - It allows hours and minutes, with optional AM/PM for 12-hour format.
  /// - It supports leading zeros for single-digit hours.
  ///
  /// Examples: 23:59, 11:59 PM
  /// {@endtemplate}
  static final RegExp _time = RegExp(
    r'^(?:[01]?\d|2[0-3]):[0-5]?\d(?::[0-5]?\d)?$|^(?:0?[1-9]|1[0-2]):[0-5]?\d(?::[0-5]?\d)?\s?(?:[AaPp][Mm])$',
  );

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.timeErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    if (regex.hasMatch(valueCandidate!) ||
        DateTime.tryParse(valueCandidate) != null) {
      return null;
    }

    return errorText;
  }
}
