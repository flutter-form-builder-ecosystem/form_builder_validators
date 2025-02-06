import 'package:flutter/widgets.dart';

import '../constants.dart';

/// {@macro validator_debug_print_validator}
Validator<T> debugPrintValidator<T extends Object?>(
    {Validator<T>? next, String Function(T)? logOnInput}) {
  return (T value) {
    debugPrint(logOnInput?.call(value) ?? value.toString());
    return next?.call(value);
  };
}
