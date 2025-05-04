// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PeriodTracker(),
    );
  }
}

class PeriodTracker extends StatefulWidget {
  @override
  _PeriodTrackerState createState() => _PeriodTrackerState();
}

class _PeriodTrackerState extends State<PeriodTracker> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Store period data: Map<Date, Flow Intensity>
  Map<DateTime, int> _periodData = {};

  int _selectedIntensity = 1;
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadData();
  }

  // Load saved period data
  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final periodDataJson = prefs.getString('period_data');

      if (periodDataJson != null) {
        final Map<String, dynamic> decoded = jsonDecode(periodDataJson);
        setState(() {
          _periodData = decoded.map((key, value) {
            final parts = key.split('-');
            return MapEntry(
              DateTime(int.parse(parts[0]), int.parse(parts[1]),
                  int.parse(parts[2])),
              value as int,
            );
          });
        });
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  // Save period data
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final Map<String, int> encodableMap = {};

      _periodData.forEach((key, value) {
        final dateKey = '${key.year}-${key.month}-${key.day}';
        encodableMap[dateKey] = value;
      });

      await prefs.setString('period_data', jsonEncode(encodableMap));
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  // Check if dates have the same day
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Function to save period entry
  void _addOrUpdateEntry(int intensity) {
    if (_selectedDay != null) {
      setState(() {
        _periodData[DateTime(
          _selectedDay!.year,
          _selectedDay!.month,
          _selectedDay!.day,
        )] = intensity;
        _selectedIntensity = intensity;
        _saveData();
      });
    }
  }

  // Function to remove period entry
  void _removeEntry() {
    if (_selectedDay != null) {
      setState(() {
        _periodData.remove(DateTime(
          _selectedDay!.year,
          _selectedDay!.month,
          _selectedDay!.day,
        ));
        _saveData();
      });
    }
  }

  // Get color based on flow intensity
  Color _getFlowColor(int intensity) {
    switch (intensity) {
      case 1:
        return Colors.red.shade200; // Light flow
      case 2:
        return Colors.red.shade400; // Medium flow
      case 3:
        return Colors.red.shade700; // Heavy flow
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Period Tracker'),
      ),
      body: Container(
        color: Colors.purple[100],
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                if (!_isDialogOpen) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedIntensity = _periodData[DateTime(
                          selectedDay.year,
                          selectedDay.month,
                          selectedDay.day,
                        )] ??
                        1;
                  });
                  // Wait until after build to show dialog
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showIntensityDialog();
                  });
                }
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  // Check if this day has period data
                  final eventDay = DateTime(day.year, day.month, day.day);
                  final intensity = _periodData[eventDay];

                  if (intensity != null) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getFlowColor(intensity),
                      ),
                      child: Text(
                        '${day.day}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendCard(),
                      SizedBox(height: 16),
                      _buildCycleSummaryCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_isDialogOpen) {
            setState(() {
              _selectedDay = DateTime.now();
              _focusedDay = DateTime.now();
              _selectedIntensity = _periodData[DateTime(
                    _selectedDay!.year,
                    _selectedDay!.month,
                    _selectedDay!.day,
                  )] ??
                  1;
            });
            // Wait until after build to show dialog
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showIntensityDialog();
            });
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Add Period Entry',
      ),
    );
  }

  Widget _buildLegendCard() {
    return Card(
      elevation: 4,
      // color: Colors.purple[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Period Info',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tap on a date to record or update your period.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Color Legend:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            _buildLegendItem(Colors.red.shade200, 'Light Flow'),
            SizedBox(height: 4),
            _buildLegendItem(Colors.red.shade400, 'Medium Flow'),
            SizedBox(height: 4),
            _buildLegendItem(Colors.red.shade700, 'Heavy Flow'),
          ],
        ),
      ),
    );
  }

  Widget _buildCycleSummaryCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Cycle',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildCycleSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Text(label)
      ],
    );
  }

  Widget _buildCycleSummary() {
    // Get current period days if any
    List<DateTime> currentPeriodDays = [];
    _periodData.forEach((date, intensity) {
      if (date.month == _focusedDay.month) {
        currentPeriodDays.add(date);
      }
    });

    currentPeriodDays.sort((a, b) => a.compareTo(b));

    if (currentPeriodDays.isEmpty) {
      return Text('No period recorded for this month yet.');
    }

    String startDate = DateFormat('MMMM d').format(currentPeriodDays.first);
    String endDate = DateFormat('MMMM d').format(currentPeriodDays.last);
    int duration = currentPeriodDays.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Period Start: $startDate'),
        SizedBox(height: 4),
        Text('Period End: $endDate'),
        SizedBox(height: 4),
        Text('Duration: $duration days'),
      ],
    );
  }

  void _showIntensityDialog() {
    if (_selectedDay == null) return;

    _isDialogOpen = true;
    final formattedDate = DateFormat('MMMM d, yyyy').format(_selectedDay!);
    final hasEntry = _periodData.containsKey(DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
    ));

    // Create a local variable to store the selected intensity in the dialog
    int dialogIntensity = _periodData[DateTime(
          _selectedDay!.year,
          _selectedDay!.month,
          _selectedDay!.day,
        )] ??
        1;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SimpleDialog(
              title:
                  Text(hasEntry ? 'Update Period Entry' : 'Add Period Entry'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: $formattedDate'),
                      SizedBox(height: 16),
                      Text('Select Flow Intensity:'),
                      SizedBox(height: 8),
                      RadioListTile<int>(
                        title: Text('Light Flow'),
                        value: 1,
                        groupValue: dialogIntensity,
                        onChanged: (value) {
                          setState(() {
                            dialogIntensity = value!;
                          });
                        },
                        activeColor: Colors.red.shade200,
                      ),
                      RadioListTile<int>(
                        title: Text('Medium Flow'),
                        value: 2,
                        groupValue: dialogIntensity,
                        onChanged: (value) {
                          setState(() {
                            dialogIntensity = value!;
                          });
                        },
                        activeColor: Colors.red.shade400,
                      ),
                      RadioListTile<int>(
                        title: Text('Heavy Flow'),
                        value: 3,
                        groupValue: dialogIntensity,
                        onChanged: (value) {
                          setState(() {
                            dialogIntensity = value!;
                          });
                        },
                        activeColor: Colors.red.shade700,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (hasEntry)
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _removeEntry();
                                _isDialogOpen = false;
                              },
                              child: Text('Remove'),
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.red),
                            ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _isDialogOpen = false;
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _addOrUpdateEntry(dialogIntensity);
                              _isDialogOpen = false;
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      _isDialogOpen = false;
    });
  }
}
