import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  // ===== checkNullOrEmpty: false cases (Validators.optional) =====

  // F1: checkNullOrEmpty:false + atLeast + errorText + regex
  FormBuilderValidators.hasLowercaseChars(
    atLeast: 3,
    errorText: 'Need 3',
    regex: RegExp(r'[a-z]'),
    checkNullOrEmpty: false,
  );

  // F2: checkNullOrEmpty:false + atLeast + errorText
  FormBuilderValidators.hasLowercaseChars(
    atLeast: 2,
    errorText: 'Need 2',
    checkNullOrEmpty: false,
  );

  // F3: checkNullOrEmpty:false + atLeast + regex
  FormBuilderValidators.hasLowercaseChars(
    atLeast: 4,
    regex: RegExp(r'[a-z]'),
    checkNullOrEmpty: false,
  );

  // F4: checkNullOrEmpty:false + errorText + regex
  FormBuilderValidators.hasLowercaseChars(
    errorText: 'Error',
    regex: RegExp(r'[a-z]'),
    checkNullOrEmpty: false,
  );

  // F5: checkNullOrEmpty:false + atLeast
  FormBuilderValidators.hasLowercaseChars(atLeast: 5, checkNullOrEmpty: false);

  // F6: checkNullOrEmpty:false + errorText
  FormBuilderValidators.hasLowercaseChars(
    errorText: 'Must have lowercase',
    checkNullOrEmpty: false,
  );

  // F7: checkNullOrEmpty:false + regex
  FormBuilderValidators.hasLowercaseChars(
    regex: RegExp(r'[a-z]'),
    checkNullOrEmpty: false,
  );

  // F8: checkNullOrEmpty:false only
  FormBuilderValidators.hasLowercaseChars(checkNullOrEmpty: false);

  // ===== checkNullOrEmpty: true cases (Validators.required) =====

  // T1: checkNullOrEmpty:true + atLeast + errorText + regex
  FormBuilderValidators.hasLowercaseChars(
    atLeast: 3,
    errorText: 'Need 3',
    regex: RegExp(r'[a-z]'),
    checkNullOrEmpty: true,
  );

  // T2: checkNullOrEmpty:true + atLeast + errorText
  FormBuilderValidators.hasLowercaseChars(
    atLeast: 2,
    errorText: 'Need 2',
    checkNullOrEmpty: true,
  );

  // T3: checkNullOrEmpty:true + atLeast + regex
  FormBuilderValidators.hasLowercaseChars(
    atLeast: 4,
    regex: RegExp(r'[a-z]'),
    checkNullOrEmpty: true,
  );

  // T4: checkNullOrEmpty:true + errorText + regex
  FormBuilderValidators.hasLowercaseChars(
    errorText: 'Error',
    regex: RegExp(r'[a-z]'),
    checkNullOrEmpty: true,
  );

  // T5: checkNullOrEmpty:true + atLeast
  FormBuilderValidators.hasLowercaseChars(atLeast: 5, checkNullOrEmpty: true);

  // T6: checkNullOrEmpty:true + errorText
  FormBuilderValidators.hasLowercaseChars(
    errorText: 'Must have lowercase',
    checkNullOrEmpty: true,
  );

  // T7: checkNullOrEmpty:true + regex
  FormBuilderValidators.hasLowercaseChars(
    regex: RegExp(r'[a-z]'),
    checkNullOrEmpty: true,
  );

  // T8: checkNullOrEmpty:true only
  FormBuilderValidators.hasLowercaseChars(checkNullOrEmpty: true);

  // ===== Default cases (checkNullOrEmpty not provided = true) =====

  // D1: atLeast + errorText + regex
  FormBuilderValidators.hasLowercaseChars(
    atLeast: 3,
    errorText: 'Need 3',
    regex: RegExp(r'[a-z]'),
  );

  // D2: atLeast + errorText
  FormBuilderValidators.hasLowercaseChars(atLeast: 2, errorText: 'Need 2');

  // D3: atLeast + regex
  FormBuilderValidators.hasLowercaseChars(atLeast: 4, regex: RegExp(r'[a-z]'));

  // D4: errorText + regex
  FormBuilderValidators.hasLowercaseChars(
    errorText: 'Error',
    regex: RegExp(r'[a-z]'),
  );

  // D5: Only atLeast
  FormBuilderValidators.hasLowercaseChars(atLeast: 5);

  // D6: Only errorText
  FormBuilderValidators.hasLowercaseChars(errorText: 'Must have lowercase');

  // D7: Only regex
  FormBuilderValidators.hasLowercaseChars(regex: RegExp(r'[a-z]'));

  // D8: No parameters
  FormBuilderValidators.hasLowercaseChars();

  // ===== Real-world usage examples =====

  // Used in TextFormField
  TextFormField(
    decoration: const InputDecoration(labelText: 'Password'),
    validator: FormBuilderValidators.hasLowercaseChars(
      atLeast: 2,
      errorText: 'Password needs at least 2 lowercase letters',
    ),
  );

  // Used in Form with optional field
  Form(
    child: TextFormField(
      decoration: const InputDecoration(labelText: 'Nickname (optional)'),
      validator: FormBuilderValidators.hasLowercaseChars(
        checkNullOrEmpty: false,
        errorText: 'If provided, must have lowercase',
      ),
    ),
  );

  // Assigned to variable
  final passwordValidator = FormBuilderValidators.hasLowercaseChars(
    atLeast: 3,
    regex: RegExp(r'[a-z]'),
    errorText: 'Need 3 lowercase',
  );
}
