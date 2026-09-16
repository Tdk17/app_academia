import 'dart:async';
import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';
import '../Alimentacao/alimentacao_page.dart';
import '../Home/home_screen.dart';
import '../dashboard/perfil_board.dart';
import 'app_theme.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  final _pages = const [
    WorkoutsPage(),
    AlimentacaoPage(),
    ProgressPage(),
  ];

  static const _titles = ['Treinos', 'Alimentação', 'Progresso'];

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
    setState(() => _isRunning = true);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = 0;
    });
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 900;
        return Scaffold(
          backgroundColor: AppTheme.bg,
          appBar: AppBar(
            toolbarHeight: desktop ? 68 : 60,
            titleSpacing: desktop ? 24 : 16,
            backgroundColor: const Color(0xF2080A0D),
            surfaceTintColor: Colors.transparent,
            title: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppTheme.accent,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Icon(Icons.fitness_center_rounded, color: Colors.black, size: 19),
                ),
                const SizedBox(width: 11),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PH TRAINING', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: .8)),
                    Text(_titles[_currentIndex], style: const TextStyle(fontSize: 11, color: AppTheme.muted, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
            actions: [
              _TimerChip(
                time: _formatTime(_seconds),
                running: _isRunning,
                onToggle: _toggleTimer,
                onReset: _resetTimer,
                compact: !desktop,
              ),
              SizedBox(width: desktop ? 22 : 10),
            ],
          ),
          body: desktop
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _currentIndex,
                      onDestinationSelected: (index) => setState(() => _currentIndex = index),
                      backgroundColor: const Color(0xFF0B0E11),
                      indicatorColor: AppTheme.accent,
                      selectedIconTheme: const IconThemeData(color: Colors.black),
                      unselectedIconTheme: const IconThemeData(color: AppTheme.muted),
                      selectedLabelTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                      unselectedLabelTextStyle: const TextStyle(color: AppTheme.muted, fontWeight: FontWeight.w600),
                      groupAlignment: -0.68,
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(icon: Icon(Icons.fitness_center_rounded), label: Text('Treinos')),
                        NavigationRailDestination(icon: Icon(Icons.restaurant_menu_rounded), label: Text('Alimentação')),
                        NavigationRailDestination(icon: Icon(Icons.insights_rounded), label: Text('Progresso')),
                      ],
                    ),
                    const VerticalDivider(width: 1, thickness: 1, color: AppTheme.border),
                    Expanded(child: IndexedStack(index: _currentIndex, children: _pages)),
                  ],
                )
              : IndexedStack(index: _currentIndex, children: _pages),
          bottomNavigationBar: desktop
              ? null
              : NavigationBar(
                  height: 72,
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) => setState(() => _currentIndex = index),
                  backgroundColor: const Color(0xF211151A),
                  indicatorColor: AppTheme.accent,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.fitness_center_outlined),
                      selectedIcon: Icon(Icons.fitness_center_rounded, color: Colors.black),
                      label: 'Treinos',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.restaurant_menu_outlined),
                      selectedIcon: Icon(Icons.restaurant_menu_rounded, color: Colors.black),
                      label: 'Alimentação',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.insights_outlined),
                      selectedIcon: Icon(Icons.insights_rounded, color: Colors.black),
                      label: 'Progresso',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _TimerChip extends StatelessWidget {
  final String time;
  final bool running;
  final VoidCallback onToggle;
  final VoidCallback onReset;
  final bool compact;

  const _TimerChip({
    required this.time,
    required this.running,
    required this.onToggle,
    required this.onReset,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 13, vertical: 9),
            decoration: BoxDecoration(
              color: running ? AppTheme.accent.withValues(alpha: .15) : AppTheme.surfaceAlt,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: running ? AppTheme.accent.withValues(alpha: .35) : AppTheme.border),
            ),
            child: Row(
              children: [
                Icon(running ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 18, color: running ? AppTheme.accent : Colors.white),
                const SizedBox(width: 6),
                Text(time, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, fontFeatures: [FontFeature.tabularFigures()])),
              ],
            ),
          ),
        ),
        if (!compact) ...[
          const SizedBox(width: 6),
          IconButton(onPressed: onReset, tooltip: 'Zerar cronômetro', icon: const Icon(Icons.restart_alt_rounded, color: AppTheme.muted)),
        ],
      ],
    );
  }
}
