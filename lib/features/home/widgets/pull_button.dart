// lib/widgets/pull_button.dart
import 'package:flutter/material.dart';
import '../models/pull_state.dart';

class PullButton extends StatelessWidget {
  final PullState pullState;
  final VoidCallback onPull;
  final VoidCallback? onToggleView;
  final bool showViewToggle;
  final bool isGridView;

  const PullButton({
    super.key,
    required this.pullState,
    required this.onPull,
    this.onToggleView,
    this.showViewToggle = false,
    this.isGridView = false,
  });

  String _getTimeUntilReset() {
    if (pullState.lastPullReset == null) return '';
    final nextReset = pullState.lastPullReset!.add(const Duration(hours: 1));
    final remaining = nextReset.difference(DateTime.now());
    return '${remaining.inMinutes}m ${remaining.inSeconds % 60}s';
  }

  @override
  Widget build(BuildContext context) {
    if (pullState.remainingPulls <= 0) {
      return Text(
        'Next pull available in ${_getTimeUntilReset()}',
        style: const TextStyle(fontSize: 16),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: pullState.isPulling ? null : onPull,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: Text(
            pullState.isPulling 
              ? 'Pulling...' 
              : 'Roll it baby!' //' (${pullState.remainingPulls} left)'
          ),
        ),
        if (showViewToggle && onToggleView != null) 
          TextButton(
            onPressed: onToggleView,
            child: Text(isGridView ? 'Stack View' : 'View All'),
          ),
      ],
    );
  }
}