import 'package:flutter/material.dart';
import 'package:fasholast1/constants/asset_paths.dart';
import 'package:fasholast1/widgets/loading.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            logo,
            width: 120,
          ),
          SizedBox(
            height: 10,
          ),
          Loading()
        ],
      ),
    );
  }
}
