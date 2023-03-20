import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:ticaret/firebase_options.dart';
import 'package:ticaret/screens/checkout.dart';
import 'package:ticaret/screens/home.dart';
import 'package:ticaret/screens/login.dart';
import 'package:ticaret/screens/profile.dart';
import 'package:ticaret/utils/application_state.dart';
import 'package:ticaret/utils/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final String response =
  await rootBundle.loadString("assets/config/stripe.json");
  final data = await json.decode(response);
  Stripe.publishableKey = data["publishableKey"];

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, _) =>
        Consumer<ApplicationState>(
          builder: (context, applicationState, _) {
            Widget child;
            switch (applicationState.loginState) {
              case ApplicationLoginState.loggedOut:
                child = LoginScreen();
                break;
              case ApplicationLoginState.loggedIn:
                child = MyApp();
                break;
              default:
                child = LoginScreen();
            }
            return MaterialApp(theme: CustomTheme.getTheme(), home: child);
          },
        ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("CIXOL"),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)),
              boxShadow: CustomTheme.cardShadow),
          child: const TabBar(
              padding: EdgeInsets.symmetric(vertical: 10),
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.shopping_cart)),
              ]),
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            ProfileScreen(),
            CheckoutScreen(),
          ],
        ),
      ),
    );
  }
}



