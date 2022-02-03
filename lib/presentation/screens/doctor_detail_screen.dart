import 'package:doc_manager/core/utils/app_styles.dart';
import 'package:doc_manager/core/utils/extensions.dart';
import 'package:doc_manager/core/utils/network_n_storage/db_helper.dart';
import 'package:doc_manager/core/utils/utils.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/presentation/bloc/Profile/profile_bloc.dart';
import 'package:doc_manager/presentation/widgets/s_buttons.dart';
import 'package:doc_manager/presentation/widgets/s_card.dart';
import 'package:doc_manager/presentation/widgets/s_inputs.dart';
import 'package:doc_manager/presentation/widgets/section_title.dart';
import 'package:doc_manager/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final Doctor doctor;
  final String? tag;

  const DoctorDetailsScreen({Key? key, required this.doctor, this.tag})
      : super(key: key);

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  bool _updated = false;
  late Doctor _doctor;
  bool _isEditMode = false;
  bool _almostCollapsed = false;
  final ScrollController _scrollController = ScrollController();
  String? _gender;
  String? _bloodGroup;
  String? _dob;

  @override
  void initState() {
    _doctor = widget.doctor;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _fillDetails(_doctor);
    });
    DbHelper().getDoctor(_doctor.id).then((value) {
      if (value is Doctor) {
        setState(() {
          _doctor = value;
        });
        if (mounted) _fillDetails(_doctor);
      }
    });
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _dobCtrl.dispose();
    _mobileCtrl.dispose();
    _genderCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _bloodGroupCtrl.dispose();
    super.dispose();
  }

  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _genderCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();
  final TextEditingController _weightCtrl = TextEditingController();
  final TextEditingController _bloodGroupCtrl = TextEditingController();
  final _key = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var _avatarSize = width / 2.5;
    var _linearFactor = 0.5;
    if (width >= 400) _linearFactor = 0.33;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, _updated);
        return Future.value(false);
      },
      child: BlocListener(
        bloc: BlocProvider.of<ProfileBloc>(context),
        listener: (context, state) {
          if (state is DataLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Data has been updated."),
              ),
            );
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          }
        },
        child: Scaffold(
          body: NestedScrollView(
            controller: _scrollController,
            body: _buildBody(context, _linearFactor),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [_buildAppBar(context, _avatarSize)];
            },
          ),
          bottomNavigationBar: _isEditMode
              ? _buildBottomButtons(
                  context,
                )
              : null,
        ),
      ),

    );
  }

  _buildBottomButtons(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              isSecondary: true,
              child: Text(
                "cancel".tr(context),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SElevatedButton(
              onPressed: () {
                Doctor updatedData = _doctor.copyWith(
                  firstName: _firstNameCtrl.text.trim(),
                  lastName: _lastNameCtrl.text.trim(),
                  gender: _gender,
                  primaryContactNo: _mobileCtrl.text.trim(),
                  dob: _dobCtrl.text.trim(),
                  height: _heightCtrl.text.trim(),
                  weight: _weightCtrl.text.trim(),
                  bloodGroup: _bloodGroup,
                );

                BlocProvider.of<ProfileBloc>(context).add(SaveData(updatedData));
              },
              child: Text(
                "save".tr(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context, double avatarSize) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: _almostCollapsed ? Theme.of(context).canvasColor : null,
      title: _almostCollapsed ? Text(_doctor.name) : null,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context, _updated);
        },
        icon: Icon(
          Remix.arrow_left_s_line,
          color: _almostCollapsed ? null : Colors.white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: double.maxFinite,
              height: double.maxFinite,
              margin: EdgeInsets.only(bottom: avatarSize / 3),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: widget.tag ?? "avatar",
                child: SizedBox(
                  width: avatarSize,
                  height: avatarSize,
                  child: Stack(
                    children: [
                      SCard(child: _doctor.avatar),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Material(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(AppTheme.kRadius),
                            topLeft: Radius.circular(AppTheme.kRadius),
                          ),

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
      expandedHeight: avatarSize * 1.5,
    );
  }

  _buildBody(BuildContext context, double factor) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                _doctor.name,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
            Center(
              child: Text(
                _doctor.specialization ?? 'n/a',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
            Center(child: RatingBar(rating: _doctor.ratingNum, size: 20)),
            if (!_isEditMode)
              Center(
                child: SElevatedButton(
                  child: Text("editProfile".tr(context)),
                  onPressed: _onEditTap,
                ),
              ),
            SectionTitle("personalDetails".tr(context)),
            SFormInput(
              hint: "enterFirstName".tr(context),
              label: "firstName".tr(context),
              controller: _firstNameCtrl,
              enabled: _isEditMode,
              suffixIcon: const Icon(Remix.user_3_line),
              validator: (v) {
                if (v?.isEmpty ?? true) {
                  return "firstNameRequired".tr(context);
                }
                return null;
              },
            ),
            SFormInput(
              hint: "enterLastName".tr(context),
              label: "lastName".tr(context),
              enabled: _isEditMode,
              controller: _lastNameCtrl,
              suffixIcon: const Icon(Remix.user_3_line),
            ),
            if (_isEditMode)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "gender".tr(context),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                    Wrap(
                      children: DataUtils.genders
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 7.5),
                              child: ChoiceChip(
                                label: Text(e.tr(context)),
                                selected: _gender == e,
                                onSelected: (v) {
                                  setState(() {
                                    _gender = e;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              )
            else
              SFormInput(
                hint: "selectGender".tr(context),
                label: "gender".tr(context),
                enabled: _isEditMode,
                suffixIcon: const Icon(Remix.men_line),
                controller: _genderCtrl,
              ),
            SFormInput(
              hint: "enterMobileNumber".tr(context),
              label: "mobileNumber".tr(context),
              controller: _mobileCtrl,
              enabled: false,
              validator: (v) {
                if (v?.isEmpty ?? true) {
                  return "mobileNumberRequired".tr(context);
                }
                return null;
              },
              suffixIcon: const Icon(Remix.smartphone_line),
            ),
            InkWell(
              onTap: _isEditMode ? _selectDate : null,
              child: SFormInput(
                hint: "enterDateOfBirth".tr(context),
                label: "dateOfBirth".tr(context),
                controller: _dobCtrl,
                enabled: false,
                forcedBorder: _isEditMode,
                suffixIcon: const Icon(Remix.calendar_2_line),
              ),
            ),
            Wrap(
              children: [
                FractionallySizedBox(
                  widthFactor: factor,
                  child: _isEditMode
                      ? SFormSelect(
                          hint: "selectBloodGroup".tr(context),
                          label: "bloodGroup".tr(context),
                          enabled: _isEditMode,
                          value: _bloodGroup,
                          onChanged: (v) {
                            setState(() {
                              _bloodGroup = v;
                            });
                          },
                          suffixIcon: const Icon(Remix.arrow_down_s_line),
                          items: DataUtils.bloodGroups
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                        )
                      : SFormInput(
                          hint: "selectBloodGroup".tr(context),
                          label: "bloodGroup".tr(context),
                          controller: _bloodGroupCtrl,
                          enabled: _isEditMode,
                          suffixIcon: const Icon(Remix.ruler_line),
                        ),
                ),
                FractionallySizedBox(
                  widthFactor: factor,
                  child: SFormInput(
                    hint: "enterHeight".tr(context),
                    label: "height".tr(context),
                    controller: _heightCtrl,
                    enabled: _isEditMode,
                    suffixIcon: const Icon(Remix.ruler_line),
                    validator: (v) {
                      if (v?.isNotEmpty ?? false) {
                        try {
                          if (v != null) double.parse(v);
                        } catch (e) {
                          return "invalidNumberValue".tr(context);
                        }
                      }
                      return null;
                    },
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: factor,
                  child: SFormInput(
                    hint: "enterWeight".tr(context),
                    label: "weight".tr(context),
                    controller: _weightCtrl,
                    enabled: _isEditMode,
                    validator: (v) {
                      if (v?.isNotEmpty ?? false) {
                        try {
                          if (v != null) double.parse(v);
                        } catch (e) {
                          return "invalidNumberValue".tr(context);
                        }
                      }
                      return null;
                    },
                    suffixIcon: const Icon(Remix.scales_3_line),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  _selectDate() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTheme.kRadius),
          ),
        ),
        builder: (_) {
          return SizedBox(
            height: 240,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle:
                      Theme.of(context).textTheme.bodyText1,
                ),
              ),
              child: CupertinoDatePicker(
                onDateTimeChanged: (date) {
                  setState(() {
                    _dob = DateUtils.dateOnly(date).toIso8601String();
                  });
                  _dobCtrl.text = DateTimeUtils.dateFormatted(_dob);
                },
                initialDateTime: DateTime.tryParse(_dob ?? "") ??
                    DateTime.now().add(
                      const Duration(days: -(18 * 365)),
                    ),
                minimumDate: DateTime.now().add(
                  const Duration(days: -(100 * 365)),
                ),
                maximumDate: DateTime.tryParse(_dob ?? "") ??
                    DateTime.now().add(
                      const Duration(days: -(18 * 365)),
                    ),
                mode: CupertinoDatePickerMode.date,
              ),
            ),
          );
        });
  }



  void _scrollListener() {
    var position = _scrollController.offset;
    setState(() {
      if (position >= 160) {
        _almostCollapsed = true;
      } else {
        _almostCollapsed = false;
      }
    });
  }

  _fillDetails(Doctor doctor) {
    _firstNameCtrl.text = _doctor.firstName ?? "unknownExt".tr(context);
    _lastNameCtrl.text = _doctor.lastName ?? "unknownExt".tr(context);
    _gender = _doctor.gender;
    _bloodGroup = _doctor.bloodGroup;
    _genderCtrl.text = _doctor.gender?.tr(context) ?? "unknownExt".tr(context);
    _dobCtrl.text = _doctor.dob ?? "unknownExt".tr(context);
    _mobileCtrl.text = _doctor.primaryContactNo ?? "unknownExt".tr(context);
    _heightCtrl.text = _doctor.height ?? "unknownExt".tr(context);
    _weightCtrl.text = _doctor.weight ?? "unknownExt".tr(context);
    _bloodGroupCtrl.text = _doctor.bloodGroup ?? "unknownExt".tr(context);
  }

  _clearIfEmpty() {
    var ctrls = [
      _firstNameCtrl,
      _lastNameCtrl,
      _dobCtrl,
      _mobileCtrl,
      _genderCtrl,
      _heightCtrl,
      _weightCtrl
    ];
    for (var element in ctrls) {
      if (element.text == "unknownExt".tr(context)) {
        element.clear();
      }
    }
  }

  void _onEditTap() {
    setState(() {
      _isEditMode = true;
    });
    _clearIfEmpty();
  }
}
