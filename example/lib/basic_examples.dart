import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart'
    show Validators;

/// Basic examples involving only one validator per example
class BasicExamplesPage extends StatelessWidget {
  /// Constructs a new instance of the [BasicExamplesPage] class.
  const BasicExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Basic Examples (one validator per example)')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Core validators
              Text(
                'Core Validators',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Equality Validators',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText:
                        'Type "I want to delete" to confirm the action.'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.isEqual('I want to delete'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Username (should not be "RESERVED")'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.isNotEqual('RESERVED'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Required Error Message',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Input must not be null'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? input) {
                  final String? isRequiredMsg = Validators.isRequired()(input);
                  return isRequiredMsg
                      ?.toUpperCase()
                      .replaceFirst('OVERRIDE: ', '');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
