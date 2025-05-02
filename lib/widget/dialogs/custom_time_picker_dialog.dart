import 'package:flutter/material.dart';

class CustomTimePickerDialog extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final String initialPeriod;

  CustomTimePickerDialog({
    required this.initialHour,
    required this.initialMinute,
    required this.initialPeriod,
  });

  @override
  _CustomTimePickerDialogState createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
  late int selectedHour;
  late int selectedMinute;
  late String selectedPeriod;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialHour;
    selectedMinute = widget.initialMinute;
    selectedPeriod = widget.initialPeriod;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Select Time",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hour Picker
                  Expanded(
                    child: SizedBox(
                      height: 150,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 40,
                        diameterRatio: 1.2,
                        physics: const FixedExtentScrollPhysics(),
                        controller: FixedExtentScrollController(
                            initialItem: selectedHour - 1),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedHour = index + 1;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) => Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedHour == index + 1
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: selectedHour == index + 1
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          childCount: 12,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ":",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // Minute Picker
                  Expanded(
                    child: SizedBox(
                      height: 150,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 40,
                        diameterRatio: 1.2,
                        physics: const FixedExtentScrollPhysics(),
                        controller: FixedExtentScrollController(
                            initialItem: selectedMinute),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedMinute = index;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) => Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedMinute == index
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                index.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: selectedMinute == index
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          childCount: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // AM/PM Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text("AM"),
                selected: selectedPeriod == 'AM',
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) selectedPeriod = 'AM';
                  });
                },
              ),
              const SizedBox(width: 16),
              ChoiceChip(
                label: const Text("PM"),
                selected: selectedPeriod == 'PM',
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) selectedPeriod = 'PM';
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
        ),
        // OK Button
        ElevatedButton(
          onPressed: () {
            int hour = selectedHour % 12;
            if (selectedPeriod == 'PM') hour += 12;
            TimeOfDay time = TimeOfDay(hour: hour, minute: selectedMinute);
            Navigator.of(context).pop(time);
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
