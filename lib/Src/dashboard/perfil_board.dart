import 'package:flutter/material.dart';
import '../componets/app_theme.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackdrop(
      child: SafeArea(
        bottom: false,
        child: ResponsiveFrame(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 14),
                sliver: SliverToBoxAdapter(child: _Header()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.crossAxisExtent;
                    final columns = width >= 950 ? 4 : width >= 600 ? 2 : 1;
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: columns == 1 ? 3.4 : 1.85,
                      ),
                      delegate: SliverChildListDelegate.fixed(const [
                        _Metric(icon: Icons.calendar_month_rounded, value: '11 semanas', label: 'Ciclo atual'),
                        _Metric(icon: Icons.event_repeat_rounded, value: 'Sábado', label: 'Atualização'),
                        _Metric(icon: Icons.fitness_center_rounded, value: '5 sessões', label: 'Treinos'),
                        _Metric(icon: Icons.bedtime_outlined, value: '2 dias', label: 'Descanso sugerido'),
                      ]),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                sliver: SliverToBoxAdapter(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final desktop = constraints.maxWidth >= 850;
                      final children = const [
                        Expanded(
                          child: _Panel(
                            title: 'Regras do treino',
                            icon: Icons.rule_rounded,
                            items: [
                              'Siga a ordem prescrita dos exercícios.',
                              'Execução do movimento vem antes da carga.',
                              'Progrida carga após a fase de adaptação, sem sacrificar técnica.',
                              'Descansos são autoajustados; evite passar de 5 minutos sem necessidade.',
                              'Séries de força podem exigir descanso maior.',
                            ],
                          ),
                        ),
                        SizedBox(width: 14, height: 14),
                        Expanded(
                          child: _Panel(
                            title: 'Organização semanal',
                            icon: Icons.view_week_rounded,
                            items: [
                              'Treinos 1, 2 e 3 em sequência conforme recuperação.',
                              'Após o Treino 3, encaixe um dia de descanso antes de prosseguir.',
                              'Treinos 4 e 5 fecham a semana.',
                              'Sugestão adicional da ficha: descansar quarta ou quinta e domingo.',
                              'Mantenha o cardio conforme o dia de treino ou descanso.',
                            ],
                          ),
                        ),
                      ];
                      return desktop
                          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: children)
                          : Column(children: [
                              const _Panel(
                                title: 'Regras do treino',
                                icon: Icons.rule_rounded,
                                items: [
                                  'Siga a ordem prescrita dos exercícios.',
                                  'Execução do movimento vem antes da carga.',
                                  'Progrida carga após a fase de adaptação, sem sacrificar técnica.',
                                  'Descansos são autoajustados; evite passar de 5 minutos sem necessidade.',
                                  'Séries de força podem exigir descanso maior.',
                                ],
                              ),
                              const SizedBox(height: 14),
                              const _Panel(
                                title: 'Organização semanal',
                                icon: Icons.view_week_rounded,
                                items: [
                                  'Treinos 1, 2 e 3 em sequência conforme recuperação.',
                                  'Após o Treino 3, encaixe um dia de descanso antes de prosseguir.',
                                  'Treinos 4 e 5 fecham a semana.',
                                  'Sugestão adicional da ficha: descansar quarta ou quinta e domingo.',
                                  'Mantenha o cardio conforme o dia de treino ou descanso.',
                                ],
                              ),
                            ]);
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 110),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0x22FFB547), Color(0x0817191D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppTheme.accent.withValues(alpha: .25)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.trending_up_rounded, color: AppTheme.accent, size: 30),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Progressão inteligente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                              SizedBox(height: 7),
                              Text(
                                'Use os campos de carga dentro de cada exercício para registrar o que foi executado. Na sessão seguinte, compare os números e progrida apenas quando a técnica continuar sólida.',
                                style: TextStyle(color: Color(0xFFD7DCE2), height: 1.45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ACOMPANHAMENTO', style: TextStyle(color: AppTheme.accent, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
        const SizedBox(height: 7),
        Text('Seu ciclo atual', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text('Resumo da ficha, descanso, princípios de progressão e organização semanal.', style: TextStyle(color: AppTheme.muted, height: 1.4)),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _Metric({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.border)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppTheme.surfaceAlt, borderRadius: BorderRadius.circular(13)),
            child: Icon(icon, color: AppTheme.accent, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                Text(label, style: const TextStyle(color: AppTheme.muted, fontSize: 11.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  const _Panel({required this.title, required this.icon, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppTheme.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, color: AppTheme.accent), const SizedBox(width: 10), Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900))]),
          const SizedBox(height: 15),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.check_circle_outline_rounded, size: 18, color: AppTheme.success)),
                  const SizedBox(width: 9),
                  Expanded(child: Text(item, style: const TextStyle(color: Color(0xFFD7DCE2), height: 1.4))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
