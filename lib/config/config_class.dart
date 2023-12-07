import 'package:flutter/material.dart';

import 'config_size.dart';

class MenuIconOnTap extends StatelessWidget {
  final Function()? onTap;
  final Icon? icon;
  const MenuIconOnTap({
    required this.onTap,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: icon,
      ),
    );
  }
}

class LineDevider extends StatelessWidget {
  final double heightLine;
  final Color? chooseColor;
  const LineDevider({
    required this.heightLine,
    required this.chooseColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: ConfigSize.blockSizeVertical! * heightLine,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: chooseColor,
      ),
    );
  }
}

class LineDeviderHorizontal extends StatelessWidget {
  final double widthLine;
  final Color? chooseColor;
  const LineDeviderHorizontal({
    required this.widthLine,
    required this.chooseColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    return Container(
      height: 1,
      width: ConfigSize.blockSizeHorizontal! * widthLine,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: chooseColor,
      ),
    );
  }
}
