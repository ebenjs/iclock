import 'dart:async';

import 'package:flip_board/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IndicatorPane extends StatefulWidget {
  int valueToDisplay;
  IndicatorPane({super.key, required this.valueToDisplay});

  @override
  State<IndicatorPane> createState() => _IndicatorPaneState();
}

class _IndicatorPaneState extends State<IndicatorPane> {
  late int currentValue;
  final _flipController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    currentValue = widget.valueToDisplay;
  }

  @override
  void didUpdateWidget(covariant IndicatorPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valueToDisplay != oldWidget.valueToDisplay) {
      currentValue = widget.valueToDisplay;
      _flipController.add(currentValue);
    }
  }

  @override
  void dispose() {
    _flipController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlipWidget<int>(
      flipType: FlipType.middleFlip,
      itemStream: _flipController.stream,
      itemBuilder: (context, int? value) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF242427),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(
          value!.toString().padLeft(2, '0'),
          style: const TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      initialValue: widget.valueToDisplay,
      flipDirection: AxisDirection.up,
      hingeWidth: 1.0,
      hingeLength: 56.0,
      hingeColor: Colors.black,
    );
  }
}
