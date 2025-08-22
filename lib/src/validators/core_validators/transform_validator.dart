import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@macro validator_transform_and_validate}
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
                      transformedResultTypeDescription,
                    ));
    }
  };
}
