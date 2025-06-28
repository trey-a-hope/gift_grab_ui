import 'package:formz/formz.dart';

enum _LongTextValidationError { empty, tooShort, tooLong }

class LongText extends FormzInput<String, _LongTextValidationError> {
  static const int min = 10;
  static const int max = 100;
  static const int maxLines = 3;
  static const int minLines = 2;

  const LongText.pure() : super.pure('');
  const LongText.dirty([super.value = '']) : super.dirty();

  @override
  _LongTextValidationError? validator(String value) {
    if (value.isEmpty) return _LongTextValidationError.empty;
    if (value.length < min) return _LongTextValidationError.tooShort;
    if (value.length > max) return _LongTextValidationError.tooLong;
    return null;
  }

  String? get errorMessage {
    switch (displayError) {
      case _LongTextValidationError.empty:
        return 'This field is required';
      case _LongTextValidationError.tooShort:
        return 'This field must be at least $min characters';
      case _LongTextValidationError.tooLong:
        return 'This field must not exceed $max characters';
      default:
        return null;
    }
  }
}
