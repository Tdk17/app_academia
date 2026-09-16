import 'package:flutter/material.dart';
import '../Treinos/treinoPage.dart';
import '../componets/app_theme.dart';
import '../data/training_data.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackdrop(
      child: SafeArea(
        bottom: false,
        child: ResponsiveFrame(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 12),
                sliver: SliverToBoxAdapter(child: _Hero()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                sliver: SliverToBoxAdapter(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 760;
                      return GridView.count(
                        crossAxisCount: wide ? 3 : 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: wide ? 2.35 : 3.45,
                        children: const [
                          _StatCard(icon: Icons.fitness_center_rounded, value: '5', label: 'Treinos na ficha'),
                          _StatCard(icon: Icons.bedtime_outlined, value: '2', label: 'Descansos sugeridos'),
                          _StatCard(icon: Icons.track_changes_rounded, value: '9–12', label: 'Faixa principal de reps'),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppTheme.accent.withValues(alpha: .22)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.event_available_rounded, color: AppTheme.accent),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Descanso recomendado: um dia na quarta ou quinta-feira e outro no domingo. Após o Treino 3, priorize um dia de recuperação antes de seguir.',
                            style: TextStyle(color: Color(0xFFE6D2AF), height: 1.42),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 110),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.crossAxisExtent;
                    final columns = width >= 1120 ? 3 : width >= 700 ? 2 : 1;
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: columns == 1 ? 1.75 : 1.35,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _WorkoutCard(
                          workout: workouts[index],
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TreinoDetalhePage(workout: workouts[index]),
                              ),
                            );
                          },
                        ),
                        childCount: workouts.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 800;
        return Container(
          padding: EdgeInsets.all(desktop ? 28 : 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF171B20), Color(0xFF0D0F12)],
            ),
            border: Border.all(color: AppTheme.border),
          ),
          child: desktop
              ? const Row(children: [Expanded(child: _HeroText()), SizedBox(width: 28), _HeroBadge()])
              : const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_HeroText(), SizedBox(height: 18), _HeroBadge()]),
        );
      },
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NOVA FICHA • 5 DIAS',
          style: TextStyle(color: AppTheme.accent, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5),
        ),
        const SizedBox(height: 8),
        Text(
          'Treino com foco em execução e progressão.',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, height: 1.05),
        ),
        const SizedBox(height: 10),
        const Text(
          'Abra um treino para registrar cargas, marcar exercícios concluídos e acessar uma referência de execução para cada movimento.',
          style: TextStyle(color: AppTheme.muted, height: 1.45),
        ),
      ],
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 190),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.accent.withValues(alpha: .09),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.accent.withValues(alpha: .22)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.priority_high_rounded, color: AppTheme.accent),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              'Execução antes da carga',
              style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFFFD899)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatCard({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppTheme.surfaceAlt, borderRadius: BorderRadius.circular(13)),
            child: Icon(icon, color: AppTheme.accent, size: 21),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final WorkoutData workout;
  final VoidCallback onTap;
  const _WorkoutCard({required this.workout, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.accent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '${workout.number}',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: AppTheme.surfaceAlt, borderRadius: BorderRadius.circular(999)),
                    child: Text('${workout.exercises.length} exercícios', style: const TextStyle(color: AppTheme.muted, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const Spacer(),
              Text(workout.title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
              const SizedBox(height: 5),
              Text(workout.focus, style: const TextStyle(color: AppTheme.accent, fontSize: 12.5, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(workout.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppTheme.muted, height: 1.35, fontSize: 12.5)),
              const SizedBox(height: 14),
              const Row(
                children: [
                  Text('ABRIR TREINO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.1)),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, size: 17, color: AppTheme.accent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
