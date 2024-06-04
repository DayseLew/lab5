//212287
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

const backgroundColor = Color(0xFF1E1E1E);

class Factory extends StatefulWidget {
  const Factory({
    Key? key,
    required this.factory,
  }) : super(key: key);

  final Map<String, dynamic> factory;

  @override
  State<Factory> createState() => _FactoryState();
}

class _FactoryState extends State<Factory> {
  @override
  Widget build(BuildContext context) {
    String powerConsumption = widget.factory['power_consumption'] == 0
        ? '⚠️ ABD1234 IS UNREACHABLE !'
        : '${widget.factory['power_consumption']} kW';
    double steamPressure = widget.factory['steam_pressure'];
    double steamFlow = widget.factory['steam_flow'];
    double waterLevel = widget.factory['water_level'];
    double powerFreq = widget.factory['power_freq'];
    String date = widget.factory['date'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60.h,
          width: 85.w,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.05,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  powerConsumption,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMonitorTile(context, 'Steam Pressure',
                        '$steamPressure bar', steamPressure),
                    _buildMonitorTile(
                        context, 'Steam Flow', '$steamFlow T/H', steamFlow),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMonitorTile(
                        context, 'Water Level', '$waterLevel %', waterLevel),
                    _buildMonitorTile(
                        context, 'Power Frequency', '$powerFreq Hz', powerFreq),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMonitorTile(
      BuildContext context, String label, String valueWithUnit, double value) {
    String imageType = value <= 0
        ? 'low'
        : (value > 0 && value < 50)
        ? 'medium'
        : 'high';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 15.0,
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image.asset('images/speedometer_$imageType.png')),
            Flexible(
              flex: 1,
              child: Text(
                valueWithUnit,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
