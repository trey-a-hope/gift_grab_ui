import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class ModalUtil {
  static Future<(String, String)?> showEmailPasswordDialog({
    required BuildContext context,
  }) async {
    return showDialog<(String, String)?>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: EmailPasswordInputWidget(
          onSubmit: (email, password) {
            context.pop((email, password));
          },
          onCancel: () {
            context.pop(null);
          },
        ),
      ),
    );
  }

  static void showSuccess({required String title}) {
    _showToast(
      title: title,
      toastificationType: ToastificationType.success,
      icon: const Icon(Icons.check),
      primaryColor: Colors.green,
    );
  }

  static void showError({required String title}) {
    _showToast(
      title: title,
      toastificationType: ToastificationType.error,
      icon: const Icon(Icons.error),
      primaryColor: Colors.red,
    );
  }

  /// Shows a brief, customizable toast.
  static void _showToast({
    required String title,
    required ToastificationType toastificationType,
    required Widget icon,
    required MaterialColor primaryColor,
  }) {
    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(title),
      type: toastificationType,
      style: ToastificationStyle.fillColored,
      icon: icon,
      primaryColor: primaryColor,
      backgroundColor: primaryColor.shade100,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: false,
      closeButton: ToastCloseButton(showType: CloseButtonShowType.onHover),
      closeOnClick: true,
    );
  }

  static Future<bool?> showInputMatchConfirmation({
    required BuildContext context,
    required String title,
    required String hintText,
    required String match,
  }) => showDialog<bool>(
    useRootNavigator: false,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Material(
      color: Colors.transparent,
      child: InputMatchConfirmationWidget(
        hintText: hintText,
        title: title,
        match: match,
      ),
    ),
  );

  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
  }) async => await showDialog<bool>(
    useRootNavigator: false,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => kIsWeb || Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: false,
                child: const Text('No'),
                onPressed: () => context.pop(false),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Yes'),
                onPressed: () => context.pop(true),
              ),
            ],
          )
        : AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('NO', style: TextStyle(color: Colors.black)),
                onPressed: () => context.pop(false),
              ),
              TextButton(
                child: const Text('YES', style: TextStyle(color: Colors.black)),
                onPressed: () => context.pop(true),
              ),
            ],
          ),
  );
}

class EmailPasswordInputWidget extends StatefulWidget {
  final Function(String email, String password) onSubmit;
  final VoidCallback onCancel;

  const EmailPasswordInputWidget({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  State<EmailPasswordInputWidget> createState() =>
      _EmailPasswordInputWidgetState();
}

class _EmailPasswordInputWidgetState extends State<EmailPasswordInputWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: _validatePassword,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onCancel,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit(
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputMatchConfirmationWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final String match;

  const InputMatchConfirmationWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.match,
  });

  @override
  State<InputMatchConfirmationWidget> createState() =>
      _InputMatchConfirmationWidget();
}

class _InputMatchConfirmationWidget
    extends State<InputMatchConfirmationWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(
      () => setState(
        () => _isButtonEnabled = _textEditingController.text == widget.match,
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Platform.isIOS
      ? CupertinoAlertDialog(
          title: Text(widget.title),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: widget.hintText),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: false,
              child: const Text('NO'),
              onPressed: () => context.pop(false),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => _isButtonEnabled ? context.pop(true) : null,
              child: const Text('YES'),
            ),
          ],
        )
      : AlertDialog(
          title: Text(widget.title),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: widget.hintText),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('NO', style: TextStyle(color: Colors.black)),
              onPressed: () => context.pop(false),
            ),
            ElevatedButton(
              onPressed: () => _isButtonEnabled ? context.pop(true) : null,
              child: const Text('YES', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
}
