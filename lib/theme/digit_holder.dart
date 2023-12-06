import 'package:flutter/material.dart';

class DigitHolder extends StatelessWidget {
  final int? selectedIndex;
  final int? index;
  final String? code;
  const DigitHolder({
    @required this.selectedIndex,
    Key? key,
    @required this.width,
    this.index,
    this.code,
  }) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 15,
      width: 15,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: index == selectedIndex ? Colors.blue : Colors.transparent,
              offset: const Offset(0, 0),
              spreadRadius: 1.5,
              blurRadius: 2,
            )
          ]),
      child: code!.length > index!
          ? Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                color: Color(0xFF4EC994),
                shape: BoxShape.circle,
              ),
            )
          : const SizedBox(),
    );
  }
}
