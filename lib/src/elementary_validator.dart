// ignore_for_file: always_specify_types

/// Interface class for elementary validators. It may be used to compose more
/// complex validators.
///
/// ## Generic types
/// - T: type of the input value, before any possible transformation. It should be more
/// generic or equal to W.
/// - W: type of the transformed value. It should be more specific or equal to T.
abstract base class BaseElementaryValidator<T extends Object?,
    W extends Object?> {
  /// Creates a new instance of the validator.
  const BaseElementaryValidator({
    String? errorText,
    this.and,
    this.otherwise,
  }) : _errorText = errorText;

  /// Backing field for [errorText].
  final String? _errorText;

  /// {@template base_validator_error_text}
  /// The error message returned if the value is invalid.
  /// {@endtemplate}
  String get errorText => _errorText ?? translatedErrorText;

  /// The translated error message returned if the value is invalid.
  String get translatedErrorText;

  /// Checks if [value] is valid and returns its transformed value if so.
  /// ## Return
  /// - a record of the form (isValid, transformedValue)
  (bool, W?) transformValueIfValid(T value);

  /// Validates the value.
  String? validate(T valueCandidate) {
    final (isValid, transformedValue) = transformValueIfValid(valueCandidate);
    if (isValid) {
      final completeErrorMsg = [];
      for (final validator in and ?? <BaseElementaryValidator<W, dynamic>>[]) {
        final validation = validator.validate(transformedValue as W);
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

    final completeErrorMsg = [_errorText];
    for (final validator
        in otherwise ?? <BaseElementaryValidator<T, dynamic>>[]) {
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
  final List<BaseElementaryValidator<W, dynamic>>? and;

  /// Allows adding OR composition with other validators.
  final List<BaseElementaryValidator<T, dynamic>>? otherwise;
}

/*
final class RequiredValidator<T extends Object>
    extends BaseElementaryValidator<T?, T> {
  const RequiredValidator({
    super.and,
    super.otherwise,
  });

  @override
  String get _errorText => 'Value is required.';

  @override
  (bool, T?) transformValueIfValid(T? value) {
    if (value != null &&
        (value is! String || value.trim().isNotEmpty) &&
        (value is! Iterable || value.isNotEmpty) &&
        (value is! Map || value.isNotEmpty)) {
      return (true, value);
    }
    return (false, null);
  }
}

final class NotRequiredValidator<T extends Object>
    extends BaseElementaryValidator<T?, T?> {
  const NotRequiredValidator({
    super.and,
    // in this case, the or is more restricted, thus, we need to restrict its
    // type in the constructor.
    List<BaseElementaryValidator<T, dynamic>>? otherwise,
  }) : super(otherwise: otherwise);

  @override
  String get _errorText => 'Value must not be provided.';

  @override
  (bool, T?) transformValueIfValid(T? value) {
    if (value == null ||
        (value is String && value.trim().isEmpty) ||
        (value is Iterable && value.isEmpty) ||
        (value is Map && value.isEmpty)) {
      return (true, value);
    }
    return (false, null);
  }
}

final class IsBool<T extends Object> extends BaseElementaryValidator<T, bool> {
  const IsBool({
    super.and,
    super.otherwise,
  });

  @override
  String get _errorText => 'Value must be true/false';

  @override
  (bool, bool?) transformValueIfValid(T value) {
    if (value is String) {
      final processedValue = value.trim().toLowerCase();

      switch (processedValue) {
        case 'true':
          return (true, true);
        case 'false':
          return (true, false);
      }
    }
    if (value is bool) {
      return (true, value);
    }
    return (false, null);
  }
}

final class IsInt<T extends Object> extends BaseElementaryValidator<T, int> {
  const IsInt({
    super.and,
    super.otherwise,
  });

  @override
  String get _errorText => 'Value must be int';

  @override
  (bool, int?) transformValueIfValid(T value) {
    if (value is String) {
      final intCandidateValue = int.tryParse(value);
      if (intCandidateValue != null) {
        return (true, intCandidateValue);
      }
    }
    if (value is int) {
      return (true, value);
    }
    return (false, null);
  }
}

final class IsLessThan<T extends num> extends BaseElementaryValidator<T, T> {
  const IsLessThan(
    this.reference, {
    super.and,
    super.otherwise,
  });
  final T reference;

  @override
  String get _errorText => 'Value must be less than $reference';

  @override
  (bool, T?) transformValueIfValid(T value) {
    final isValid = value < reference;
    return (isValid, isValid ? value : null);
  }
}

final class IsGreaterThan<T extends num> extends BaseElementaryValidator<T, T> {
  const IsGreaterThan(
    this.reference, {
    super.and,
    super.otherwise,
  });
  final T reference;

  @override
  String get _errorText => 'Value must be greater than $reference';

  @override
  (bool, T?) transformValueIfValid(T value) {
    final isValid = value > reference;
    return (isValid, isValid ? value : null);
  }
}

final class StringLengthLessThan
    extends BaseElementaryValidator<String, String> {
  const StringLengthLessThan({required this.referenceValue})
      : assert(referenceValue > 0);
  final int referenceValue;

  @override
  String get _errorText => 'Length must be less than $referenceValue';

  @override
  (bool, String?) transformValueIfValid(String value) {
    final isValid = value.length < referenceValue;
    return (isValid, isValid ? value : null);
  }
}
*/

/*
void main() {
  print('-------------New validation-------------------------');
  print('Enter the value: ');
  final value = stdin.readLineSync();

  const requiredIntLessThan10Validator = RequiredValidator(
    and: [
      IsInt(
        and: [IsLessThan(10)],
      ),
    ],
  );

  const requiredIntLessThan10OrGreaterThan13OrBool = RequiredValidator<String>(
    and: [
      IsInt(
        and: [
          IsGreaterThan(13, otherwise: [IsLessThan(10)])
        ],
      ),
      IsBool(),
    ],
  );

  const optionalDescriptionText = NotRequiredValidator(
    otherwise: [
      StringLengthLessThan(referenceValue: 10),
    ],
  );

  // this validator does not compile, because it does not make sense to compare
  // a bool with an integer
  /*
  const validator = RequiredValidator<String>(
    and: [
      IsInt(
        and: [
          IsBool(
            and: [IsGreaterThan(13)],
          )
        ],
      )
    ],
    otherwise: [
      IsInt(),
    ],
  );
  
   */
  final validation = optionalDescriptionText.validate(value);

  print(validation ?? 'Valid value!');
}

 */
