import 'package:doc_manager/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class STextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;

  const STextButton({Key? key, required this.child, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: color ?? Theme.of(context).iconTheme.color,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class SElevatedButton extends StatelessWidget {
  final Widget child;
  final bool isSecondary;
  final VoidCallback? onPressed;
  final Color? color;

  const SElevatedButton(
      {Key? key,
      required this.child,
      this.onPressed,
      this.isSecondary = false,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color ??
            (isSecondary
                ? Theme.of(context).hintColor
                : Theme.of(context).buttonTheme.colorScheme!.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.kRadius),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
