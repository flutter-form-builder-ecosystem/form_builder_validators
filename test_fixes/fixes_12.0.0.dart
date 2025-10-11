import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// Basic examples involving only one validator per example
class BasicExamplesPage extends StatelessWidget {
  /// Constructs a new instance of the [BasicExamplesPage] class.
  const BasicExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Examples (one validator per example)'),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            validator: FormBuilderValidators.equal('-', checkNullOrEmpty: true),
          ),
          TextFormField(validator: FormBuilderValidators.equal('-')),
          TextFormField(validator: FormBuilderValidators.notEqual('-')),
          TextFormField(
            validator: FormBuilderValidators.equal(
              'test',
              checkNullOrEmpty: false,
            ),
          ),
          TextFormField(
            validator: FormBuilderValidators.notEqual(
              'test',
              checkNullOrEmpty: false,
            ),
          ),
          TextFormField(
            validator: FormBuilderValidators.required(checkNullOrEmpty: true),
          ),
          TextFormField(
            validator: FormBuilderValidators.required(checkNullOrEmpty: false),
          ),
          TextFormField(
            validator: FormBuilderValidators.email(checkNullOrEmpty: true),
          ),
          TextFormField(
            validator: FormBuilderValidators.email(checkNullOrEmpty: false),
          ),
          TextFormField(
            validator: (String? input) {
              final String? isRequiredMsg = FormBuilderValidators.required()(
                input,
              );
              return isRequiredMsg?.toUpperCase().replaceFirst(
                'OVERRIDE: ',
                '',
              );
            },
          ),
        ],
      ),
    );
  }
}
