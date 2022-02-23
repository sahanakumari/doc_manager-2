part of '../forms.dart';
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