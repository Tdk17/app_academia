import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TreinoPage extends StatelessWidget {
  const TreinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final useBluePalette = false; // mude pra true se quiser azul + preto
    final Color base = useBluePalette
        ? const Color(0xFF0EA5E9)
        : const Color(0xFF22C55E);
    final Color baseDark = useBluePalette
        ? const Color(0xFF075985)
        : const Color(0xFF14532D);

    final gradientBg = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black, baseDark.withOpacity(0.75), Colors.black],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: gradientBg,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      _WeekChips(
                        accent: base,
                        onSelected: (label) {
                          // faça filtragem por dia aqui se quiser
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverGrid(
                  delegate: SliverChildListDelegate.fixed([
                    _ExerciseCard(
                      title: 'Peito',
                      subtitle: 'Tríceps',
                      icon: Icons.fitness_center_rounded,
                      accent: base,
                      onTap: () => context.push('/detail'),
                    ),
                    _ExerciseCard(
                      title: 'Pernas',
                      subtitle: 'Quadríceps',
                      icon: Icons.directions_walk_rounded,
                      accent: base,
                      onTap: () => context.push('/waist'),
                    ),
                    _ExerciseCard(
                      title: 'Costas',
                      subtitle: 'Bíceps',
                      icon: Icons.self_improvement_rounded,
                      accent: base,
                      onTap: () => context.push('/back'),
                    ),
                    _ExerciseCard(
                      title: 'Ombros',
                      subtitle: 'Abdômen',
                      icon: Icons.accessibility_new_rounded,
                      accent: base,
                      onTap: () => context.push('/shoulders'),
                    ),
                  ]),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color accent;

  const _ExerciseCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.accent,
  });

  @override
  State<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<_ExerciseCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final Color fg = Colors.white;
    final Color accent = widget.accent;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Semantics(
        button: true,
        label:
            '${widget.title} ${widget.subtitle.isNotEmpty ? "– ${widget.subtitle}" : ""}',
        child: AnimatedScale(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          scale: _hover ? 1.02 : 1.0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(18),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accent.withOpacity(0.22),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  border: Border.all(color: accent.withOpacity(0.25), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.18),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // brilho sutil no canto
                    Positioned(
                      right: -20,
                      top: -20,
                      child: _SoftBlob(
                        color: accent.withOpacity(0.18),
                        size: 120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _IconBadge(icon: widget.icon, accent: accent),
                          const Spacer(),
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: fg,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2,
                                ),
                          ),
                          const SizedBox(height: 6),
                          if (widget.subtitle.isNotEmpty)
                            _SubtitlePill(
                              text: widget.subtitle,
                              accent: accent,
                            ),
                        ],
                      ),
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

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color accent;
  const _IconBadge({required this.icon, required this.accent});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.18),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withOpacity(0.28), width: 1),
          ),
          child: Icon(icon, size: 28, color: Colors.white),
        ),
      ),
    );
  }
}

class _SubtitlePill extends StatelessWidget {
  final String text;
  final Color accent;
  const _SubtitlePill({required this.text, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withOpacity(0.28), width: 1),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _SoftBlob extends StatelessWidget {
  final double size;
  final Color color;
  const _SoftBlob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        // brilho bem suave
        boxShadow: [BoxShadow(color: color, blurRadius: 40, spreadRadius: 20)],
      ),
    );
  }
}

class _WeekChips extends StatefulWidget {
  final Color accent;
  final void Function(String label)? onSelected;
  const _WeekChips({required this.accent, this.onSelected});

  @override
  State<_WeekChips> createState() => _WeekChipsState();
}

class _WeekChipsState extends State<_WeekChips> {
  int _selected = 0;
  final labels = const ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44, // altura estável pros chips
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(labels.length, (i) {
            final bool sel = i == _selected;
            return Padding(
              padding: EdgeInsetsDirectional.only(
                start: i == 0 ? 0 : 8,
                end: i == labels.length - 1 ? 0 : 0,
              ),
              child: ChoiceChip(
                selected: sel,
                label: Text(labels[i]),
                onSelected: (_) {
                  setState(() => _selected = i);
                  widget.onSelected?.call(labels[i]);
                },
                labelStyle: TextStyle(
                  color: sel
                      ? Colors.black
                      : const Color.fromARGB(255, 2, 112, 39),
                  fontWeight: FontWeight.w700,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Colors.white.withOpacity(0.06),
                selectedColor: widget.accent,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: sel ? widget.accent : Colors.white24,
                    width: 1,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
