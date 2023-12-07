// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:equatable/equatable.dart';

class Counter extends Equatable {
  int value;

  Counter({
    this.value = 0,
  });

  increment() {
    if (value < 10) {
      value++;
    }
  }

  decrement() {
    if (value > 0) {
      value--;
    }
  }

  @override
  List<Object?> get props => [value];
}
