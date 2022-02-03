import 'package:doc_manager/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SCard extends StatelessWidget {
  final EdgeInsets? margin;
  final Widget? child;
  final Color? color;

  const SCard({Key? key, this.margin, this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).dividerColor.withOpacity(0.3),
              blurRadius: 5),
        ],
        borderRadius: BorderRadius.circular(AppTheme.kRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.kRadius),
        clipBehavior: Clip.hardEdge,
        child: child,
      ),
    );
  }
}
