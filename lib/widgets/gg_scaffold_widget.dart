import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GGScaffoldWidget extends StatelessWidget {
  const GGScaffoldWidget({
    super.key,
    required this.title,
    required this.child,
    this.canPop = true,
    this.actions,
  });

  final String title;
  final Widget child;
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
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.50,
            image: kIsWeb
                ? NetworkImage("assets/images/background-sprite.jpg")
                : AssetImage("assets/images/background-sprite.jpg")
                      as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
