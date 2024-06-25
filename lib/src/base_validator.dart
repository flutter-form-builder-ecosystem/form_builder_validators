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
  String get errorText => _errorText ?? translatedErrorText;

  /// The translated error message returned if the value is invalid.
  String get translatedErrorText;

  /// {@template base_validator_null_check}
  /// Whether to check if the value is null or empty.
  /// {@endtemplate}
  final bool checkNullOrEmpty;

  /// Validates the value and checks if it is null or empty.
  String? validate(T? valueCandidate) {
    if (checkNullOrEmpty && isNullOrEmpty(valueCandidate)) {
      return errorText;
    }
    return validateValue(valueCandidate);
  }

  /// Checks if the value is null or empty.
  /// Returns `true` if the value is null or empty, otherwise `false`.
  /// The value is considered empty if it is a [String], [Iterable], or [Map]
  /// and it is empty or contains only whitespace characters.
  /// If the value is not a [String], [Iterable], or [Map], it is considered
  /// empty if it is `null`.
  bool isNullOrEmpty(T? valueCandidate) {
    return valueCandidate == null ||
        (valueCandidate is String && valueCandidate.trim().isEmpty) ||
        (valueCandidate is Iterable && valueCandidate.isEmpty) ||
        (valueCandidate is Map && valueCandidate.isEmpty);
  }

  /// Validates the value.
  /// Returns `null` if the value is valid, otherwise an error message.
  String? validateValue(T? valueCandidate);
}
