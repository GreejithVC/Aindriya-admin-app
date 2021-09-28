import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../controllers/user_controller.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vrouter/vrouter.dart';
import 'forgot_password.dart';
import 'login.dart';
import '../../generated/l10n.dart';

import 'otp_page.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  Option selectedOption = Option.LogIn;
  UserController _con;
  _HomePageState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout(context));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      key: _con.scaffoldKeyState,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Row(
              children: [
                Container(height: double.infinity, width: size.width / 2, color:loginBgGreyColor),
                Container(height: double.infinity, width: size.width / 2, color:loginBgGreyColor),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's Kick Now !",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "It's easy and takes less than 30 seconds",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'MULTI SUPERSTORE' ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Icon(
                  Icons.menu,
                  color: Theme.of(context).primaryColorDark,
                  size: 28,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),

              //Animation 1
              //transitionBuilder: (widget, animation) => RotationTransition(
              //  turns: animation,
              //  child: widget,
              //),
              //switchOutCurve: Curves.easeInOutCubic,
              //switchInCurve: Curves.fastLinearToSlowEaseIn,

              //Animation 2
              transitionBuilder: (widget, animation) => ScaleTransition(child: widget, scale: animation),

              child: selectedOption == Option.LogIn
                  ? LogIn(
                      onSignUpSelected: () {
                        setState(() {
                          selectedOption = Option.forgot;
                        });
                      },
                      con: _con,
                    )
                  :    selectedOption == Option.forgot ?ForgotPassword(
            onOTPSelected: () {
    setState(() {
    selectedOption = Option.otp;
    });

    },
                onLogInSelected: () {
                  setState(() {
                    selectedOption = Option.LogIn;
                  });

                },
      con: _con,
    ):selectedOption == Option.otp ? OtpPage(
    onLogInSelected: () {
    setState(() {
    selectedOption = Option.LogIn;
    });

    },
    con: _con,
    ):Container()

            )],
        ),
      ),
    );


  }

  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout

    if(currentUser.value.auth==true) {
      // ignore: deprecated_member_use
      VRouter.of(context).pushReplacement('/dashboard');
    }
  }
}
