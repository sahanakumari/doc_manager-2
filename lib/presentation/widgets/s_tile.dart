import 'package:flutter/cupertino.dart';

class STile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final List<Widget>? actions;

  const STile(
      {Key? key,
      this.leading,
      required this.title,
      this.actions,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Row(
        children: [
          leading ?? SizedBox.shrink(),
          if(leading!=null)SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                subtitle ?? SizedBox.shrink(),
              ],
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
