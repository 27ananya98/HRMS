import 'package:flutter/material.dart';

import '../../utils/s_colors.dart';


class PgDialogWs extends StatelessWidget {
  final Widget child;
  final bool loading;
  final Color progressColor; // Add this new property for the progress indicator color


  PgDialogWs({
    required this.child,
    required this.loading,
    this.progressColor = SColors.rozgarRed
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(progressColor), // Set the progress indicator color
                backgroundColor: Colors.white, // Set the background color of the progress indicator
              ),
            ),
          ),
      ],
    );
  }
}