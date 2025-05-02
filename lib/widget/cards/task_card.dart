import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Add this import
import '../../model/task_list.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class TaskCard extends StatelessWidget {
  final Result task;
  final Function(Result) onTap;

  TaskCard({required this.task, required this.onTap});

  // Helper method to format date
  String _formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'Unknown';
    }
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd-MMM-yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
  // Helper method to get status color
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'true':
        return Colors.green.shade400;
      case 'false':
        return Colors.red.shade400;
      default:
        return Colors.green.shade400;
    }
  }

  String showStatus(String status) {
    switch (status.toLowerCase()) {
      case 'false':
        return "Rejected";
      case 'true':
        return "Approved";
      default:
        return "Approved";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () => onTap(task),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(

                children: [
                  Expanded(
                    child: Text(
                      Fun.capitalizeFirstLetter(task.title),
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: SColors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: getStatusColor(task.status.toString() ?? 'unknown'),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      showStatus(task.status.toString() ?? 'Unknown Status'),
                      style: GoogleFonts.roboto(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                task.description ?? 'No Description',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: SColors.black.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      'Created On: ${_formatDate(task.createdAt)}',
                      style: GoogleFonts.roboto(
                        fontSize: 8,
                        color: SColors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
