import 'package:flutter/material.dart';

class CustomClickableContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback ontap;
  final Color? color;
  final double boarderRadius;
  final EdgeInsets padding;
  const CustomClickableContainer({
    super.key,
    required this.child,
    required this.ontap,
    this.boarderRadius = 50,
    this.color,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(0, 183, 15, 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(boarderRadius),
        onTap: ontap,
        child: Container(
          height: 20,
          width: 20,
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? const Color.fromARGB(76, 164, 157, 157),
            borderRadius: BorderRadius.circular(boarderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
