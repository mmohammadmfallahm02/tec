import 'package:flutter/material.dart';
import 'package:tec/component/my_component.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('مقالات جدید'),
      body: SafeArea(child: Column()),
    );
  }

}
