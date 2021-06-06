import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerBar extends StatelessWidget {
  final double itemsPaddings = 10.0 + 10.0 + 10.0 + 20.0;
  final double time;
  final double totalTime;

  TimerBar(this.time, this.totalTime);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - itemsPaddings;
    if(width <= 0) return Container();
    double ratio = time / totalTime;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(padding: const EdgeInsets.only(left: 10.0)),
        Icon(Icons.timer, color: Colors.grey[60], size: 20.0),
        const Padding(padding: const EdgeInsets.only(left: 10.0)),
        Expanded(
          child: Stack(
            children: [
              Container(
                width: width,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.grey[600]),
              ),
              Material(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  width: width * ratio,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: ratio < 0.2
                          ? Colors.red
                          : ratio < 0.5
                              ? Colors.amber
                              : Colors.green),
                ),
              )
            ],
          ),
        ),
        const Padding(padding: const EdgeInsets.only(left: 10.0)),
      ],
    );
  }
}
