import 'package:formz/formz.dart';

enum ShortTextValidationError { empty, tooShort, tooLong }

class ShortText extends FormzInput<String, ShortTextValidationError> {
  static const int min = 6;
  static const int max = 20;

  const ShortText.pure() : super.pure('');
  const ShortText.dirty([super.value = '']) : super.dirty();

  @override
  ShortTextValidationError? validator(String value) {
    if (value.isEmpty) return ShortTextValidationError.empty;
    if (value.length < min) return ShortTextValidationError.tooShort;
    if (value.length > max) return ShortTextValidationError.tooLong;

    return null;
  }

  String? get errorMessage {
    switch (displayError) {
      case ShortTextValidationError.empty:
        return 'This field is required';
      case ShortTextValidationError.tooShort:
        return 'This field must be at least $min characters';
      case ShortTextValidationError.tooLong:
        return 'This field must not exceed $max characters';
      default:
        return null;
    }
  }
}
