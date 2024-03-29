import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class CustomSliderCard extends StatefulWidget {
  CustomSliderCard({@required this.question, this.onPress, this.onChange});

  final Function onPress;
  final String question;
  final Function onChange;

  @override
  _CustomSliderCardState createState() => _CustomSliderCardState();
}

class _CustomSliderCardState extends State<CustomSliderCard> {
  int sliderValue = 1;

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
                style: kSubHeaderTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(
            //   height: 4,
            // ),
            Text(
              sliderValue.toString(),
              style: kSliderNumberStyle,
            ),

            Slider(
              value: sliderValue.toDouble(),
              min: 1,
              max: 5,
              activeColor: kAppBlue,
              // inactiveColor: kSISColour.withOpacity(0.2),
              inactiveColor: Color(0XFF8D8E98),
              onChanged: (double newValue) {
                widget.onChange(newValue);
                setState(() {
                  sliderValue = newValue.round();
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('low/unlikely'),
                Text('high/likely'),
              ],
            ),
          ],
        ),
        margin: EdgeInsets.all(12),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
          // color: kAppLight,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
