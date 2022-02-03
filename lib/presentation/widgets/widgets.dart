import 'package:doc_manager/core/utils/app_styles.dart';
import 'package:doc_manager/core/utils/extensions.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/presentation/widgets/s_buttons.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';


class AppIcon extends StatelessWidget {
  final double? size;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const AppIcon(
      {Key? key, this.size, this.foregroundColor, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: size ?? 96,
        height: size ?? 96,
        child: Stack(
          children: [
            Icon(
              Remix.heart_fill,
              size: size ?? 96,
              color: backgroundColor ?? Theme.of(context).primaryColor,
            ),
            Center(
              child: Icon(
                Remix.stethoscope_fill,
                size: size == null ? 32 : size! / 3,
                color: foregroundColor ?? Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class RatingBar extends StatelessWidget {
  final num rating;
  final double size;
  final Color color;

  const RatingBar({
    Key? key,
    required this.rating,
    this.size = 16.0,
    this.color = Colors.orange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stars = <Widget>[];
    for (int i = 0; i < rating.toInt(); i++) {
      stars.add(
        Icon(
          Remix.star_fill,
          size: size,
          color: color,
        ),
      );
    }
    if (rating / rating.toInt() > 1.0) {
      stars.add(
        Icon(
          Remix.star_half_fill,
          size: size,
          color: color,
        ),
      );
    }
    var rem = 5 - stars.length;
    for (int i = 0; i < rem; i++) {
      stars.add(
        Icon(
          Remix.star_line,
          size: size,
          color: color,
        ),
      );
    }
    return Row(
      children: stars,
      mainAxisSize: MainAxisSize.min,
    );
  }
}

class Dot extends StatelessWidget {
  final Color? color;
  final double? size;

  const Dot({Key? key, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: size ?? 5.0,
      height: size ?? 5.0,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(AppTheme.kRadius),
      ),
    );
  }
}

class DoctorListTile extends StatelessWidget {
  final String heroTag;
  final VoidCallback? onTap;
  final Doctor item;

  const DoctorListTile(
      {Key? key, required this.heroTag, this.onTap, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        item.name,
        textScaleFactor: 1.1,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  (item.specialization ?? "").toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
              const Dot(),
              item.ratingWidgetCompact,
            ],
          ),
          Text(
            item.description ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      leading: Hero(
        tag: heroTag,
        child: SizedBox(
          width: 64,
          height: 64,
          child: Material(
            child: item.avatar,
            borderRadius: BorderRadius.circular(AppTheme.kRadius * 1.5),
            clipBehavior: Clip.hardEdge,
          ),
        ),
      ),
      minLeadingWidth: 64,
      trailing: const Icon(Remix.arrow_right_s_line),
    );
  }
}

class DoctorGridTile extends StatelessWidget {
  final String heroTag;
  final VoidCallback? onTap;
  final Doctor item;

  const DoctorGridTile(
      {Key? key, required this.heroTag, this.onTap, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppTheme.kRadius),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Hero(
              tag: heroTag,
              child: item.avatar,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black45, Colors.black12],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                title: Text(
                  item.name,
                  textScaleFactor: 1.1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Colors.white,
                      ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            (item.specialization ?? "").toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      item.description ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: item.ratingWidgetCompact,
              right: 5,
              top: 5,
            ),
          ],
        ),
      ),
    );
  }
}


