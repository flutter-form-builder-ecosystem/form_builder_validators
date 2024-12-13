import 'package:flutter/widgets.dart';

import '../constants.dart';

/// Each time the user provides an `input`, this validator prints its [String]
/// representation to `stdout` for debugging purposes.
///
/// The logging message can be customized providing the `logOnInput` parameter.
///
/// If the validator `next` is provided, it redirects user's input to it, returning
/// its result. Otherwise, it never fails, thus, always returning `null`.
Validator<T> debugPrintValidator<T extends Object?>(
    {Validator<T>? next, String Function(T)? logOnInput}) {
  return (T value) {
    debugPrint(logOnInput?.call(value) ?? value.toString());
    return next?.call(value);
  };
}
