import 'package:flutter/widgets.dart';

import '../../form_builder_validators.dart';

/// {@template log_validator_template}
/// [LogValidator] extends [TranslatedValidator] to log the value being validated.
/// This validator is primarily used for debugging purposes and always returns `null`, indicating no validation errors.
///
/// ## Parameters:
///
/// - [log] A custom logging function to log the value. If not provided, the value or error text will be logged using [debugPrint].
/// - [errorText] The error message that can be used for logging if the value is null.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty. This is set to false by default.
///
/// {@endtemplate}
class LogValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the log validator.
  const LogValidator({
    this.log,

    /// {@macro base_validator_error_text}
    super.errorText,
  }) : super(checkNullOrEmpty: false);

  /// A custom logging function to log the value.
  final String Function(T? value)? log;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validate(T? valueCandidate) {
    return validateValue(valueCandidate);
  }

  @override
  String? validateValue(T? valueCandidate) {
    if (log != null) {
      debugPrint(log!(valueCandidate));
    } else if (valueCandidate != null) {
      debugPrint(valueCandidate.toString());
    } else {
      debugPrint(errorText);
    }
    return null;
  }
}
