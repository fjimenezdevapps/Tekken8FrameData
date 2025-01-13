import 'package:flutter/material.dart';
import 'package:tekkenframadata/config/utils/moves_properties_legends.dart';

void showHelpDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 400,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: 'Commands'),
                      Tab(text: 'Properties'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Pestaña Commands
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            itemCount: legendCommands.length,
                            itemBuilder: (context, index) {
                              final command = legendCommands[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Text(
                                      command['command']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: Text(command['description']!)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // Pestaña Properties
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            itemCount: legendProperties.length,
                            itemBuilder: (context, index) {
                              final property = legendProperties[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Text(
                                      property['property']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: Text(property['description']!)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }