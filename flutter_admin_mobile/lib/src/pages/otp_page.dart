import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../controllers/user_controller.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'dart:math' as math;
// ignore: must_be_immutable
class OtpPage extends StatefulWidget {
  final Function onLogInSelected;
  UserController con;
  OtpPage({@required this.onLogInSelected, this.con});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage>with TickerProviderStateMixin {
  AnimationController controller1;

  bool isPlaying = true;

  String get timerString {
    Duration duration = controller1.duration * controller1.value;
    String timer = '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    if (timer == '0:00') {
      isPlaying = false;
    }
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 300),
    );

    controller1.reverse(from: controller1.value == 0.0 ? 1.0 : controller1.value);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(17),
      child: Center(
        child: Card(
          elevation: 4,
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
            color: Theme.of(context).primaryColor,
            child:Center(
                child: Padding(
                  padding: EdgeInsets.all(size.width > 670 ? 30 : 20),

                 /* login start  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 30,
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        onSaved: (input) => widget.con.userData.email = input,
                        validator: (input) => !input.contains('@') ? 'Should be valid email' : null,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          suffixIcon: Icon(
                            Icons.mail_outline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        onSaved: (input) => widget.con.userData.password = input,
                        validator: (input) =>  input.length<= 1 ? 'Invalid Password' : null,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: Icon(
                            Icons.lock_outline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      InkWell(
                        onTap: () {
                          widget.con.login();

                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Login',
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
                          Text(
                            "You do not have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              widget.onSignUpSelected();
                            },
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                  login end */

                 /* otp widget start */
                  child: Column(
                    children: [
                      Expanded(
                        child:SingleChildScrollView(
                        child:Column(
                          children: [
                            Align(
                              alignment: FractionalOffset.center,
                              child: Container(
                                height: 200,width:200,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: AnimatedBuilder(
                                        animation: controller1,
                                        builder: (BuildContext context, Widget child) {
                                          return CustomPaint(
                                              painter: TimerPainter(
                                                animation: controller1,
                                                backgroundColor: Theme.of(context).dividerColor,
                                                color: themeData.indicatorColor,
                                              ));
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: FractionalOffset.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          AnimatedBuilder(
                                              animation: controller1,
                                              builder: (BuildContext context, Widget child) {
                                                return Text(
                                                  timerString,
                                                  style: themeData.textTheme.headline1,
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Text("OTP Verification", style: Theme.of(context).textTheme.subtitle1),
                            SizedBox(height: 10.0),
                            Text("Enter the otp send to +81 96466 78905",
                                textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.grey[400])),
                            SizedBox(height: 40),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: SingleChildScrollView(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: OTPTextField(
                                          length: 4,
                                          width: MediaQuery.of(context).size.width,
                                          textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                          fieldWidth: 40,
                                          style: TextStyle(fontSize: 20),
                                          fieldStyle: FieldStyle.underline,
                                          onCompleted: (pin) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: isPlaying
                                  ? Text('$isPlaying')
                                  : GestureDetector(
                                onTap: () {
                                  setState(() => isPlaying = true);
                                  if (controller1.isAnimating) {
                                    controller1.stop(canceled: true);
                                  } else {
                                    controller1.reverse(from: controller1.value == 0.0 ? 1.0 : controller1.value);
                                  }
                                },
                                child: Text("Dont Recieve OTP? RESEND OTP",
                                    textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.black)),
                              ),

                              // Icon(isPlaying
                              // ? Icons.pause
                              // : Icons.play_arrow);
                            ),


                          ],
                        ),
            ),
                      ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        // ignore: deprecated_member_use
                        child:RaisedButton(
                          onPressed: () {
                            // Navigator.of(context).pushNamed('/SignUp', );
                          },
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                color:Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(maxWidth:double.infinity, minHeight: 45.0),
                              alignment: Alignment.center,
                              child: Text("VERIFY",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline3.merge(TextStyle(color: Theme.of(context).primaryColorLight))),
                            ),
                          ),
                        ),
                      ),
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
                                color: kPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /* otp widget end */
                ),

            ),

          ),
        ),
      ),
    );
  }
}


class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value || color != old.color || backgroundColor != old.backgroundColor;
  }
}
