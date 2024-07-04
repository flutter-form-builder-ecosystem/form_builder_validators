import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template time_validator_template}
/// [TimeValidator] extends [BaseValidator] to validate if a string represents a valid time in 24-hour or 12-hour format.
///
/// This validator checks if the string matches the time format or can be parsed into a valid time.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the time format. Defaults to a standard time regex.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class TimeValidator extends BaseValidator<String> {
  /// Constructor for the time string validator.
  TimeValidator({
    /// {@macro time_template}
    RegExp? regex,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  }) : regex = regex ?? _time;

  /// The regular expression used to validate the time format.
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
  String? validateValue(String valueCandidate) {
    if (regex.hasMatch(valueCandidate) ||
        DateTime.tryParse(valueCandidate) != null) {
      return null;
    }
    return errorText;
  }
}
