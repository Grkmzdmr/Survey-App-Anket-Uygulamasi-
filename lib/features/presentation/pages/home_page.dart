import 'package:cubit_mvvm_clean/core/constants/palette.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),backgroundColor: Palette.primary,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(child: Text("Ana Sayfa")),
    );
  }
}