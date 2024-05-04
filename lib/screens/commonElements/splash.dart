import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnimatedShoe(),
    );
  }
}

// Animated Shoe
class AnimatedShoe extends StatefulWidget {
  const AnimatedShoe({super.key});

  @override
  State<AnimatedShoe> createState() => _AnimatedShoeState();
}

class _AnimatedShoeState extends State<AnimatedShoe>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _shoeAnimation;

  // GPT Code
  late Animation<Offset> _shoeDropAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<Offset> _returnAnimation;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _shoeAnimation = Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 300.0),
    ).animate(_controller);

    // GPT Code starts
    _shoeDropAnimation = Tween(
      begin: const Offset(0.0, -1.0), // Drop in from top
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
    ));

    _returnAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 300.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.75, 0.85, curve: Curves.easeInOut),
    ));

    _spinAnimation = Tween<double>(
      begin: 0.0,
      end: 360.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.85, 1.0, curve: Curves.easeInOut),
    ));

    // GPT Code ends

    _controller.forward();

    _controller.addListener(() {
      print(_controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.translate(
          offset: _shoeDropAnimation.value +
              Offset(0.0, _bounceAnimation.value) +
              _returnAnimation.value,
          child: Transform.rotate(
            angle:
                _spinAnimation.value * 0.0174533, // Convert degrees to radians
            child: Image.asset('assets/splash-01.png'),
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
