
part of '../doctor_tile.dart';


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