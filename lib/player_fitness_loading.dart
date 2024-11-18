import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

class PlayerFitnessLoading extends StatelessWidget {
  const PlayerFitnessLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageMultiType(
                url: Icons.download,
                height: 100.0,
                color: Colors.white,
                width: 0.7.sw,
              ),
              10.0.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
