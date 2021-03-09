import 'package:flutter/material.dart';
import 'constants.dart';

class SliderCard extends StatefulWidget {
  SliderCard({this.colour, @required this.question, @required this.sliderValue, this.onPress});

  final Color colour;
  final Function onPress;
  final String question;
  int sliderValue;

  @override
  _SliderCardState createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.question,
                style: kHeaderTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(
            //   height: 4,
            // ),
            // Text(
            //   widget.sliderValue.toString(),
            //   style: kSliderNumberStyle,
            // ),
            Slider(
              value: widget.sliderValue.toDouble(),
              min: 0,
              max: 10,
              activeColor: kSISColour,
              // inactiveColor: kSISColour.withOpacity(0.2),
              inactiveColor: Color(0XFF8D8E98),
              onChanged: (double newValue) {
                setState(() {
                  widget.sliderValue = newValue.round();
                });
              },
            ),
          ],
        ),
        margin: EdgeInsets.all(12),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          // color: widget.colour,
          color: Color(0xFF2f7edb).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
