import 'package:formz/formz.dart';

enum _ShortTextValidationError { empty, tooShort, tooLong }

class ShortText extends FormzInput<String, _ShortTextValidationError> {
  static const int min = 6;
  static const int max = 20;

  const ShortText.pure() : super.pure('');
  const ShortText.dirty([super.value = '']) : super.dirty();

  @override
  _ShortTextValidationError? validator(String value) {
    if (value.isEmpty) return _ShortTextValidationError.empty;
    if (value.length < min) return _ShortTextValidationError.tooShort;
    if (value.length > max) return _ShortTextValidationError.tooLong;

    return null;
  }

  String? get errorMessage {
    switch (displayError) {
      case _ShortTextValidationError.empty:
        return 'This field is required';
      case _ShortTextValidationError.tooShort:
        return 'This field must be at least $min characters';
      case _ShortTextValidationError.tooLong:
        return 'This field must not exceed $max characters';
      default:
        return null;
    }
  }
}
