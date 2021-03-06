import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;

  const ShadowContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
         boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 2.5,
              spreadRadius: 1.0,
              offset: Offset(1.0, 1.0))
        ],
      ),
      child: child,
    );
  }
}
