import 'package:doc_manager/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class RSwitch extends StatelessWidget {
  final bool isAvailable;

  const RSwitch({Key? key, this.isAvailable = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 48,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isAvailable
                ? Theme.of(context).colorScheme.secondary
                : Colors.grey[400]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppTheme.kRadius),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment:
                  isAvailable ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 300),
              child: Container(
                margin: const EdgeInsets.all(2),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isAvailable
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.grey[400],
                  borderRadius: BorderRadius.circular(AppTheme.kRadius / 1.25),
                ),
                child: Icon(
                  isAvailable ? Remix.spy_fill : Remix.eye_fill,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
