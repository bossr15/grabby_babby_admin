class SidePanelState {
  final int selectedIndex;

  SidePanelState({
    required this.selectedIndex,
  });

  factory SidePanelState.initial() => SidePanelState(
        selectedIndex: 0,
      );

  SidePanelState copyWith({
    int? selectedIndex,
    Map<String, int>? notificationCounts,
  }) =>
      SidePanelState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
      );
}
