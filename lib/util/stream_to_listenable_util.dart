import 'dart:async';

import 'package:flutter/material.dart';

class StreamToListenableUtil extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenableUtil(List<Stream> streams) {
    subscriptions = [];
    for (final stream in streams) {
      final subscription = stream.asBroadcastStream().listen(
        ((_) => notifyListeners()),
      );
      subscriptions.add(subscription);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
