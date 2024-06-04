//212287

import 'package:flutter/material.dart';
import 'engineer/engineer_list.dart';
import './factory.dart';
import './notification.dart';

const backgroundColor = Color(0xFF1E1E1E);

class Dashboard extends StatefulWidget {
  final List<Map<String, dynamic>> factories;
  final int currentFactoryIndex;
  Function(int) updateCurrentFactory;

  Dashboard({
    Key? key,
    required this.factories,
    required this.currentFactoryIndex,
    required this.updateCurrentFactory,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.factories[widget.currentFactoryIndex]['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: const Icon(Icons.settings),
          )
        ],
      ),
      body: Container(
          color: const Color(0xFFBDBDBD),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (currentIndex == 0
                  ? EngineerList(
                currentFactory:
                widget.factories[widget.currentFactoryIndex],
              )
                  : currentIndex == 1
                  ? Factory(
                factory: widget.factories[widget.currentFactoryIndex],
              )
                  : NotificationSettings(
                factory: widget.factories[widget.currentFactoryIndex],
              )),
              _buildFactoryButton(context),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'profile',
            icon: Icon(Icons.account_box),
          ),
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'settings',
            icon: Icon(Icons.settings),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget _buildFactoryButton(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.factories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.updateCurrentFactory(index);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: (widget.currentFactoryIndex == index
                                      ? Colors.blue
                                      : Colors.transparent)),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.factory,
                                  color: backgroundColor),
                              Text(
                                widget.factories[index]['name'],
                                style: const TextStyle(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}