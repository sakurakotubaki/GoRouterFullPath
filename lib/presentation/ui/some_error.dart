import 'package:flutter/material.dart';

class SomeErrorPage extends StatelessWidget {
  const SomeErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Some Error'),
      ),
      body: Center(child: Text('Some Error')),
    );
  }
}