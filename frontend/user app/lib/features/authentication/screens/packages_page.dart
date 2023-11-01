import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/features/authentication/services/stripe_service.dart';
import 'package:focusmi/features/authentication/widgets/packages_widget.dart';
import 'package:focusmi/features/mainpage/screens/main_page.dart';
import 'package:focusmi/features/mindfulness_courses/services/mindfulness_main_page_services.dart';

class SubscriptionPackagesPage extends StatefulWidget {
  static const String routeName = '/packages_page';
  @override
  _SubscriptionPackagesPageState createState() =>
      _SubscriptionPackagesPageState();
}

List<SubscriptionPackage> packages = [
  SubscriptionPackage(
    name: "Free",
    title: "Basic",
    price: 0.00,
    subtitle:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non purus tristique, faucibus justo ac, semper nunc. Praesent sit amet.",
    features: ["Feature 1", "Feature 2"],
    glow: 0.0,
  ),
  SubscriptionPackage(
    name: "Freedom",
    title: "Pro",
    price: 4.99,
    subtitle:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non purus tristique, faucibus justo ac, semper nunc. Praesent sit amet.",
    features: ["Feature 1", "Feature 2", "Feature 3"],
    glow: 15.0,
  ),
  SubscriptionPackage(
    name: "Extra Freedom",
    title: "Premium",
    price: 9.99,
    subtitle:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non purus tristique, faucibus justo ac, semper nunc. Praesent sit amet.",
    features: ["Feature 1", "Feature 2", "Feature 3"],
    glow: 500.0,
  ),
];

class _SubscriptionPackagesPageState extends State<SubscriptionPackagesPage> {
  late SubscriptionPackage _selectedPackage;
  bool packageSelected = false;

  @override
  void initState() {
    getUserPackage();
    super.initState();
    _selectedPackage = packages[0];
  }

  void getUserPackage() async {
    try {
      var result = await MindFMainPageServices.getUserPackage(context);
      var val = json.decode(result.body)[0]['account_status'];
      setState(() {
        if (val == 'free')
          setState(() {
            _selectedPackage = packages[0];
          });
        else if (val == 'freedom')
          setState(() {
            _selectedPackage = packages[1];
          });
        else
          setState(() {
            _selectedPackage = packages[2];
          });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 380.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                // gradient: LinearGradient(colors: [
                //   Color(0xFFBFFFB3),
                //   Color(0xFFDFFFD9),
                //   Color(0xFFBFFFB3)
                // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF83DE70),
                    blurRadius: _selectedPackage.glow > 0 ? 20.0 : 0.0,
                    spreadRadius: _selectedPackage.glow,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _selectedPackage.name,
                    style: TextStyle(
                      color: Color(0xFF83DE70),
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    _selectedPackage.subtitle,
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.w300,
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Features:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: _selectedPackage.features
                        .map((feature) => ListTile(
                              dense: true,
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(
                                Icons.check,
                                size: 14.0,
                              ),
                              title: Text(
                                feature,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Color(0xFF83DE70),
                        fontWeight: FontWeight.bold,
                        fontSize: 48.0,
                      ),
                      children: [
                        TextSpan(
                          text: '\$${_selectedPackage.price.floor()}',
                        ),
                        TextSpan(
                          text:
                              '.${_selectedPackage.price.remainder(1).toStringAsFixed(2).substring(2)}', // Display cents
                          style: TextStyle(
                            fontSize: 36.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: packages
                .map((package) => SubscriptionPackageWidget(
                      package: package,
                      isSelected: package == _selectedPackage,
                      onTap: () {
                        setState(() {
                          _selectedPackage = package;
                          packageSelected = true;
                        });
                      },
                    ))
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Container(
              alignment: FractionalOffset.topCenter,
              child: ElevatedButton(
                onPressed: packageSelected
                    ? () async {
                        var items = [
                          {
                            "productPrice": 4.99,
                            "productName": "focusmi_Freedom",
                            "qty": 1
                          },
                        ];
                        double subtotal = 4.99;
                        // items.forEach((element) {
                        //   subtotal += (element["productPrice"].toDouble()) *
                        //       (element["qty"] as double);
                        // });
                        await StripeService.stripePaymentCheckout(
                          items,
                          subtotal,
                          context,
                          mounted,
                          onSuccess: () {
                            print("Payment Success");
                            MindFMainPageServices.setUserPackage(
                                context, "extrafreedom");
                            Navigator.pushNamed(context, MainScreen.routeName);
                          },
                          onCancel: () {
                            print("Payment Cancelled");
                          },
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                    primary: packageSelected
                        ? (_selectedPackage == packages[0]
                            ? Colors.grey
                            : (_selectedPackage == packages[2]
                                ? Colors.white
                                : Color(0xFF83DE70)))
                        : Colors.grey,
                    minimumSize: Size(450, 50)),
                child: Text(
                  packageSelected
                      ? _selectedPackage == packages[0]
                          ? 'You already have this'
                          : 'Purchase'
                      : 'Choose a package',
                  style: TextStyle(
                      fontSize: 23,
                      color: _selectedPackage == packages[2]
                          ? Color(0xFF83DE70)
                          : Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
