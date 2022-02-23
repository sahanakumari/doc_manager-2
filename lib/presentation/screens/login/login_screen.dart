import 'dart:async';
import 'package:doc_manager/core/services/extensions.dart';
import 'package:doc_manager/core/services/logger.dart';
import 'package:doc_manager/core/services/session_helper.dart';
import 'package:doc_manager/core/services/utils.dart';
import 'package:doc_manager/core/services/validators.dart';
import 'package:doc_manager/data/app_data/app_styles.dart';
import 'package:doc_manager/data/models/country.dart';
import 'package:doc_manager/presentation/bloc/Login/login_bloc.dart';
import 'package:doc_manager/presentation/widgets/components.dart';
import 'package:doc_manager/presentation/widgets/forms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:remixicon/remixicon.dart';

import '../home/home_screen.dart';

String verificationId = "";

class LoginScreen extends StatefulWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  String _mobile = "";
  bool _processing = false;
  bool _otpSent = false;

  final FocusNode _otpNode = FocusNode();

  _mobileFieldListener() => setState(() {
    _mobile = _mobileController.text;
  });

  @override
  void initState() {
    _mobileController.addListener(_mobileFieldListener);
    _otpController.addListener(_otpFieldListener);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    _otpNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  _init() async {
    await Firebase.initializeApp();
    auth = FirebaseAuth.instance;
  }

  bool get _isMobileEntered {
    var pattern = RegExp(Validators.kMobileRegex);
    if (pattern.hasMatch(_mobile)) return true;
    return false;
  }

  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  FirebaseAuth? auth;

  late String _verificationId;

  int _timeLeft = 120;
  Timer? _timer;

  _resetTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        --_timeLeft;
      });
      if (_timeLeft <= 0) timer.cancel();
    });
  }



  _verify() async {

    if(SessionHelper.sessionUser != null && SessionHelper.sessionUser!.mobile !=null)
    {
      NavUtils.scaleTo(context, const HomeScreen(), true);
    }
    else {
      setState(() {
        _processing = true;
      });

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: _otp);
      try {
        var user = await auth?.signInWithCredential(credential);
        auth?.userChanges().listen((user) {
          if (user == null) {
            _showMessage("failedToVerify".tr(context));
          } else {
            SessionHelper.sessionUser = SessionUser(user.uid, user.phoneNumber);
            NavUtils.scaleTo(context, const HomeScreen(), true);
          }
        });
      } catch (e) {
        if (e is FirebaseAuthException) {
          _showMessage(e.message ?? "somethingWrong".tr(context));
        }
      }

      setState(() {
        _processing = false;
      });
    }
  }

  _showMessage(message) {
    NavUtils.showSnackBar(
      message,
      context: context,
      key: _key,
    );
  }

  final _key = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          return ScaffoldMessenger(
            key: _key,
            child: Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              body: SafeArea(
                child: Center(
                  child:
                  snapshot.hasData
                      ?
                  SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: BlocConsumer(
                        bloc: BlocProvider.of<LoginBloc>(context),
                        listener: (context, state) {
                          if (state is LoginError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          } else if (state is UserAuthenticated){
                            _otpSent = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP sent.. "),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          appLog(state ?? "");

                          return _otpSent
                              ? _buildVerificationScreen(context)
                              : _buildInputScreen(context);
                        },

                      ),
                    ),
                  )
                      : snapshot.hasError
                      ? ErrorContainer(
                    onRetryTap: () {},
                  )
                      : const RefreshProgressIndicator(),
                ),
              ),
            ),
          );
        });
  }

  Country _country = Country.india;

  _buildInputScreen(BuildContext context) {
    return Column(
      children: [
        AppIcon(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white30,
        ),
        Text(
          "enterMobile".tr(context).toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.white),
        ),
        SizedBox(height: 20),
        Theme(
          data: Theme.of(context).copyWith(
            hintColor: Colors.white30,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          child: TextField(
            controller: _mobileController,
            style: Theme.of(context).textTheme.headline4?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(16),
              FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
            ],
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              hintText: "mobileNumber".tr(context),
              prefixIcon: PopupMenuButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        _country.extension,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primary,
                        ),
                      ),
                    ),
                    Icon(
                      Remix.arrow_down_s_line,
                      size: 32,
                      color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    ),
                  ],
                ),
                onSelected: (Country v) {
                  setState(() {
                    _country = v;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return DataUtils.countries
                      .map(
                        (e) => PopupMenuItem(value: e, child: Text("$e")),
                  )
                      .toList();
                },
              ),
              suffixIcon: _mobile.isEmpty
                  ? null
                  : IconButton(
                onPressed: _mobileController.clear,
                icon: const Icon(Remix.close_circle_line),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "enterMobileDesc".tr(context),
          textScaleFactor: 1.1,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white),
        ),
        SizedBox(height: 20),
        FractionallySizedBox(
          widthFactor: 1,
          child: SElevatedButton(
            onPressed: _isMobileEntered
                ? () {
              if(_mobileController.text.length == 10)
              {
                BlocProvider.of<LoginBloc>(context).add( AuthenticateUserEvent(_mobileController.text));
              }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter valid number"),
                    ),
                  );
                }


            }
                : null,
            child: _processing
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CupertinoActivityIndicator(),
                const SizedBox(width: 10),
                Flexible(child: Text("sendingOtp".tr(context))),
              ],
            )
                : Text(
              "sendOtp".tr(context),
            ),
          ),
        )
      ],
    );
  }

  final TextEditingController _otpController = TextEditingController();
  String _otp = "";
  bool _agreedToTerms = false;

  _otpFieldListener() => setState(() {
    _otp = _otpController.text;
  });

  bool get _canSubmit => _otp.length == 6 && _agreedToTerms;

  _buildVerificationScreen(BuildContext context) {
    var linkTextStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(color: Theme.of(context).colorScheme.secondary);
    var linkTextStyleDisabled = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(color: Theme.of(context).hintColor);
    return Column(
      children: [
        AppIcon(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white30,
        ),
        Text(
          "enterVerificationCode".tr(context).toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.white),
        ),
        SizedBox(height: 20),
        PinPut(
          controller: _otpController,
          focusNode: _otpNode,
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
          ],
          textStyle: Theme.of(context).textTheme.headline4?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          fieldsCount: 6,
          inputDecoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            counterText: "",
          ),
          preFilledWidget: const Text(
            "-",
            style: TextStyle(
              color: Colors.white24,
            ),
          ),
          submittedFieldDecoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(AppTheme.kRadius),
          ),
          selectedFieldDecoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(
                AppTheme.kRadius),
          ),
          followingFieldDecoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(AppTheme.kRadius),
          ),
        ),
        SizedBox(height: 10),
        RichText(
          textScaleFactor: 1.1,
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white),
            children: [
              TextSpan(
                text: "enterVerificationCodeDesc"
                    .tr(context, {"mobile": _mobile}),
              ),
              const TextSpan(text: " "),
              if (_timeLeft > 0)
                TextSpan(
                  text: "resendIn".tr(context, {"min": _timeLeft}),
                  style: linkTextStyleDisabled,
                )
              else
                TextSpan(
                    text: "resend".tr(context),
                    style: linkTextStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // _sendCode();
                      }),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Checkbox(
              value: _agreedToTerms,
              onChanged: (bool? v) {
                setState(() {
                  _agreedToTerms = v ?? false;
                });
              },
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                  children: [
                    TextSpan(text: "iAgreeToThe".tr(context)),
                    TextSpan(
                      text: "termsOfUse".tr(context),
                      style: linkTextStyle,
                    ),
                    TextSpan(text: "and".tr(context)),
                    TextSpan(
                        text: "privacyPolicy".tr(context),
                        style: linkTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Privacy policy");
                          }),
                  ],
                ),
              ),
            ),
          ],
        ),
        FractionallySizedBox(
          widthFactor: 1,
          child: SElevatedButton(
            onPressed: _canSubmit ? _verify : null,
            child: _processing
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CupertinoActivityIndicator(),
                const SizedBox(width: 10),
                Flexible(child: Text("loggingIn".tr(context))),
              ],
            )
                : Text(
              "login".tr(context),
            ),
          ),
        )
      ],
    );
  }
}
