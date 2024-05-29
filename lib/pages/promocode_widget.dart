import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector_pro/matrix_gesture_detector_pro.dart';

class PromocodeWidget extends StatelessWidget {
  const PromocodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    return MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
      },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, childWidget) {
          return Transform(
              transform: notifier.value,
              child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      RotationTransition(
                          turns: AlwaysStoppedAnimation(15 / 360),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'NWH09',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 50,
                                      height: 1,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'Скидка 20% на первую поездку',
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1,
                                    ),
                                  ),
                                ]),
                          )
                    ],
                  )));
        },
      ),
    );
  }
}
