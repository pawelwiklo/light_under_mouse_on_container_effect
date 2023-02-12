import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double x = 0.0;
  double y = 0.0;

  bool showShadow = false;

  double containerWidth = 250;
  double containerHeight = 150;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('container width start: ${size.width / 2 - containerWidth / 2}');
    print('container height start: ${size.height / 2 - containerHeight / 2}');
    print('x candidate: ${x - (size.width / 2 - containerWidth / 2)}');
    print('y candidate: ${y - (size.height / 2 - containerHeight / 2)}');
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 20, 20, 1),
      body: Center(
        child: MouseRegion(
          onEnter: _onEnter,
          onHover: _updateLocation,
          onExit: _onExit,
          child: Stack(
            children: [
              Container(
                width: containerWidth,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.02),
                  border: Border.all(
                      width: 1, color: Color.fromRGBO(255, 255, 255, 0.1)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              if (showShadow)
                Positioned(
                  left: x -
                      (size.width / 2 - containerWidth / 2) -
                      containerWidth / 2,
                  top: y -
                      (size.height / 2 - containerHeight / 2) -
                      containerHeight / 2,
                  child: Container(
                    width: containerWidth,
                    height: containerHeight,
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: Colors.white12,
                        // blurStyle: BlurStyle.outer, // cool effect
                        blurRadius: containerWidth / 2,
                        // spreadRadius: 10,
                      ),
                    ]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
    print(
        'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})');
  }

  void _onEnter(PointerEvent details) {
    setState(() {
      showShadow = true;
    });
    print('on enter');
  }

  void _onExit(PointerEvent details) {
    setState(() {
      showShadow = false;
    });
    print('on exit');
  }
}
