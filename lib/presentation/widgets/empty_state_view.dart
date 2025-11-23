import 'package:flutter/material.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final String subtitle;
  const EmptyStateView({required this.title, required this.subtitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.hourglass_empty, size: 48),
          SizedBox(height: 12),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(subtitle, textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}
