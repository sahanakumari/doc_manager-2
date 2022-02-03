import 'dart:async';
import 'package:doc_manager/core/utils/app_styles.dart';
import 'package:doc_manager/core/utils/nav_utils.dart';
import 'package:doc_manager/core/utils/utils.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/presentation/bloc/Home/home_bloc.dart';
import 'package:doc_manager/presentation/widgets/s_card.dart';
import 'package:doc_manager/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctor_detail_screen.dart';

class DocCarouselPage extends StatefulWidget {
  final List<Doctor> doctorList;
  final void Function(Doctor doctor, String heroTag)? onItemTap;

  const DocCarouselPage({Key? key, required this.doctorList, this.onItemTap})
      : super(key: key);

  @override
  _DocCarouselState createState() => _DocCarouselState();
}

class _DocCarouselState extends State<DocCarouselPage> {
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _setTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
  _onItemTap(Doctor item, String tag ,BuildContext context) {

    NavUtils.animateTo(context, DoctorDetailsScreen(doctor: item, tag: tag))
        .then((value) {
      if (value == true) {
        BlocProvider.of<HomeBloc>(context).add(const DoctorsEventImpl({}));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.doctorList.length,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        var color = ColorUtils.randomColor;
        return SCard(
          margin: const EdgeInsets.all(5),
          child: InkWell(
            onTap: () => _onItemTap(widget.doctorList[index], "pv-$index",context),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Hero(
                    tag: "pv-$index",
                    child: SizedBox(
                      width: 120,
                      height: double.maxFinite,
                      child: Material(
                        child: widget.doctorList[index].avatar,
                        borderRadius: BorderRadius.circular(AppTheme.kRadius),
                        clipBehavior: Clip.hardEdge,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: [
                    Alignment.bottomLeft,
                    Alignment.topLeft
                  ][index % 2],
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withOpacity(0.5),
                        Colors.black12,
                      ],
                    ),
                  ),
                  height: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(
                        widget.doctorList[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            (widget.doctorList[index].specialization ?? "").toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style:
                            Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          RatingBar(rating: widget.doctorList[index].ratingNum),
                          Text(
                            widget.doctorList[index].description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                            Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      var _page = _pageController.page;
      if ((_page?.toInt() ?? 0) == (widget.doctorList.length - 1)) {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
        );
      }
    });
  }
}