import 'package:flutter/material.dart';
import 'package:gift_grab_ui/config/constants.dart';
import 'package:go_router/go_router.dart';

class GGScaffoldWidget extends StatelessWidget {
  const GGScaffoldWidget({
    super.key,
    required this.child,
    required this.title,
    this.canPop = true,
    this.actions,
  });

  final Widget child;
  final String title;
  final bool canPop;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: actions,
        leading: canPop
            ? IconButton.filledTonal(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back),
              )
            : SizedBox(),
        title: Text(title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.50,
            image: AssetImage("assets/images/${Constants.backgroundSprite}"),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
