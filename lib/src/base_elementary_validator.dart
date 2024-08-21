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
