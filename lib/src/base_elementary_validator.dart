// ignore_for_file: always_specify_types

/// Interface class for elementary validators. It may be used to compose more
/// complex validators.
///
/// ## Generic types
/// - T: type of the input value, before any possible transformation. It should be more
/// generic or equal to W.
/// - W: type of the transformed value. It should be more specific or equal to T.
abstract base class BaseElementaryValidator<IN extends Object?,
    OUT extends Object?> {
  /// Creates a new instance of the validator.
  const BaseElementaryValidator({
    required this.ignoreErrorMessage,
    String? errorText,
    // this * (a1 * a2 * ... * an) --> this is a helper one (it is not necessary, but it makes things easier
    this.withAndComposition,
    // this * (b1 + b2 + ... + bn) -> this * b1 + this * b2 + ... + this * bn
    this.withOrComposition,
    // !this * (c1 + c2 + ... + cn)
    this.otherwise,
  }) : _errorText = errorText;
  // The result is:
  // this*(a1*a2*...*an)*(b1 + b2 + ... + bn) + !this * (c1 + c2 + ... + cn)

  /// Backing field for [errorText].
  final String? _errorText;

  /// Whether the [errorText] of the current validator is ignored. It allows
  /// nested error messages to be used instead. If there is no inner error
  /// message, an empty String is used instead.
  final bool ignoreErrorMessage;

  /// {@template base_validator_error_text}
  /// The error message returned if the value is invalid.
  /// {@endtemplate}
  String get errorText => _errorText ?? translatedErrorText;

  /// The translated error message returned if the value is invalid.
  String get translatedErrorText;

  /// Checks if [value] is valid and returns its transformed value if so.
  /// ## Return
  /// - a record of the form (isValid, transformedValue)
  (bool, OUT?) transformValueIfValid(IN value);

  /// Validates the value.
  //TODO (ArturAssisComp): refactor this method
  String? validate(IN valueCandidate) {
    final (isValid, transformedValue) = transformValueIfValid(valueCandidate);
    if (isValid) {
      final completeErrorMsg = [];
      for (final validator
          in withAndComposition ?? <BaseElementaryValidator<OUT, dynamic>>[]) {
        final validation = validator.validate(transformedValue as OUT);
        if (validation != null) {
          completeErrorMsg.add(validation);
        }
      }
      if (completeErrorMsg.isEmpty) {
        // compute with or composition
        for (final validator
            in withOrComposition ?? <BaseElementaryValidator<OUT, dynamic>>[]) {
          final validation = validator.validate(transformedValue as OUT);
          if (validation == null) {
            return null;
          }
          completeErrorMsg.add(validation);
        }
        if (completeErrorMsg.isEmpty) {
          return null;
        }
        return completeErrorMsg.join(' or ');
      }
      return completeErrorMsg.join(' and ');
    }

    final completeErrorMsg = [];
    if (ignoreErrorMessage) {
      final andMessage = [];
      for (final validator
          in withAndComposition ?? <BaseElementaryValidator<OUT, dynamic>>[]) {
        andMessage.add(validator.errorText);
      }
      if (andMessage.isNotEmpty) {
        completeErrorMsg.add(andMessage.join(' and '));
      } else {
        final orMessage = [];
        // compute with or composition
        for (final validator
            in withOrComposition ?? <BaseElementaryValidator<OUT, dynamic>>[]) {
          orMessage.add(validator.errorText);
        }
        if (completeErrorMsg.isNotEmpty) {
          completeErrorMsg.add(orMessage.join(' or '));
        }
      }
    } else {
      completeErrorMsg.add(errorText);
    }
    for (final validator
        in otherwise ?? <BaseElementaryValidator<IN, dynamic>>[]) {
      final validation = validator.validate(valueCandidate);
      if (validation == null) {
        return null;
      }
      completeErrorMsg.add(validation);
    }
    return completeErrorMsg.join(' or ');
  }

  // Here we make the restrictions weaker. But we will get them strong when
  // overriding those getters.
  /// Allows adding AND composition with other validators.
  final List<BaseElementaryValidator<OUT, dynamic>>? withAndComposition;

  /// Allows adding OR composition with other validators making the api easier
  /// to use.
  final List<BaseElementaryValidator<OUT, dynamic>>? withOrComposition;

  /// Allows adding OTHERWISE composition with other validators.
  final List<BaseElementaryValidator<IN, dynamic>>? otherwise;
}
