import 'package:doc_manager/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final bool bottomDivider;
  final Color? color;

  const SectionTitle(this.text,
      {Key? key, this.padding, this.bottomDivider = false, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: color ?? Theme.of(context).colorScheme.secondary,
            ),
          ),
          if (bottomDivider) SizedBox(height: 5),
          if (bottomDivider)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.kRadius),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 2,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
