import '../constants.dart';

String errorTransformAndValidateTemporary<T>(
    T userInput, String? transformedResultTypeDescription) {
  if (transformedResultTypeDescription != null) {
    // An example, it will print the error message: "Hello" is not a valid integer.
    return '"${userInput.toString()}" is not a valid $transformedResultTypeDescription';
  }

  return '"${userInput.toString()}" is not able to be transformed.';
}

/// This function returns a validator which transforms the user input.
/// If the transformation fails, it returns a transformation error message.
/// Otherwise, it passes the input to the `next` validator, if it was provided,
/// or, if `next` was not provided, it returns `null`.
///
/// # Parameters
/// - `String?` `transformedResultTypeDescription`: This parameter helps improving
/// the readability of the error message. If provided, the error message can
/// specify what is the expected type/result of the transformation. For example,
/// if 'positive integer' is provided, it can return a message like:
/// '"hello" is not a valid positive integer'. Otherwise, if this parameter is
/// not provided, the default error message will be more generic.
/// - `String` `Function(IN)?` `transformAndValidateMsg`: this is the custom message
/// for the validation error message. It is a function that receives the user
/// input as argument and returns a String, the error message.
///
/// # Transformation
/// This process transforms the user input from the type `IN` to the type `OUT`.
/// Its failure is considered a validation failure, and, when it happens, a
/// validation failure message is returned.
///
/// # Example
/// ```dart
///
/// ```
Validator<IN> transformAndValidate<IN extends Object?, OUT extends Object?>(
  OUT Function(IN) transformFunction, {
  Validator<OUT>? next,
  String Function(IN)? transformAndValidateMsg,
  String? transformedResultTypeDescription,
}) {
  return (IN input) {
    try {
      final OUT transformedValue = transformFunction(input);
      return next?.call(transformedValue);
    } catch (_) {
      return transformAndValidateMsg?.call(input) ??
          errorTransformAndValidateTemporary(
              input.toString(), transformedResultTypeDescription);
    }
  };
}
