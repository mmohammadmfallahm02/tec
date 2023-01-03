import 'package:flutter/material.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/gen/assets.gen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu),
                Assets.images.logo.image(height: size.height / 13.6),
                const Icon(Icons.search)
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: size.width / 1.19,
                height: size.height / 4.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: (Assets.images.posterTest.image()).image),),
                        
              ),
              Container(
                width: size.width / 1.19,
                height: size.height / 4.2,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                    colors: GradiantColors.homePosterCoverGradiant,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
             
            ],
          ),
           
        ],
      ),
    ));
  }
}
