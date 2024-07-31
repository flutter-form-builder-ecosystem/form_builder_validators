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
    this.or,
  });
  String get errorMsg;

  /// Checks if [value] is valid and returns its transformed value if so.
  /// ## Return: a record of the form (isValid, transformedValue)
  (bool, W?) transformValueIfValid(T value);

  String? validate(T value) {
    final (isValid, transformedValue) = transformValueIfValid(value);
    if (isValid) {
      return and?.validate(transformedValue as W);
    }

    for (final validator
        in or ?? <ElementaryValidatorInterface<T, dynamic>>[]) {
      if (validator.validate(value) == null) {
        return null;
      }
    }
    return errorMsg;
  }

  // Here we make the restrictions weaker. But we will get them strong when
  // overriding those getters.
  final ElementaryValidatorInterface<W, dynamic>? and;
  final List<ElementaryValidatorInterface<T, dynamic>>? or;
}

final class RequiredValidator<T extends Object>
    extends ElementaryValidatorInterface<T?, T> {
  const RequiredValidator({
    super.and,
    super.or,
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

final class IsBool<T extends Object>
    extends ElementaryValidatorInterface<T, bool> {
  const IsBool({
    super.and,
    super.or,
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
    super.or,
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

final class IsGreaterThan<T extends num>
    extends ElementaryValidatorInterface<T, T> {
  const IsGreaterThan(
    this.reference, {
    super.and,
    super.or,
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

void main() {
  print('-------------New validation-------------------------');
  print('Enter the value: ');
  final value = stdin.readLineSync();
  const validator = RequiredValidator<String>(
    and: IsInt(
      and: IsGreaterThan(13),
    ),
  );

  /*
  // this validator does not compile, because it does not make sense to compare
  // a bool with an integer
  const validator = RequiredValidator<String>(
    and: IsInt(
      and: IsBool(
        and: IsGreaterThan(13),
      ),
    ),
    or: [
      IsInt(),
    ],
  );
  */
  final validation = validator.validate(value);

  print(validation ?? 'Valid value!');
}
