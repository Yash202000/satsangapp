import 'package:satsangapp/pages/Otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController =
      TextEditingController(text: "+917083581881");
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";
  void loginWithPhone() async {
    print(phoneController.text);
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: Container(
                    // padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                    // margin: EdgeInsets.fromLTRB(0, 140, 0, 0),
                    child: Text(
                      "India's #1 Satsung \n  Streaming App",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Insert your mobile number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "+91",
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.black87),
                    ),
                    Expanded(
                      //margin: EdgeInsets.fromLTRB(60, 0, 10, 50),
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            hintText: 'Mobile Number'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade600)),
                    onPressed: () {
                      loginWithPhone();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Otp(verificationid: verificationID)));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'Get OTP',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
