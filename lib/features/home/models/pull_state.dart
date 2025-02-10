// lib/models/pull_state.dart
class PullState {
  final int maxPulls;
  final int remainingPulls;
  final DateTime? lastPullReset;
  final bool isPulling;

  PullState({
    this.maxPulls = 12,
    required this.remainingPulls,
    this.lastPullReset,
    this.isPulling = false,
  });

  PullState copyWith({
    int? maxPulls,
    int? remainingPulls,
    DateTime? lastPullReset,
    bool? isPulling,
  }) {
    return PullState(
      maxPulls: maxPulls ?? this.maxPulls,
      remainingPulls: remainingPulls ?? this.remainingPulls,
      lastPullReset: lastPullReset ?? this.lastPullReset,
      isPulling: isPulling ?? this.isPulling,
    );
  }
}