import 'package:formz/formz.dart';

enum _RangeValidationError { belowMin, aboveMax }

class Range extends FormzInput<int, _RangeValidationError> {
  final int min = 2;
  final int max = 10;
  const Range.pure({int value = 2}) : super.pure(value);

  const Range.dirty(int value) : super.dirty(value);

  @override
  _RangeValidationError? validator(int value) {
    if (value < min) return _RangeValidationError.belowMin;
    if (value > max) return _RangeValidationError.aboveMax;
    return null;
  }

  String? get errorMessage {
    switch (displayError) {
      case _RangeValidationError.belowMin:
        return 'Value must be at least $min';
      case _RangeValidationError.aboveMax:
        return 'Value must not exceed $max';
      default:
        return null;
    }
  }
}
