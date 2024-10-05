import 'package:flutter/material.dart';

class TypeRegisterBackground extends StatelessWidget {
  final Widget child;

  const TypeRegisterBackground({Key? key, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          child,
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Container(
      decoration: _buildBoxDecoration(),
      child: Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            child: _Bubble(),
          ),
          Positioned(
            top: -40,
            left: -30,
            child: _Bubble(),
          ),
          Positioned(
            top: -20,
            right: -30,
            child: _Bubble(),
          ),
          Positioned(
            bottom: -50,
            left: 10,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 120,
            right: 350,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 180,
            right: 150,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 500,
            right: 150,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 500,
            right: 400,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 700,
            right: 250,
            child: _Bubble(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1),
          ],
        ),
      );
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
