import 'dart:io';
import 'package:login_and_signup_web/src/elements/AppDrawer.dart';
import 'package:login_and_signup_web/src/pages/Orders.dart';
import 'package:login_and_signup_web/src/pages/package_type.dart';
import 'package:login_and_signup_web/src/pages/payment_gateway.dart';

import 'src/pages/currency.dart';
import 'src/pages/delivery_doy.dart';
import 'src/pages/delivery_tips.dart';
import 'src/pages/dialogs.dart';
import 'src/pages/general_settings.dart';
import 'src/pages/dashboard.dart';
import 'src/pages/custom_switch.dart';
import 'src/pages/delivery_fees.dart';
import 'src/pages/profile.dart';
import 'src/pages/push_notification.dart';
import 'src/pages/report.dart';
import 'src/pages/shop_type.dart';
import 'src/pages/slip.dart';
import 'package:global_configuration/global_configuration.dart';
import 'src/pages/user.dart';
import 'src/repository/settings_repository.dart';
import 'generated/l10n.dart';
import 'src/models/setting.dart';
import 'src/repository/settings_repository.dart' as settingRepo;
import 'src/repository/user_repository.dart' as userRepo;
import 'package:flutter/material.dart';
import 'src/elements/InvoiceWidget.dart';

import 'src/pages/banners.dart';
import 'src/pages/home.dart';
import 'src/pages/languages.dart';
import 'src/pages/vendor_list.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await GlobalConfiguration().loadFromAsset("configurations");
  //print(CustomTrace(StackTrace.current, message: "base_url: ${GlobalConfiguration().getString('base_url')}"));
  //print(CustomTrace(StackTrace.current, message: "api_base_url: ${GlobalConfiguration().getString('api_base_url')}"));
  //HttpOverrides.global = new MyHttpOverrides();

  settingRepo.initSettings();
  userRepo.getCurrentUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void initState() {



  }

  Future<void> authenticationCheck(BuildContext context, { VRedirector vRedirector}) async {
   print('check log ${userRepo.currentUser.value.auth}');
    if (userRepo.currentUser.value.auth!=true) {
      // ignore: deprecated_member_use
      vRedirector.push('/login', queryParameters: {'redirectedFrom': '${vRedirector.to}'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingRepo.setting,

        builder: (context, Setting _setting, _) {
          return VRouter(
            title: 'Master',
            locale: _setting.mobileLanguage.value,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: _setting.brightness.value == Brightness.light
                ?ThemeData(
              fontFamily: 'proximanova-regular',
              primaryColor: Colors.white,
              disabledColor: Colors.grey,
              cardColor: Colors.white,
              secondaryHeaderColor: Color(0xFF043832).withOpacity(1.0),
              brightness: Brightness.light,

              primaryColorLight: Colors.white,
              backgroundColor: Colors.white,
              //accentColor: Color(0xFFFc8019),
              accentColor: Color(0xFF180968).withOpacity(1.0),
              dividerColor: Color(0xFF8c98a8).withOpacity(0.1),
              focusColor: Color(0xFF8c98a8).withOpacity(1.0),
              primaryColorDark: Color(0xFF180968),

              textTheme: TextTheme(
                headline5: TextStyle(fontSize: 22.0, color: Color(0xFF043832).withOpacity(1.0), height: 1.3),
                headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Color(0xFF043832).withOpacity(1.0), height: 1.3),
                headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Color(0xFF043832).withOpacity(1.0), height: 1.3),
                headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Color(0xFF180968).withOpacity(1.0), height: 1.4),
                headline1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Color(0xFF043832).withOpacity(1.0), height: 1.4),
                subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.3),
                subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Color(0xFF043832).withOpacity(1.0), height: 1.2),
                headline6: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700, color: Color(0xFF180968).withOpacity(1.0), height: 1.3),
                bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.2),
                bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xFF043832).withOpacity(1.0), height: 1.3),
                caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: Color(0xFF8c98a8).withOpacity(1.0), height: 1.7),
              ),
            ): ThemeData(
              fontFamily: 'proximanova-regular',
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Color(0xFF2C2C2C),
              primaryColorLight: Colors.white,
              primaryColor: Color(0xFF2C2C2C),

              //accentColor: Color(0xFFFc8019),
              accentColor: Color(0xFF180968).withOpacity(1.0),
              dividerColor: Color(0xFF9999aa).withOpacity(0.1),
              hintColor: Color(0xFFccccdd).withOpacity(0.1),
              focusColor: Color(0xFF9999aa).withOpacity(1),
              primaryColorDark: Color(0xFF180968),
              textTheme: TextTheme(
                headline5: TextStyle(fontSize: 22.0, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Color(0xFF180968).withOpacity(1.0), height: 1.4),
                headline1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Color(0xFFffffff).withOpacity(1), height: 1.4),
                subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Color(0xFF9999aa).withOpacity(1), height: 1.2),
                headline6: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700, color: Color(0xFF180968).withOpacity(1.0), height: 1.3),
                bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFF9999aa).withOpacity(1), height: 1.2),
                bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Color(0xFF9999aa).withOpacity(0.6), height: 1.2),
              ),
            ),
            debugShowCheckedModeBanner: false,
            routes: [
              VWidget(path: '/login', widget: HomePage()),
              VGuard(
                beforeEnter: (vRedirector) =>
                    authenticationCheck(context, vRedirector: vRedirector),
                stackedRoutes: [
                  VPopHandler(
                    onPop: (_) async => print('POP'),
                    stackedRoutes: [

                      VNester(
                        path: null,
                        name: 'VNester1',
                        widgetBuilder: (child) => MyScaffold(
                          child,
                          title: 'VNester1',
                        ),
                        nestedRoutes: [


                          VWidget(
                            path: '/currency',
                            name: 'currency',
                            widget: CurrencyPage(),
                            aliases: ['/currency'],
                          ),

                          VWidget(
                            path: '/push_notification',
                            name: 'push_notification',
                            widget: PushNotification(),
                            aliases: ['/push_notification'],
                          ),


                          VWidget(
                            path: '/general_settings',
                            name: 'general_settings',
                            widget: GeneralSettings(),
                            aliases: ['/general_settings'],
                          ),

                          VWidget(
                            path: '/popup',
                            name: 'popup',
                            widget: Dialogs(),
                            aliases: ['/popup'],
                          ),
                          VWidget(
                            path: '/vendorlist',
                            name: 'vendorlist',
                            widget: VendorList(),
                            aliases: ['/vendorlist'],
                          ),
                          VWidget(
                            path: '/user',
                            name: 'user',
                            widget: User(),
                            aliases: ['/User'],
                          ),
                          VWidget(
                            path: '/shopType',
                            name: 'shopType',
                            widget: ShopTypes(),
                            aliases: ['/User'],
                          ),
                          VWidget(
                            path: '/packageType',
                            name: 'packageType',
                            widget: PackageTypes(),
                            aliases: ['/packageType'],
                          ),

                          VWidget(
                            path: '/delivery_tips',
                            name: 'delivery_tips',
                            widget: DeliveryTips(),
                            aliases: ['/delivery_tips'],
                          ),
                          VWidget(
                            path: '/dashboard',
                            name: 'dashboard',
                            widget: DashboardWidget(),
                            aliases: ['/dashboard'],
                          ),
                          VWidget(
                            path: '/Order',
                            name: 'Orders',
                            widget: Orders(),
                            aliases: ['/Orders'],
                          ),

                          VWidget(
                            path: '/payment_gateway',
                            name: 'payment_gateway',
                            widget: PaymentGateway(),
                            aliases: ['/payment_gateway'],
                          ),

                          VWidget(
                            path: '/driver',
                            name: 'driver',
                            widget: DeliveryBoy(),
                            aliases: ['/driver'],
                          ),

                          VWidget(
                            path: '/deliveryfees',
                            name: 'deliveryfees',
                            widget: DeliveryFee(),
                            aliases: ['/deliveryfees'],
                          ),

                          VWidget(
                            path: '/banner',
                            name: 'banner',
                            widget: Banners(),
                            aliases: ['/banner'],
                          ),
                          VWidget(
                            path: '/vendor',
                            name: 'vendor',
                            widget: VendorList(),
                            aliases: ['/invoice'],
                          ),
                          VWidget(
                            path: '/invoice/:id',
                            name: 'invoice',
                            widget: InvoiceWidget(),
                            aliases: ['/invoice'],
                          ),


                         /** VWidget(
                            path: '/bulk_upload',
                            widget: DragDrop(),

                            // Custom transition
                          ), */
                          VWidget(
                            path: '/report',
                            widget: Report(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/profileView',
                            widget: ProfileView(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/language',
                            widget: LanguagesWidget(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/thermalSlip',
                            widget: Slip(),

                            // Custom transition
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              VRouteRedirector(
                redirectTo: '/login',
                path: r':_(.*)',
              ),

            ],);});
  }
}

// ignore: must_be_immutable
class MyScaffold extends StatelessWidget {
   Widget vChild;
   String title;

   MyScaffold(
      this.vChild, {
        Key key,
        @required this.title,
      }) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

   toggleDrawer() async {
     if (_scaffoldKey.currentState.isDrawerOpen) {
       _scaffoldKey.currentState.openEndDrawer();
     } else {
       _scaffoldKey.currentState.openDrawer();
     }}
  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;

    return WillPopScope(
      onWillPop: () async {
        print('exit');
        return false;
      },
      child: Container(
          color:Theme.of(context).primaryColor,
          child:Row(
            children: [
              if (!displayMobileLayout)
                 AppDrawer(
                  permanentlyDisplay: true,
                ),
              Expanded(
                child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    // when the app isn't displaying the mobile version of app, hide the menu button that is used to open the navigation drawer
                    automaticallyImplyLeading: displayMobileLayout,

                    backgroundColor: Theme.of(context).primaryColor,
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    title: ListTile(
                        contentPadding: EdgeInsets.only(left: 0, right: 0),
                        leading: Wrap(
                          children: [
                            Wrap(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child:Image(image: setting.value.language=='English'?
                                  AssetImage('assets/img/united-states-of-america.png'): setting.value.language=='العربية'?AssetImage('assets/img/united-arab-emirates.png'):
                                  setting.value.language=='Français - France'?AssetImage('assets/img/france.png'):
                                  setting.value.language=='Spana'?AssetImage('assets/img/spain.png'):
                                  setting.value.language=='germen - Canadien'?AssetImage('assets/img/germany.png'):
                                  setting.value.language=='Malay'?AssetImage('assets/img/malay.png'):
                                  setting.value.language=='Korean'?AssetImage('assets/img/united-states-of-america.png'):
                                  setting.value.language=='Chinese'?AssetImage('assets/img/china.png'):
                                  AssetImage('assets/img/united-states-of-america.png'), height: 20, width: 20),
                                ),

                                InkWell(
                                  onTap: () {


                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => LanguagesWidget()));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 3, left: 5),
                                    child: Text('English', style: Theme.of(context).textTheme.bodyText2),
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down,color:Colors.grey),
                              ],
                            ),

                          ],
                        ),
                      trailing:Container(child: Text(userRepo.currentUser.value.name),)

                    ),
                  ),
                  drawer: displayMobileLayout
                      ?  AppDrawer(
                    permanentlyDisplay: true,
                    callback: this.toggleDrawer,
                  )
                      : null,
                  body: vChild,
                ),
              )
            ],
          )
      ),
    );
  }
}









class SwitchOpen extends StatefulWidget {
  @override
  _SwitchOpenState createState() => _SwitchOpenState();
}

class _SwitchOpenState extends State<SwitchOpen>   {

  bool isSwitched = false;

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
      activeColor: Colors.black,
      value: status,

      onChanged: (value) {
        print("VALUE : $value");
        setState(() {
          status = value;
        });
      },
    );


    /*Wrap(
      children:[
        Padding(
          padding: EdgeInsets.only(top:13,right:6),
          child:  Text('Open'),
        ),

        GestureDetector(
          onTap: () {},

          child: Switch(
            value: isSwitched,

            onChanged: (value){
              setState(() {
                isSwitched=value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,


          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:13,left:6),
          child:  Text('Close'),
        ),
      ]
    );*/

  }
}





