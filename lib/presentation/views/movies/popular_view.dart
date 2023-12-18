import 'package:flutter/material.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Populars View'),
      ),
      body: const Center(
        child: Text('Populares'),
      ),
    );
  }
}
