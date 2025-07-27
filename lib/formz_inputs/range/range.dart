import 'package:formz/formz.dart';

enum RangeValidationError { belowMin, aboveMax }

class Range extends FormzInput<int, RangeValidationError> {
  final int min = 2;
  final int max = 10;
  const Range.pure({int value = 2}) : super.pure(value);

  const Range.dirty(super.value) : super.dirty();

  @override
  RangeValidationError? validator(int value) {
    if (value < min) return RangeValidationError.belowMin;
    if (value > max) return RangeValidationError.aboveMax;
    return null;
  }

  String? get errorMessage {
    switch (displayError) {
      case RangeValidationError.belowMin:
        return 'Value must be at least $min';
      case RangeValidationError.aboveMax:
        return 'Value must not exceed $max';
      default:
        return null;
    }
  }
}
