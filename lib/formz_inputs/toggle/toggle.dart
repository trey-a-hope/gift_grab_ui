import 'package:formz/formz.dart';

class Toggle extends FormzInput<bool, void> {
  const Toggle.pure() : super.pure(false);
  const Toggle.dirty([super.value = false]) : super.dirty();

  @override
  void validator(bool value) => {};
}
