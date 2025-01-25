import '../../localization/l10n.dart';
import 'constants.dart';

/// {@macro validator_min_length}
Validator<T> minLength<T extends Object>(int min,
    {String Function(T input, int min)? minLengthMsg}) {
  if (min < 0) {
    throw ArgumentError.value(min, 'min', 'This argument may not be negative');
  }
  return (T input) {
    int valueLength;
    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    } else {
      throw ArgumentError.value(
        input,
        'input',
        'Input must be a collection (String, Iterable, or Map). Received type "${input.runtimeType}"',
      );
    }
    return valueLength < min
        ? minLengthMsg?.call(input, min) ??
            FormBuilderLocalizations.current.minLengthErrorText(min)
        : null;
  };
}

/// {@macro validator_max_length}
Validator<T> maxLength<T extends Object>(int max,
    {String Function(T input, int max)? maxLengthMsg}) {
  if (max < 0) {
    throw ArgumentError.value(max, 'max', 'This argument may not be negative');
  }
  return (T input) {
    int valueLength;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    } else {
      throw ArgumentError.value(
        input,
        'input',
        'Input must be a collection (String, Iterable, or Map). Received type "${input.runtimeType}"',
      );
    }

    return valueLength > max
        ? maxLengthMsg?.call(input, max) ??
            FormBuilderLocalizations.current.maxLengthErrorText(max)
        : null;
  };
}

/// {@macro validator_between_length}
Validator<T> betweenLength<T extends Object>(
  int min,
  int max, {
  String Function(T input, {required int min, required int max})?
      betweenLengthMsg,
}) {
  if (min < 0) {
    throw ArgumentError.value(min, 'min', 'This argument may not be negative');
  }
  if (max < min) {
    throw ArgumentError.value(
      max,
      'max',
      'This argument must be greater than or equal to "min" length ($min)',
    );
  }
  return (T input) {
    int valueLength;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    } else {
      throw ArgumentError.value(
        input,
        'input',
        'Input must be a collection (String, Iterable, or Map). Received type "${input.runtimeType}"',
      );
    }
    return (valueLength < min || valueLength > max)
        ? betweenLengthMsg?.call(input, min: min, max: max) ??
            FormBuilderLocalizations.current.betweenLengthErrorText(min, max)
        : null;
  };
}

/// {@macro validator_equal_length}
Validator<T> equalLength<T extends Object>(int expectedLength,
    {String Function(T input, int expectedLength)? equalLengthMsg}) {
  if (expectedLength < 0) {
    throw ArgumentError.value(
        expectedLength, 'expectedLength', 'This argument may not be negative');
  }

  return (T input) {
    int valueLength;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    } else {
      throw ArgumentError.value(
        input,
        'input',
        'Input must be a collection (String, Iterable, or Map). Received type "${input.runtimeType}"',
      );
    }

    return valueLength != expectedLength
        ? equalLengthMsg?.call(input, expectedLength) ??
            FormBuilderLocalizations.current
                .equalLengthErrorText(expectedLength)
        : null;
  };
}
