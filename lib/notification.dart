import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const backgroundColor = Color(0xFF1E1E1E);
const accentColor = Color(0xFF07DAFF);
const textColor = Color(0xFFFFFFFF);
const iconColor = Color(0xFF9E9E9E);

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({
    Key? key,
    required this.factory,
  }) : super(key: key);

  final Map<String, dynamic> factory;

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    double steamPressure = widget.factory['steam_pressure'];
    double steamFlow = widget.factory['steam_flow'];
    double waterLevel = widget.factory['water_level'];
    double powerFreq = widget.factory['power_freq'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 65.h,
          width: 90.w,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Minimum Threshold',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Icon(Icons.info_outline),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Icon(Icons.edit),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMonitorTile(
                          context, 'Steam Pressure', steamPressure, 'bar'),
                      _buildMonitorTile(context, 'Steam Flow', steamFlow, 'T/H'),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMonitorTile(context, 'Water Level', waterLevel, '%'),
                      _buildMonitorTile(
                          context, 'Power Frequency', powerFreq, 'Hz'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonitorTile(
      BuildContext context, String label, double value, String unit) {
    return Container(
      width: 35.w,
      height: 30.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 2.0, // Border width
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ) // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: Text(
                        '$value',
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 2.0, // Border width
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 5.0),
                      child: Text(
                        unit,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}