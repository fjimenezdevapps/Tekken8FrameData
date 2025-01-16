import 'package:flutter/material.dart';
import 'package:tekkenframadata/config/utils/moves_properties_legends.dart';
//import 'package:tekkenframadata/config/utils/moves_properties_legends.dart';

void showHelpDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: double.maxFinite,
            child: DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Commands'),
                      Tab(text: 'Properties'),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(16),
                            child: ListView.builder(
                                itemCount: legendCommands.length,
                                itemBuilder: (context, index) {
                                  final command = legendCommands[index];
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            command['command']!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                              child: Text(
                                                  command['description']!)),
                                        ],
                                      ));
                                })),
                        Container(
                            padding: const EdgeInsets.all(16),
                            child: ListView.builder(
                                itemCount: legendProperties.length,
                                itemBuilder: (context, index) {
                                  final property = legendProperties[index];
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            property['property']!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                              child: Text(
                                                  property['description']!)),
                                        ],
                                      ));
                                })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Exit'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
