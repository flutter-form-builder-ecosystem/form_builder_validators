import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@template validator_transform_and_validate}
/// Creates a validator that transforms user input and optionally chains with the `next` validator.
/// This validator attempts to transform the input using the provided transformation function.
/// If the transformation succeeds, it either returns null or passes the transformed value
/// to the next validator in the chain. If the transformation fails, it returns an error message.
///
/// The validator is particularly useful for type conversions and data transformations where
/// the transformation itself serves as a validation step. For example, converting string
/// input to numbers or dates where invalid formats should be treated as validation failures.
///
/// ## Type Parameters
/// - `IN`: The input type to be transformed. Must be nullable or non-nullable Object.
/// - `OUT`: The output type after transformation. Must be nullable or non-nullable Object.
///
/// ## Parameters
/// - `transformFunction` (`OUT Function(IN)`): The function that performs the actual
///   transformation from type `IN` to type `OUT`. This function should throw an exception
///   if the transformation cannot be performed.
/// - `next` (`Validator<OUT>?`): Optional validator to process the transformed value.
///   If provided, its result will be returned when transformation succeeds.
/// - `transformAndValidateMsg` (`String Function(IN)?`): Optional function that generates
///   a custom error message when transformation fails. Receives the original input as
///   an argument.
/// - `transformedResultTypeDescription` (`String?`): Optional description of the expected
///   transformed type, used to generate more readable error messages. For example,
///   "positive integer" would result in messages like 'Value is not a valid positive integer'.
///
/// ## Returns
/// Returns a `Validator<IN>` function that:
/// - Returns `null` if transformation succeeds and no `next` validator is provided
/// - Returns the result of the `next` validator if transformation succeeds and a `next`
///   validator is provided
/// - Returns an error message string if transformation fails
///
/// ## Examples
/// ```dart
/// // Creating a validator that converts strings to ArithmeticExpression:
/// final arithmeticExprValidator = transformAndValidate<String, ArithmeticExpression>(
///   parseToArithmeticExpression,
///   transformedResultTypeDescription: 'arithmetic expression',
/// );
///
/// // Example usage:
/// final validator = arithmeticExprValidator;
/// print(validator('2+3')); // null (valid)
/// print(validator('2+Hello World+3')); // "Value is not a valid arithmetic expression"
/// print(validator('1+2+3+4+5+6+7+8+9+10')); // null (valid)
/// ```
/// {@endtemplate}
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
          (transformedResultTypeDescription == null
              ? FormBuilderLocalizations.current.transformAndValidateErrorTextV1
              : FormBuilderLocalizations.current
                  .transformAndValidateErrorTextV2(
                      transformedResultTypeDescription));
    }
  };
}
