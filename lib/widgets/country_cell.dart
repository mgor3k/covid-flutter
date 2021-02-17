import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryCell extends StatelessWidget {
  final String title;
  final bool isFirst;
  final bool isLast;
  final Function onTapped;

  CountryCell({
    @required this.title,
    @required this.isFirst,
    @required this.isLast,
    @required this.onTapped,
  });

  BorderRadius get _getBorderRadius {
    final radius = Radius.circular(16);
    return BorderRadius.only(
      topLeft: isFirst ? radius : Radius.zero,
      topRight: isFirst ? radius : Radius.zero,
      bottomLeft: isLast ? radius : Radius.zero,
      bottomRight: isLast ? radius : Radius.zero,
    );
  }

  EdgeInsets get _getPadding {
    return EdgeInsets.only(
      top: isFirst ? 16 : 8,
      bottom: isLast ? 16 : 8,
      left: 16,
      right: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _getBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: _getPadding,
              child: Text(title),
            ),
            if (!isLast) Divider(),
          ],
        ),
      ),
    );
  }
}
