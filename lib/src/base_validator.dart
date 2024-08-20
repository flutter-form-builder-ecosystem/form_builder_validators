import 'elementary_validators/required/required.dart';

/// Base class for all validators.
abstract class BaseValidator<T> {
  /// Creates a new instance of the validator.
  const BaseValidator({String? errorText, this.checkNullOrEmpty = true})
      : _errorText = errorText;

  /// Backing field for [errorText].
  final String? _errorText;

  /// {@template base_validator_error_text}
  /// The error message returned if the value is invalid.
  /// {@endtemplate}
  String? get errorText => _errorText;

  /// {@template base_validator_null_check}
  /// Whether to check if the value is null or empty.
  /// {@endtemplate}
  final bool checkNullOrEmpty;

  /// Validates the value and checks if it is null or empty.
  String? validate(T? valueCandidate) {
    final bool isNullOrEmpty = const IsRequiredElementaryValidator<Object>()
                .validate(valueCandidate) !=
            null
        ? true
        : false;

    if (checkNullOrEmpty && isNullOrEmpty) {
      return errorText;
    } else if (!checkNullOrEmpty && isNullOrEmpty) {
      return null;
    } else {
      return validateValue(valueCandidate as T);
    }
  }

  /// Validates the value.
  /// Returns `null` if the value is valid, otherwise an error message.
  /// Call validate() instead of this method when using the validator.
  String? validateValue(T valueCandidate);
}
