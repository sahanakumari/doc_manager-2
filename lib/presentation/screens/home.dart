import 'package:doc_manager/core/utils/extensions.dart';
import 'package:doc_manager/core/utils/logger.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/presentation/bloc/Home/home_bloc.dart';
import 'package:doc_manager/presentation/widgets/section_title.dart';
import 'package:doc_manager/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';
import 'doc_carousel_page.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: BlocConsumer(
          bloc: BlocProvider.of<HomeBloc>(context),
          builder: (context, state) {
            appLog(state ?? "");
            if (state is DoctorsError) {
              return ErrorContainer(subtitle: state.message);
            }
            else if (state is DoctorsLoaded) {
              List<Doctor> ordered = state.doctors as List<Doctor>;
              ordered.sort((a, b) => b.ratingNum.compareTo(a.ratingNum));
              if (ordered.length > 3) ordered = ordered.take(3).toList();
              return NestedScrollView(
                body: RefreshIndicator(
                  onRefresh: () async {
                    return Future.value();
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: state.gridView
                        ? DocGridView(items: state.doctors as List<Doctor>,)
                        : DocListView(items: state.doctors as  List<Doctor>, context: context,),
                  ),
                ),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [

                    SliverAppBar(

                      expandedHeight: 200,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle("top3Doctors".tr(context)),
                            Expanded(
                              child: DocCarouselPage(doctorList: ordered,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SliverAppBar(
                    //   title: Text("Doctors"),
                    // ),
                  ];
                },
              );
            }

            return const Center(child: RefreshProgressIndicator());
          },
          listener: (context, state) {
            if (state is DoctorsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
        ),
        floatingActionButton: BlocBuilder(
            bloc: BlocProvider.of<HomeBloc>(context),
            builder: (context, state) {
              if (state is DoctorsLoaded) {
                return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add( DoctorsChangeOrientation(state.doctors,!state.gridView));
                  },
                  child: Icon(
                    state.gridView ? Remix.list_check_2 : Remix.function_line,
                  ),
                );
              }
              return SizedBox.shrink();
            }),
      );
  }
}