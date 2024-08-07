import 'dart:io';

// ignore_for_file: public_member_api_docs, always_specify_types

/// ## Generic types
/// - T: type of the input value, before any possible transformation. It should be more
/// generic or equal to W.
/// - W: type of the transformed value. It should be more specific or equal to T.
abstract base class ElementaryValidatorInterface<T extends Object?,
    W extends Object?> {
  const ElementaryValidatorInterface({
    this.and,
    this.otherwise,
  });
  String get errorMsg;

  /// Checks if [value] is valid and returns its transformed value if so.
  /// ## Return: a record of the form (isValid, transformedValue)
  (bool, W?) transformValueIfValid(T value);

  String? validate(T value) {
    final (isValid, transformedValue) = transformValueIfValid(value);
    if (isValid) {
      final completeErrorMsg = [];
      for (final validator
          in and ?? <ElementaryValidatorInterface<W, dynamic>>[]) {
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

    final completeErrorMsg = [errorMsg];
    for (final validator
        in otherwise ?? <ElementaryValidatorInterface<T, dynamic>>[]) {
      final validation = validator.validate(value);
      if (validation == null) {
        return null;
      }
      completeErrorMsg.add(validation);
    }
    return completeErrorMsg.join(' or ');
  }

  // Here we make the restrictions weaker. But we will get them strong when
  // overriding those getters.
  final List<ElementaryValidatorInterface<W, dynamic>>? and;
  final List<ElementaryValidatorInterface<T, dynamic>>? otherwise;
}

final class RequiredValidator<T extends Object>
    extends ElementaryValidatorInterface<T?, T> {
  const RequiredValidator({
    super.and,
    super.otherwise,
  });

  @override
  String get errorMsg => 'Value is required.';

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
    extends ElementaryValidatorInterface<T?, T?> {
  const NotRequiredValidator({
    super.and,
    // in this case, the or is more restricted, thus, we need to restrict its
    // type in the constructor.
    List<ElementaryValidatorInterface<T, dynamic>>? otherwise,
  }) : super(otherwise: otherwise);

  @override
  String get errorMsg => 'Value must not be provided.';

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

final class IsBool<T extends Object>
    extends ElementaryValidatorInterface<T, bool> {
  const IsBool({
    super.and,
    super.otherwise,
  });

  @override
  String get errorMsg => 'Value must be true/false';

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

final class IsInt<T extends Object>
    extends ElementaryValidatorInterface<T, int> {
  const IsInt({
    super.and,
    super.otherwise,
  });

  @override
  String get errorMsg => 'Value must be int';

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

final class IsLessThan<T extends num>
    extends ElementaryValidatorInterface<T, T> {
  const IsLessThan(
    this.reference, {
    super.and,
    super.otherwise,
  });
  final T reference;

  @override
  String get errorMsg => 'Value must be less than $reference';

  @override
  (bool, T?) transformValueIfValid(T value) {
    final isValid = value < reference;
    return (isValid, isValid ? value : null);
  }
}

final class IsGreaterThan<T extends num>
    extends ElementaryValidatorInterface<T, T> {
  const IsGreaterThan(
    this.reference, {
    super.and,
    super.otherwise,
  });
  final T reference;

  @override
  String get errorMsg => 'Value must be greater than $reference';

  @override
  (bool, T?) transformValueIfValid(T value) {
    final isValid = value > reference;
    return (isValid, isValid ? value : null);
  }
}

final class StringLengthLessThan
    extends ElementaryValidatorInterface<String, String> {
  const StringLengthLessThan({required this.referenceValue})
      : assert(referenceValue > 0);
  final int referenceValue;

  @override
  String get errorMsg => 'Length must be less than $referenceValue';

  @override
  (bool, String?) transformValueIfValid(String value) {
    final isValid = value.length < referenceValue;
    return (isValid, isValid ? value : null);
  }
}

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
