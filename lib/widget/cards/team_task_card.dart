import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:hrms/model/team_task_list.dart';
import '../../utils/fun.dart';
import '../../utils/s_colors.dart';

class TeamTaskCard extends StatelessWidget {
  final Result task;
  final Function(Result) onTap;
  final Function(String, Result) onMenuSelected;

  TeamTaskCard({
    required this.task,
    required this.onTap,
    required this.onMenuSelected,
  });

  // Helper method to format date
  String _formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'Unknown';
    }
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM, yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  // Helper method to get status color
  Color _getStatusColor(String status) {
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
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => onTap(task),
        child: Padding(
          padding: EdgeInsets.only(bottom: 16,right: 16,left:16,top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(
              Fun.capitalizeFirstLetter(task.name),
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: SColors.black,
                    ),
                  ),),
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      onMenuSelected(value, task);
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Edit', 'Approve', 'Reject'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    icon: Icon(Icons.menu, color: SColors.black),
                  ),
                ],
              ),
              Text(
                Fun.capitalizeFirstLetter(task.title),
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: SColors.black,
                ),
              ),
              Text(
                task.description ?? 'No Description',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  height: 1.5,
                  color: SColors.black.withOpacity(0.75),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Created On: ${_formatDate(task.createdAt)}',
                    style: GoogleFonts.roboto(
                      fontSize: 10,
                      color: SColors.black.withOpacity(0.6),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(task.status ?? 'unknown'),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      showStatus(task.status ?? 'Unknown Status'),
                      style: GoogleFonts.roboto(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
