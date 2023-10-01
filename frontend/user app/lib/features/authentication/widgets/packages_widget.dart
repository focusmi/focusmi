import 'package:flutter/material.dart';

class SubscriptionPackage {
  final String name;
  final String title;
  final double price;
  final String subtitle;
  final List<String> features;
  final double glow;

  SubscriptionPackage({
    required this.name,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.features,
    required this.glow,
  });
}

class SubscriptionPackageWidget extends StatelessWidget {
  final SubscriptionPackage package;
  final bool isSelected;
  final VoidCallback onTap;

  SubscriptionPackageWidget({
    required this.package,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 125.0,
        height: 110.0,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF83DE70) : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isSelected ? Colors.white : const Color(0xFF83DE70),
            width: 2.0,
          ),
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    Color.fromARGB(255, 139, 218, 124),
                    Color(0xFF83DE70)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              package.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '\$${package.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: isSelected ? Colors.white : const Color(0xFF83DE70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
