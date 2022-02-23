
import 'package:doc_manager/core/services/extensions.dart';
import 'package:doc_manager/core/services/session_helper.dart';
import 'package:doc_manager/data/app_data/app_styles.dart';
import 'package:doc_manager/presentation/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class AccountDialog extends StatefulWidget {
  const AccountDialog({Key? key}) : super(key: key);

  @override
  _AccountDialogState createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  bool _logout = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 56,
        right: 10,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: SingleChildScrollView(
          child: Material(
            borderRadius: BorderRadius.circular(AppTheme.kRadius),
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: _logout ? _buildPrompt(context) : _buildSheet(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildSheet(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            child: const Icon(
              Remix.user_3_fill,
            ),
            foregroundColor: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 5),
          Text(
            "hiUser".tr(context),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            SessionHelper.sessionUser?.mobile ?? "n/a",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
          Divider(),
          STextButton(
            child: Row(
              children: [
                const Icon(Remix.logout_box_r_fill),
                const SizedBox(width: 10),
                Text("logout".tr(context)),
              ],
            ),
            onPressed: () {
              setState(() {
                _logout = true;
              });
              ;
            },
            color: Theme.of(context).errorColor,
          )
        ],
      );

  _buildPrompt(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Remix.question_fill,
            size: 32,
            color: Theme.of(context).errorColor,
          ),
          const SizedBox(height: 5),
          Text(
            "logoutQ".tr(context),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "logoutDesc".tr(context),
            style: Theme.of(context).textTheme.caption,
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: SElevatedButton(
                  child: Text("no".tr(context)),
                  onPressed: () {
                    setState(() {
                      _logout = false;
                    });
                  },
                  isSecondary: true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SElevatedButton(
                  child: Text("yes".tr(context)),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
            ],
          )
        ],
      );
}
