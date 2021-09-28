import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../controllers/user_controller.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  final Function onOTPSelected;
  final Function onLogInSelected;
  UserController con;
  ForgotPassword({@required this.onOTPSelected,this.onLogInSelected, this.con});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(17),
      child: Center(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.7
                    : size.height > 670
                        ? 0.8
                        : 0.9),
            width:520,
            color: loginBgGreyColor,
            child: Form(
              key: widget.con.loginFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(size.width > 670 ? 30 : 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: double.infinity,

                          // margin: EdgeInsets.symmetric(horizontal: 100),
                          child: Image(
                            image: AssetImage('assets/buysmartranst.png'),
                            fit: BoxFit.contain,
                          )),
                      Text(
                        "Master",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 30,
                        child: Divider(
                          color: loginBgColor,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        onSaved: (input) => widget.con.userData.email = input,
                        validator: (input) => !input.contains('@') ? S.of(context).should_be_valid_email : null,
                        decoration: InputDecoration(
                          hintText: S.of(context).email,
                          labelText: S.of(context).email,
                          suffixIcon: Icon(
                            Icons.mail_outline,
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 64,
                      ),
                      InkWell(
                        onTap: () {
                          widget.onOTPSelected();
                         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => A4printer()));
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: loginBgColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: loginBgColor.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'SEND OTP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),


                      Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 8,
                        children: [

                          GestureDetector(
                            onTap: () {
                             widget.onLogInSelected();
                            },
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Back',
                                  style: TextStyle(
                                    color: loginBgColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: loginBgColor,
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}
