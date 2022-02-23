import 'package:doc_manager/core/services/extensions.dart';
import 'package:doc_manager/core/services/session_helper.dart';
import 'package:doc_manager/core/services/utils.dart';
import 'package:doc_manager/data/app_data/app_styles.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/presentation/bloc/Home/home_bloc.dart';
import 'package:doc_manager/presentation/screens/login/login_screen.dart';
import 'package:doc_manager/presentation/widgets/components.dart';
import 'package:doc_manager/presentation/widgets/doctor_tile.dart';
import 'package:doc_manager/presentation/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:get_it/get_it.dart';
import 'package:remixicon/remixicon.dart';
import '../doctor_detail_screen.dart';
import '../settings_screen.dart';
import 'account_dialog.dart';
import 'home.dart';
import 'core/di.dart' as di;
final dii = GetIt.instance;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  void _onItemTap(int index) {

    setState(() {
      _index = index;
    });
    _toggle();
  }

  Widget get _page {
    return _drawerItems[_index]["p"] ??
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppIcon(),
              Text(
                "appName".tr(context),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        );
  }

  @override
  void initState() {
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   BlocProvider.of<HomeBloc>(context).add(const GetDoctorsListEvent({}));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
          onWillPop: () {
            if (_index != 0) {
              setState(() {
                _index = 0;
              });
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: InnerDrawer(
              key: _innerDrawerKey,
              onTapClose: true,
              swipe: true,
              colorTransitionScaffold: Colors.black12,
              offset: const IDOffset.only(bottom: 0.05),
              swipeChild: true,
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: AppTheme.kRadius,
              leftAnimationType: InnerDrawerAnimation.quadratic,
              leftChild: _buildDrawer(context),
              scaffold:
              Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: _toggle,
                    icon: const Icon(Remix.menu_4_fill),
                  ),
                  title: Text("appName".tr(context)),
                  actions: [
                    IconButton(
                      onPressed: () {
                        NavUtils.animateTo(context, const AccountDialog())
                            .then((value) {
                          if (value ?? false) {
                            SessionHelper.sessionUser = null;
                            NavUtils.scaleTo(context, const LoginScreen(), true);
                          }
                        });
                      },
                      icon: CircleAvatar(
                        child: const Icon(
                          Remix.user_3_fill,
                          size: 18,
                        ),
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                body: _page,

              )
          )
      );
  }
  final List<Map<String, dynamic>> _drawerItems = [

    {"i": Remix.home_6_fill, "t": "home", "p": const Home()},
    {"i": Remix.settings_5_fill, "t": "settings", "p": const SettingsScreen()},
    {"i": Remix.information_fill, "t": "about"},
  ];

  _buildDrawer(BuildContext context) {
    return
      Material(
        color: Colors.transparent,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: AppIcon(
                    backgroundColor: Colors.white70,
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                ),
                const Divider(),
                ..._drawerItems
                    .map(
                      (e) => DrawerItem(
                    label: e["t"],
                    icon: e["i"],
                    isSelected: _drawerItems.indexOf(e) == _index,
                    onTap: () => _onItemTap(_drawerItems.indexOf(e)),
                  ),
                )
                    .toList(),
              ],
            ),
          ),
        ),
      );
  }
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
  GlobalKey<InnerDrawerState>();

  void _toggle() {
    _innerDrawerKey.currentState?.toggle(direction: InnerDrawerDirection.start);
  }

}



class DocGridView extends StatelessWidget {
  final List<Doctor> items;

  const DocGridView({Key? key, required this.items}) : super(key: key);
  _onItemTap(Doctor item, String tag ,BuildContext context) {

    NavUtils.animateTo(context, DoctorDetailsScreen(doctor: item, tag: tag))
        .then((value) {
      if (value == true) {
        BlocProvider.of<HomeBloc>(context).add(const GetDoctorsListEvent({}));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      key: const ValueKey("grid-view"),
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => DoctorGridTile(
        heroTag: "gv-$index",
        item: items[index],
        onTap: () => _onItemTap(items[index], "gv-$index",context),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    );
  }
}

class DocListView extends StatelessWidget {
  final List<Doctor> items;
  final BuildContext context;
  const DocListView({Key? key, required this.items,required this.context}) : super(key: key);
  _onItemTap(Doctor item, String tag ,BuildContext context) {

    NavUtils.animateTo(context, DoctorDetailsScreen(doctor: item, tag: tag))
        .then((value) {
      if (value == true) {
        BlocProvider.of<HomeBloc>(context).add(const GetDoctorsListEvent({}));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      key: const ValueKey("list-view"),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => DoctorListTile(
        heroTag: "lv-$index",
        onTap: () => _onItemTap(items[index], "lv-$index",context),
        item: items[index],
      ),
      separatorBuilder: (BuildContext context, int index) =>
      const Divider(indent: 70),
      padding: const EdgeInsets.symmetric(vertical: 20),
    );

  }

}
