import 'package:flutter/material.dart';
import 'dart:math' as math;

class PaintDropBackground extends StatefulWidget {
  const PaintDropBackground({super.key});

  @override
  State<PaintDropBackground> createState() => _PaintDropBackgroundState();
}

class _PaintDropBackgroundState extends State<PaintDropBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return ClipPath(
          clipper: PaintDropClipper(_controller.value),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5C9CE5), Color(0xFF74B9FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PaintDropClipper extends CustomClipper<Path> {
  final double value;
  PaintDropClipper(this.value);

  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height * 0.3 + math.sin(value * math.pi * 2) * 20;
    path.lineTo(0, height);
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        height +
            math.sin((i / size.width * 2 * math.pi) + value * math.pi * 2) * 20,
      );
    }
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(PaintDropClipper oldClipper) => true;
}
