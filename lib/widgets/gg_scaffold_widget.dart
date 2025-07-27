import 'package:flutter/material.dart';

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
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
              )
            : SizedBox(),
        title: Text(title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.50,
            image: AssetImage("assets/images/background-sprite.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
