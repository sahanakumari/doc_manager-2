

part of '../components.dart';
class ErrorContainer extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onRetryTap;
  final Widget? icon;
  final String? buttonText;
  final IconData? buttonIcon;
  final Alignment alignment;

  const ErrorContainer(
      {Key? key,
        this.title,
        this.subtitle,
        this.onRetryTap,
        this.icon,
        this.buttonText = "tryAgain",
        this.buttonIcon,
        this.alignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon ?? SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              title?.tr(context) ?? "somethingWrong".tr(context),
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.color
                    ?.withOpacity(0.8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Text(
              subtitle?.tr(context) ?? "pleaseTryReload".tr(context),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.color
                    ?.withOpacity(0.5),
              ),
            ),
          ),
          onRetryTap == null
              ? const SizedBox.shrink()
              : Center(
            child: SElevatedButton(
              onPressed: onRetryTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 10),
                  Icon(
                    buttonIcon ?? Icons.refresh,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      "$buttonText".tr(context).toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}