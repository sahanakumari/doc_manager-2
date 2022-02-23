import 'dart:math';
import 'package:doc_manager/core/services/app_settings.dart';
import 'package:doc_manager/core/services/extensions.dart';
import 'package:doc_manager/data/app_data/app_styles.dart';
import 'package:doc_manager/presentation/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const SettingsScreen({Key? key, this.onBackTap}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Map<String, dynamic> _fonts = {
    "Roboto": null,
    "Montserrat": "Montserrat",
    "Poppins": "Poppins",
    "Josefin Sans": "Josefin Sans",
  };

  final Map<dynamic, String> _themes = {
    ThemeMode.system: "systemDefault",
    ThemeMode.light: "light",
    ThemeMode.dark: "dark",
  };

  final Map<dynamic, String> _languages = {
    null: "systemDefault",
    "en": "English",
    "hi": "हिन्दी",
  };

  final Map<int, String> _colors = {
   // kAccentColor.value: "appDefault",
    0xff03c04a: "Parakeet",
    0xff028a0f: "Emerald",
    0xffb43757: "Hibiscus",
    0xffd21f3c: "Raspberry",
    0xffFF2800: "Ferrari",
    0xff2832c2: "Lapis",
    0xff6A5ACD: "Slate",
    0xff6595EC: "Cornflower",
  };

  final Map<double, String> _cornerRadius = {
    0.0: "flat",
    5.0: "slightCorners",
    10.0: "round",
  };

  final Map<double, String> _sizes = {
    0.8: "verySmall",
    0.9: "small",
    1.0: "normal",
    1.1: "large",
    1.2: "veryLarge",
  };

  TextStyle _getStyle(BuildContext context, bool selected) {
    return Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: selected ? Colors.white : null);
  }

  late AppSettings _settings;
  double _fontSize = 1.0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        _fontSize = _settings.textScale;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, AppSettings settings, Widget? child) {
        _settings = settings;
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle("displayNBrightness".tr(context)),
                Column(
                  children: [
                    SettingItem(
                      title: "theme",
                      icon: Theme.of(context).brightness == Brightness.light
                          ? Remix.sun_fill
                          : Remix.moon_fill,
                      onToggle: () {
                        if (settings.expandedIndex == 0) {
                          settings.expandedIndex = null;
                        } else {
                          settings.expandedIndex = 0;
                        }
                      },
                      isExpanded: settings.expandedIndex == 0,
                      subtitle: _themes[settings.themeMode] ?? "systemDefault",
                      items: _themes.keys
                          .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text((_themes[e] ?? "systemDefault")
                              .tr(context)),
                          labelStyle: _getStyle(
                              context, settings.themeMode == e),
                          selected: settings.themeMode == e,
                          onSelected: (selected) {
                            settings.themeMode = e;
                            settings.expandedIndex = null;
                          },
                        ),
                      ))
                          .toList(),
                    ),
                    Divider(height: 1, indent: 72),
                    SettingItem(
                      title: "colorScheme",
                      icon: Remix.palette_fill,
                      items: _colors.keys
                          .map((e) => Padding(
                        padding: const EdgeInsets.only(
                            right: 10, bottom: 10),
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: ChoiceChip(
                            label: Tooltip(
                              message: _colors[e]?.tr(context) ?? "",
                              child: Container(
                                width: 32,
                                height: 32,
                                child: settings.color == e
                                    ? const Icon(
                                  Remix.check_fill,
                                  size: 16,
                                  color: Colors.white,
                                )
                                    : null,
                                decoration: BoxDecoration(
                                  color: Color(e),
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.kRadius,
                                  ),
                                ),
                              ),
                            ),
                            labelStyle:
                            _getStyle(context, settings.color == e),
                            // label: Text((_colors[e] ?? "appDefault")
                            //     .tr(context)),
                            labelPadding: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            selected: settings.color == e,
                            onSelected: (selected) {
                              settings.color = e;
                              settings.expandedIndex = null;
                            },
                          ),
                        ),
                      ))
                          .toList(),
                      onToggle: () {
                        if (settings.expandedIndex == 1) {
                          settings.expandedIndex = null;
                        } else {
                          settings.expandedIndex = 1;
                        }
                      },
                      isExpanded: settings.expandedIndex == 1,
                      subtitle: _colors[settings.color] ?? "appDefault",
                    ),
                    Divider(height: 1, indent: 72),
                    SettingItem(
                      title: "cardDesign",
                      icon: Remix.shape_2_fill,
                      items: _cornerRadius.keys
                          .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          labelStyle: _getStyle(
                              context, settings.cornerRadius == e),
                          label: Text(
                              (_cornerRadius[e] ?? "flat").tr(context)),
                          selected: settings.cornerRadius == e,
                          onSelected: (selected) {
                            settings.cornerRadius = e;
                            settings.expandedIndex = null;
                          },
                        ),
                      ))
                          .toList(),
                      onToggle: () {
                        if (settings.expandedIndex == 5) {
                          settings.expandedIndex = null;
                        } else {
                          settings.expandedIndex = 5;
                        }
                      },
                      isExpanded: settings.expandedIndex == 5,
                      subtitle: _cornerRadius[settings.cornerRadius] ?? "flat",
                    ),
                    Divider(height: 1, indent: 72),
                    SettingItem(
                      icon: Remix.text,
                      title: "font",
                      items: _fonts.keys
                          .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          labelStyle: _getStyle(
                              context, settings.fontName == e),
                          label: Text(
                            _fonts[e] ?? "systemDefault".tr(context),
                            style: _getStyle(
                                context, settings.fontName == e)
                                .copyWith(
                              fontFamily: e,
                            ),
                          ),
                          selected: settings.fontName == e,
                          onSelected: (selected) {
                            settings.fontName = e;
                            settings.expandedIndex = null;
                          },
                        ),
                      ))
                          .toList(),
                      onToggle: () {
                        if (settings.expandedIndex == 2) {
                          settings.expandedIndex = null;
                        } else {
                          settings.expandedIndex = 2;
                        }
                      },
                      isExpanded: settings.expandedIndex == 2,
                      subtitle: settings.fontName == "Roboto"
                          ? "systemDefault".tr(context)
                          : settings.fontName,
                    ),
                    Divider(height: 1, indent: 72),
                    SettingItem(
                      title: "fontSize",
                      icon: Remix.font_size,
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 1,
                              trackShape: RectangularSliderTrackShape(),
                              valueIndicatorShape:
                              PaddleSliderValueIndicatorShape(),
                              showValueIndicator: ShowValueIndicator.always,
                              valueIndicatorColor:
                              Theme.of(context).iconTheme.color,
                              valueIndicatorTextStyle: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(
                                  color: Theme.of(context).canvasColor),
                              activeTickMarkColor:
                              Theme.of(context).iconTheme.color,
                              inactiveTickMarkColor:
                              Theme.of(context).iconTheme.color,
                              activeTrackColor: Theme.of(context).dividerColor,
                              inactiveTrackColor:
                              Theme.of(context).dividerColor,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 8),
                              thumbColor:
                              Theme.of(context).colorScheme.secondary,
                              tickMarkShape:
                              RoundSliderTickMarkShape(tickMarkRadius: 2),
                            ),
                            child: Slider(
                              min: 0.8,
                              max: 1.2,
                              divisions: 4,
                              value: _fontSize,
                              label: _sizes[_fontSize]!.tr(context),
                              onChanged: (v) {
                                setState(() {
                                  _fontSize = v;
                                });
                              },
                              onChangeEnd: (v) {
                                settings.textScale = v;
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Transform.translate(
                                  offset: const Offset(7.5, -5),
                                  child: Transform.rotate(
                                    angle: (pi / 180) * 30,
                                    child: Text(
                                      "verySmall".tr(context),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 8),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Transform.translate(
                                  offset: const Offset(7.5, -5),
                                  child: Transform.rotate(
                                    angle: (pi / 180) * 30,
                                    child: Text(
                                      "small".tr(context),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Transform.translate(
                                  offset: const Offset(7.5, -5),
                                  child: Transform.rotate(
                                    angle: (pi / 180) * 30,
                                    child: Text(
                                      "normal".tr(context),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Transform.translate(
                                  offset: const Offset(15, -5),
                                  child: Transform.rotate(
                                    angle: (pi / 180) * 30,
                                    child: Text(
                                      "large".tr(context),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Transform.translate(
                                  offset: const Offset(18, -5),
                                  child: Transform.rotate(
                                    angle: (pi / 180) * 30,
                                    child: Text(
                                      "veryLarge".tr(context),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      items: _sizes.keys
                          .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          labelStyle: _getStyle(
                            context,
                            settings.textScale == e,
                          ),
                          label: Text(
                            (_sizes[e] ?? "normal").tr(context),
                            textScaleFactor: e,
                          ),
                          selected: settings.textScale == e,
                          onSelected: (selected) {
                            settings.textScale = e;
                            settings.expandedIndex = null;
                          },
                        ),
                      ))
                          .toList(),
                      onToggle: () {
                        if (settings.expandedIndex == 3) {
                          settings.expandedIndex = null;
                        } else {
                          settings.expandedIndex = 3;
                        }
                      },
                      isExpanded: settings.expandedIndex == 3,
                      subtitle: _sizes[settings.textScale] ?? "normal",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SectionTitle("languageNInput".tr(context)),
                SettingItem(
                  title: "language",
                  icon: Remix.translate_2,
                  items: _languages.keys
                      .map((e) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      labelStyle: _getStyle(
                        context,
                        settings.locale?.languageCode == e,
                      ),
                      label: Text((_languages[e] ?? "systemDefault")
                          .tr(context)),
                      selected: settings.locale?.languageCode == e,
                      onSelected: (selected) {
                        settings.locale = e == null ? null : Locale(e);
                        settings.expandedIndex = null;
                      },
                    ),
                  ))
                      .toList(),
                  onToggle: () {
                    if (settings.expandedIndex == 4) {
                      settings.expandedIndex = null;
                    } else {
                      settings.expandedIndex = 4;
                    }
                  },
                  isExpanded: settings.expandedIndex == 4,
                  subtitle: _languages[settings.locale?.languageCode] ??
                      "systemDefault",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingItem extends StatelessWidget {
  final bool isExpanded;
  final String title;
  final String subtitle;
  final List<Widget> items;
  final Widget? child;
  final VoidCallback? onToggle;
  final IconData? icon;

  const SettingItem({
    Key? key,
    this.isExpanded = false,
    required this.title,
    required this.subtitle,
    this.onToggle,
    this.icon,
    required this.items,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title.tr(context),
            textScaleFactor: 1.1,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          visualDensity: VisualDensity.compact,
          onTap: onToggle,
          leading: Icon(
            icon ?? Icons.text_fields,
            color: Theme.of(context).colorScheme.secondary,
          ),
          trailing: ExpandIcon(
            onPressed: null,
            isExpanded: isExpanded,
          ),
          subtitle: Text(
            subtitle.tr(context),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          secondChild: Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: child ?? Wrap(children: items),
            ),
            alignment: Alignment.centerLeft,
          ),
          crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

class AppSettingsOption<T> {
  final T value;
  final String title;

  AppSettingsOption(this.value, this.title);
}
