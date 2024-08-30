import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/new_api_prototype.dart'
    show req, password;

import 'package:flutter/material.dart';
// ignore_for_file: public_member_api_docs

class ReqPasswordBenchmark extends BenchmarkBase {
  const ReqPasswordBenchmark() : super("ReqPasswordBenchmark");
  static void main() {
    const ReqPasswordBenchmark().report();
  }

  @override
  void run() {
    final FormFieldValidator<String> v = req(password());
    v('h');
    v('he');
    v('hel');
    v('hell');
    v('hello');
    v('hello ');
    v('hello W');
    v('hello Wo');
    v('hello Wor');
    v('hello Worl');
    v('hello World');
    v('hello World!');
    v('hello World!1');
    v('hello World!12');
    v('hello World!123');
  }
}

// Benchmark for FormFieldValidators.password()
class FormFieldValidatorsPasswordBenchmark extends BenchmarkBase {
  const FormFieldValidatorsPasswordBenchmark()
      : super("FormFieldValidatorsPasswordBenchmark");

  static void main() {
    const FormFieldValidatorsPasswordBenchmark().report();
  }

  @override
  void run() {
    // create the validator
    final FormFieldValidator<String> v = FormBuilderValidators.password();
    v('h');
    v('he');
    v('hel');
    v('hell');
    v('hello');
    v('hello ');
    v('hello W');
    v('hello Wo');
    v('hello Wor');
    v('hello Worl');
    v('hello World');
    v('hello World!');
    v('hello World!1');
    v('hello World!12');
    v('hello World!123');
  }
}

void main() {
  // Running the benchmarks
  print('executing benchmark');
  var i = 0;
  while (i < 10) {
    ReqPasswordBenchmark.main();
    FormFieldValidatorsPasswordBenchmark.main();
    i++;
  }

  print('Finishing app');
  return;
  /*
  runApp(MaterialApp(
    home: Placeholder(),
  ));
   */
}
