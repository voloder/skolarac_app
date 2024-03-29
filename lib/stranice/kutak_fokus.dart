import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

class KutakFokus extends StatefulWidget {
  final Duration trajanje;

  const KutakFokus({super.key, required this.trajanje});

  @override
  State<KutakFokus> createState() => _KutakFokusState();
}

class _KutakFokusState extends State<KutakFokus> with TickerProviderStateMixin {
  late CountDownController controller = CountDownController(

  );
  late AnimationController animationController = AnimationController(
      vsync: this, duration: Duration(seconds: 2))..repeat();
  bool playing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF21159c),
          Color(0xFF60E0E7),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  controller.pause();
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.chevron_left,
                  size: 40,
                  color: Colors.white,
                )),
            Expanded(
              flex: 5,
              child: NeonCircularTimer(
                width: 200,
                duration: widget.trajanje.inSeconds,
                controller: controller,
                isTimerTextShown: true,
                neumorphicEffect: true,
                backgroudColor: Colors.white,
                neon: 5,
                textStyle: TextStyle(
                  fontSize: 60,
                  color: Colors.black,
                ),
                innerFillGradient: LinearGradient(colors: [
                  Colors.greenAccent.shade200,
                  Colors.blueAccent.shade400
                ]),
                neonGradient: LinearGradient(colors: [
                  Colors.greenAccent.shade200,
                  Colors.blueAccent.shade400
                ]),
              ),
            ),
        
            Center(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (playing) {
                          controller.pause();
                          animationController.stop();
                          playing = false;
                        } else {
                          controller.resume();
                          animationController.repeat();
                          playing = true;
                        }
                      });
                    },
                    child: Icon(
                      playing ? Icons.pause : Icons.play_arrow,
                      size: 60,
                      color: Colors.white,
                    ))),
            Expanded(
              flex: 4,
                child: Center(
                    child: Lottie.asset(
                      controller: animationController,
              "assets/animacije/animacija.json",
              alignment: Alignment.center,
            ))),
          ],
        ),
      ),
    ));
  }
}
