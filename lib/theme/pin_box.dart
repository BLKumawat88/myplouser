import 'package:flutter/material.dart';

class DigitHolder extends StatelessWidget {
  // final int? index;
  // final int? selectedIndex;
  // final String? code;
  // final Color color;
  // final double? width;
  // final double? height;

  // const DigitHolder({
  //   super.key,
  //   this.index,
  //   this.selectedIndex,
  //   this.code,
  //   required this.color,
  //   required this.width,
  //   this.height,
  // });

  final int? selectedIndex;
  final int? index;
  final String? code;
  final Color? color;
  const DigitHolder({
    @required this.selectedIndex,
    Key? key,
    @required this.width,
    this.index,
    this.code,
    this.color,
  }) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: height,
    //   width: width,
    //   decoration: BoxDecoration(
    //     color: colorWhite,
    //     shape: BoxShape.circle,
    //   ),
    //   child: code!.length > index!
    //       ? Container(
    //           height: 15,
    //           width: 15,
    //           decoration: const BoxDecoration(
    //             color: Color(0xFF5E5E5F),
    //             shape: BoxShape.circle,
    //           ),
    //         )
    //       : const SizedBox(),
    // );

    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xFF434547),
        ),
      ),
      child: code!.length > index!
          ? Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                color: Color(0xFF5E5E5F),
                shape: BoxShape.circle,
              ),
            )
          : const SizedBox(),
    );
  }
}
