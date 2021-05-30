import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pin_put/pin_put.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
PhoneNumber? phoneno;
String? otp;
bool showLoading = false;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String? verificationId;
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential = _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if ((authCredential.then((value) => value.user)) != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  getMobileFormWidget(context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InternationalPhoneNumberInput(
            onInputChanged: (value) {
              phoneno = value;
            },
            cursorColor: Colors.red,
            inputDecoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: "Enter Phone Number"),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            autoFocus: true,
            selectorConfig: SelectorConfig(
              showFlags: true,
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () async {
              setState(() {
                showLoading = true;
              });

              await _auth.verifyPhoneNumber(
                  phoneNumber: phoneno!.phoneNumber!,
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      showLoading = false;
                    });
                  },
                  verificationFailed: (verificationFailed) async {
                    _scaffoldKey.currentState!.showSnackBar(
                        SnackBar(content: Text(verificationFailed.message!)));
                  },
                  codeSent: (verificationId, resendingToken) async {
                    setState(() {
                      showLoading = false;
                      currentState =
                          MobileVerificationState.SHOW_OTP_FORM_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) async {});
            },
            child: Text("Verify"),
          ),
        ],
      ),
    );
  }

  getOtpFormWidget(context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        children: [
          PinPut(
            fieldsCount: 6,
            onChanged: (value) {
              otp = value;
              print(otp);
            },
            submittedFieldDecoration: BoxDecoration(
              color: const Color.fromRGBO(235, 236, 237, 1),
              borderRadius: BorderRadius.circular(5.0),
            ),
            followingFieldDecoration: BoxDecoration(
              color: const Color.fromRGBO(235, 236, 237, 1),
              borderRadius: BorderRadius.circular(5.0),
            ),
            selectedFieldDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              border: Border.all(
                width: 2,
                color: const Color.fromRGBO(160, 215, 220, 1),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId!, smsCode: otp!);
                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: Text("Verify"))
        ],
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Secured Messaging"),
              backgroundColor: Colors.red,
            ),
            body: showLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                    ? getMobileFormWidget(context)
                    : getOtpFormWidget(context)));
  }
}
