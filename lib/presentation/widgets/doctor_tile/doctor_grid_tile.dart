
part of '../doctor_tile.dart';


class DoctorGridTile extends StatelessWidget {
  final String heroTag;
  final VoidCallback? onTap;
  final Doctor item;

  const DoctorGridTile(
      {Key? key, required this.heroTag, this.onTap,  required this.item})
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