import 'package:evently/widgets/home_body.dart';
import 'package:evently/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        HomeBody(),
      ],
    );
  }
}
