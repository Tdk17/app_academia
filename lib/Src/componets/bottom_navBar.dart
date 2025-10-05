import 'dart:async';
import 'dart:ui' show ImageFilter; // para o blur do bottom bar
import 'package:app_academia/Src/Home/home_screen.dart';
import 'package:app_academia/Src/dashboard/perfil_board.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 1;

  final _pages = [
    const Center(
      child: Text('Menu', style: TextStyle(color: Colors.white)),
    ),
    const TreinoPage(),
    const DashboardPage(),
  ];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // paleta combinando com as outras telas
    final useBluePalette = false; // true = azul+preto | false = verde+preto
    final Color base = useBluePalette
        ? const Color(0xFF0EA5E9)
        : const Color(0xFF22C55E);
    final Color baseDark = useBluePalette
        ? const Color(0xFF075985)
        : const Color(0xFF14532D);

    final bgGradient = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black, baseDark.withOpacity(0.75), Colors.black],
      ),
    );

    return Container(
      decoration: bgGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true, // deixa o bottom bar “flutuando” no fundo
        appBar: FixedAppBar(accent: base),
        body: IndexedStack(index: _currentIndex, children: _pages),

        // Botão flutuante central (com “aura”)
        floatingActionButton: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: base.withOpacity(0.45),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: FloatingActionButton(
            elevation: 6,
            backgroundColor: base,
            shape: const CircleBorder(),
            onPressed: () => _onTabSelected(1),
            child: const FaIcon(
              FontAwesomeIcons.dumbbell,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // BottomAppBar com glass + blur + indicador de aba ativa
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              color: Colors.white.withOpacity(0.06),
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.12),
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NavIcon(
                      icon: FontAwesomeIcons.list,
                      label: 'Menu',
                      isActive: _currentIndex == 0,
                      onTap: () => _onTabSelected(0),
                      accent: base,
                    ),
                    const SizedBox(width: 48), // espaço do notch do FAB
                    _NavIcon(
                      icon: FontAwesomeIcons.user,
                      label: 'Perfil',
                      isActive: _currentIndex == 2,
                      onTap: () => _onTabSelected(2),
                      accent: base,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Ícone do bottom bar com indicador sutil e label
class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color accent;

  const _NavIcon({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final Color fg = isActive ? accent : Colors.white70;

    return InkResponse(
      onTap: onTap,
      radius: 28,
      child: SizedBox(
        height: 52, // <= cabe no constraint de ~55px
        width: 72, // largura confortável p/ label
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 20, color: fg), // 22 -> 20
            const SizedBox(height: 2), // 4 -> 2
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11, // 12 -> 11
                height: 1.0, // reduz altura de linha
                color: isActive ? Colors.white : Colors.white70,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2), // 4 -> 2
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              height: 2, // 3 -> 2
              width: isActive ? 20 : 0, // 22 -> 20
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// AppBar customizada e fixa (mesma lógica, só estética)
class FixedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Color accent;
  const FixedAppBar({super.key, required this.accent});

  @override
  State<FixedAppBar> createState() => _FixedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FixedAppBarState extends State<FixedAppBar> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          _seconds++;
        });
      });
    }
    setState(() => _isRunning = !_isRunning);
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accent;

    return AppBar(
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, accent.withOpacity(0.28)],
          ),
        ),
      ),
      title: const Text(
        'Bem - Vindo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            children: [
              // botão play/pause com pill
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: _toggleTimer,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: accent.withOpacity(0.35)),
                  ),
                  child: Icon(
                    _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // cronômetro em chip monoespaçado
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withOpacity(0.18)),
                ),
                child: Text(
                  _formatTime(_seconds),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFeatures: [
                      FontFeature.tabularFigures(),
                    ], // dígitos alinhados
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
