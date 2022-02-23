part of '../forms.dart';
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