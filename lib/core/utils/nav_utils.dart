

import 'package:doc_manager/core/utils/page_routes.dart';
import 'package:flutter/material.dart';

import 'app_styles.dart';

class NavUtils {
  static Future animateTo(BuildContext context, Widget page) => Navigator.push(
    context,
    HeroDialogRoute(builder: (_) => page),
  );

  static Future enterTo(BuildContext context, Widget from, Widget to) =>
      Navigator.push(context, EnterExitRoute(from, to));

  static Future scaleTo(BuildContext context, Widget page,
      [bool replace = false]) {
    if (replace) return Navigator.pushReplacement(context, ScaleRoute(page));
    return Navigator.push(context, ScaleRoute(page));
  }

  static void showSnackBar(String message,
      {required BuildContext context,
        GlobalKey<ScaffoldMessengerState>? key,
        Color? color,
        IconData? icon}) {
    var snackBar = SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 10),
      content: Material(
        color: color ?? Colors.pink,
        borderRadius: BorderRadius.circular(AppTheme.kRadiusSmall),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 10),
            Icon(
              icon ?? Icons.warning,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                maxLines: 3,
                textScaleFactor: 0.85,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  if (key == null) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  } else {
                    key.currentState?.hideCurrentSnackBar();
                  }
                })
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
    if (key == null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      key.currentState?.showSnackBar(snackBar);
    }
  }
}
