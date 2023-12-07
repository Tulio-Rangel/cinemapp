import 'package:flutter/material.dart';
import 'package:cinemapp/presentation/widgets/widgets.dart';
import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
