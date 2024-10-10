import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../localization/intl/app_localizations.dart';

final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Static vs Dynamic - Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const _HomePage(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        ...GlobalMaterialLocalizations.delegates,
        // Placed in front of `FormBuilderLocalizations.delegate`
        ...AppLocalizations.localizationsDelegates,
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  int referenceValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Static vs Dynamic - Example (all the fields check if the input is equal to $referenceValue)')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    onPressed: () => setState(() {
                          referenceValue--;
                        }),
                    icon: const Icon(Icons.remove)),
                Text(referenceValue.toString()),
                IconButton(
                    onPressed: () => setState(() {
                          referenceValue++;
                        }),
                    icon: const Icon(Icons.add)),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('With flutter TextFormField:'),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'isEqual (static)'),
                      autovalidateMode: AutovalidateMode.always,
                      validator: isRequired(isInt(isEqual(referenceValue))),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'isEqual (dynamic)'),
                      autovalidateMode: AutovalidateMode.always,
                      validator: isRequired(
                          isInt(isEqual(null, dynValue: () => referenceValue))),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'isEqual (old API)'),
                      autovalidateMode: AutovalidateMode.always,
                      validator: FormBuilderValidators.equal(
                          referenceValue.toString()),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                        'With flutter_form_builder outside a FormBuilder:'),
                    FormBuilderTextField(
                      name: 'isEqual (static)',
                      autovalidateMode: AutovalidateMode.always,
                      decoration:
                          const InputDecoration(labelText: 'isEqual (static)'),
                      validator: isRequired(isInt(isEqual(referenceValue))),
                    ),
                    const SizedBox(height: 5),
                    FormBuilderTextField(
                      name: 'isEqual (dynamic)',
                      autovalidateMode: AutovalidateMode.always,
                      decoration:
                          const InputDecoration(labelText: 'isEqual (dynamic)'),
                      validator: isRequired(
                          isInt(isEqual(null, dynValue: () => referenceValue))),
                    ),
                    const SizedBox(height: 5),
                    FormBuilderTextField(
                      name: 'isEqual (old API)',
                      autovalidateMode: AutovalidateMode.always,
                      decoration:
                          const InputDecoration(labelText: 'isEqual (old API)'),
                      validator: FormBuilderValidators.equal(
                          referenceValue.toString()),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                        'With flutter_form_builder inside a FormBuilder:'),
                    FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            name: 'isEqual (static)',
                            decoration: const InputDecoration(
                                labelText: 'isEqual (static)'),
                            validator:
                                isRequired(isInt(isEqual(referenceValue))),
                          ),
                          const SizedBox(height: 5),
                          FormBuilderTextField(
                            name: 'isEqual (dynamic)',
                            decoration: const InputDecoration(
                                labelText: 'isEqual (dynamic)'),
                            validator: isRequired(isInt(
                                isEqual(null, dynValue: () => referenceValue))),
                          ),
                          const SizedBox(height: 5),
                          FormBuilderTextField(
                            name: 'isEqual (old API)',
                            decoration: const InputDecoration(
                                labelText: 'isEqual (old API)'),
                            validator: FormBuilderValidators.equal(
                                referenceValue.toString()),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
