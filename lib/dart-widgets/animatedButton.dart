import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  AnimatedButton({
    Key? key,
    required this.text,
    this.gradientStyle = 'Rainbow',
    this.animationDuration = const Duration(seconds: 4),
    this.containerWidth = 250,
    this.containerHeight = 250,
    this.containerMargin = const EdgeInsets.all(2),
    this.containerPadding = const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    this.containerColor = const Color(0xFF000000), // Default to black
    this.containerOpacity = 0.9,
    this.borderRadius = 10,
    this.textStyle = const TextStyle(fontSize: 20),
  }) : super(key: key);

  final String text;
  final String gradientStyle;
  final Duration animationDuration;
  final double containerWidth;
  final double containerHeight;
  final EdgeInsetsGeometry containerMargin;
  final EdgeInsetsGeometry containerPadding;
  final Color containerColor;
  final double containerOpacity;
  final double borderRadius;
  final TextStyle textStyle;
  final Map<String, List<Color>> gradientSets = {
    'Rainbow': [
      Colors.red,
      Colors.purple,
      Colors.pink,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.cyan,
      Colors.blue,
      Colors.red,
    ],
    'Trident': [
      Colors.blue,
      Colors.purple,
      Colors.green,
    ],
    'OceanBreeze': [
      Colors.lightBlue,
      Colors.blue,
      Colors.teal,
    ],
    'SpectralSerenity': [
      Color(0xFF9400D3),
      Color(0xFF4B0082),
      Color(0xFF0000FF),
      Color(0xFF00FF00),
      Color(0xFFFFFF00),
      Color(0xFFFF7F00),
      Color(0xFFFF0000),
    ],
    'PastelDreams': [
      Color(0xFFFFCCCC),
      Color(0xFFCC99FF),
      Color(0xFF99CCFF),
      Color(0xFF99FF99),
      Color(0xFFFFFF99),
    ],
    'LushMeadow': [
      Color(0xFF228B22),
      Color(0xFF556B2F),
      Color(0xFF8FBC8F),
      Color(0xFF00FA9A),
      Color(0xFF32CD32),
    ],
    'SunriseRadiance': [
      Color(0xFFFFDAB9),
      Color(0xFFFF6347),
      Color(0xFFFF4500),
      Color(0xFFFFD700),
      Color(0xFFFFFF00),
      Color(0xFFFFA500),
    ],
    'MysticalTwilight': [
      Color(0xFF191970),
      Color(0xFF800080),
      Color(0xFF008080),
      Color(0xFF4B0082),
      Color(0xFF9932CC),
    ],
  };
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {


  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = widget.gradientSets.containsKey(widget.gradientStyle)
        ? widget.gradientSets[widget.gradientStyle]!
        : widget.gradientSets['Rainbow']!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final t = _animation.value;

        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment(
                  -2.0 + 2.0 * t,
                  -1.0,
                ),
                end: Alignment(
                  2.0 + 2.0 * t,
                  1.0,
                ),
              ),
            ),
            child: Container(
              width: widget.containerWidth,
              height: widget.containerHeight,
              margin: widget.containerMargin,
              padding: widget.containerPadding,
              decoration: BoxDecoration(
                color: widget.containerColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.text,
                style: widget.textStyle,
                textAlign: TextAlign.center,
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
