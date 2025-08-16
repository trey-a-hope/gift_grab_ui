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
            image: AssetImage("assets/images/background-sprite.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}

// Perfect! The console errors show exactly what's happening. You're getting a flood of WebGL errors:
// WebGL: INVALID_VALUE: texImage2D: width or height out of range
// This is a WebGL texture size limitation issue on Android browsers. Your background image (background-sprite.jpg) is likely too large for Android's WebGL implementation to handle as a texture.
// The Problem:

// Android WebGL has stricter texture size limits (often 2048x2048 or 4096x4096)
// Your background image exceeds these limits
// iOS Safari is more lenient with texture sizes

// Solutions:
// Solution 1: Resize Your Background Image
// bash# Check your current image size
// file assets/images/background-sprite.jpg

// # Resize to max 2048x2048 (safe for all devices)
// # Use any image editor or command line:
// convert assets/images/background-sprite.jpg -resize 2048x2048 assets/images/background-sprite-small.jpg
// Solution 2: Use Different Images for Different Platforms
// dartString _getBackgroundImage() {
//   if (kIsWeb) {
//     final userAgent = html.window.navigator.userAgent.toLowerCase();
//     if (userAgent.contains('android')) {
//       return "assets/images/background-sprite-small.jpg"; // Smaller version
//     }
//   }
//   return "assets/images/background-sprite.jpg"; // Original
// }

// decoration: BoxDecoration(
//   image: DecorationImage(
//     opacity: 0.50,
//     image: AssetImage(_getBackgroundImage()),
//     fit: BoxFit.cover,
//   ),
// ),
// Solution 3: Force HTML Renderer for Android
// Add this to your web/index.html:
// html<script>
//   // Force HTML renderer on Android to avoid WebGL texture limits
//   if (navigator.userAgent.toLowerCase().includes('android')) {
//     window.flutterWebRenderer = "html";
//   }
// </script>
// Solution 4: Check WebGL Texture Limits
// Add this debug code to see the actual limits:
// dartimport 'dart:html' as html;

// void checkWebGLLimits() {
//   if (kIsWeb) {
//     final canvas = html.CanvasElement();
//     final gl = canvas.getContext('webgl') as html.RenderingContext;
//     final maxTextureSize = gl.getParameter(html.WebGL.MAX_TEXTURE_SIZE);
//     print('Max WebGL texture size: $maxTextureSize');
//   }
// }
// Quick fix: Resize your background image to 2048x2048 or smaller. That should immediately solve the Android WebGL texture issue.
// What's the current size of your background-sprite.jpg file?
