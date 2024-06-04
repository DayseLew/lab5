import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const backgroundColor = Color(0xFF1E1E1E);
/*const accentColor = Color(0xFF07DAFF);
const textColor = Color(0xFFFFFFFF);
const iconColor = Color(0xFF9E9E9E);*/

class EngineerList extends StatefulWidget {
  const EngineerList({
    Key? key,
    required this.currentFactory,
  }) : super(key: key);

  final Map<String, dynamic> currentFactory;

  @override
  State<EngineerList> createState() => _EngineerListState();
}

class _EngineerListState extends State<EngineerList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
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
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: _buildEngineerCard(widget.currentFactory),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addEngineer');
                },
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                  elevation: MaterialStateProperty.all<double>(5.0),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 30.0,
                  weight: 12.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEngineerCard(Map<String, dynamic> currentFactory) {
    if (currentFactory['engineer_list'].length == 0) {
      return Container(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'No Engineer Available',
              style: TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: currentFactory['engineer_list'].length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10.0,
                      color: Color(0xFF757575),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentFactory['engineer_list'][index]['name'] ??
                            'name',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '+60${currentFactory['engineer_list'][index]['phone'] ?? 'phone'}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}