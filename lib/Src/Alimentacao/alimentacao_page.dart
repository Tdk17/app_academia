import 'package:flutter/material.dart';
import '../componets/app_theme.dart';

class AlimentacaoPage extends StatelessWidget {
  const AlimentacaoPage({super.key});

  static const meals = <_Meal>[
    _Meal(
      title: 'Refeição 1',
      subtitle: 'Primeira refeição do dia',
      items: [
        '3 ovos inteiros',
        '75 g pão OU 60 g tapioca OU 60 g aveia',
        '100 g mamão',
        '160 g iogurte natural desnatado',
      ],
      note: 'Após a refeição: Vitamina C 1 g, Ômega 3 1 g, NAC 600 mg e 1 cápsula de multivitamínico.',
    ),
    _Meal(
      title: 'Intra-treino',
      subtitle: 'Durante a musculação',
      items: [
        '2 L de água gelada',
        '10 g creatina',
        '1 g sal',
        '20 g glicerina líquida',
        'Clight ou pequena quantidade de pré-treino apenas para sabor',
      ],
    ),
    _Meal(
      title: 'Refeição 2',
      subtitle: 'Principal',
      items: [
        '150 g arroz OU 150 g macarrão de arroz OU 300 g batata inglesa',
        '100 g peito de frango',
        '100 g legumes e vegetais',
        'Folhas verdes à vontade',
        '100 g mamão OU 100 g abacaxi',
      ],
    ),
    _Meal(
      title: 'Refeição 3',
      subtitle: 'Principal',
      items: [
        '100 g arroz OU 100 g macarrão de arroz OU 200 g batata inglesa',
        '120 g peito de frango',
        '100 g legumes e vegetais',
        'Folhas verdes à vontade',
        '100 g mamão OU 100 g abacaxi',
      ],
    ),
    _Meal(
      title: 'Refeição 4',
      subtitle: 'Refeição menor',
      items: [
        '60 g peito de frango',
        '100 g batata inglesa',
        '100 g legumes e vegetais',
      ],
    ),
    _Meal(
      title: 'Refeição 5',
      subtitle: 'Jantar / refeição principal',
      items: [
        '120 g carne vermelha magra OU 120 g peito de frango',
        '100 g arroz OU macarrão de arroz OU 200 g batata inglesa',
        '100 g legumes e vegetais',
        'Folhas verdes à vontade',
        '100 g mamão OU 100 g abacaxi',
      ],
    ),
    _Meal(
      title: 'Refeição 6',
      subtitle: 'Última refeição',
      items: [
        '80 ml leite fermentado',
        '20 g aveia',
        '20 g whey',
        '50 g banana OU 100 g maçã',
      ],
      note: 'Após a refeição: Vitamina C 1 g, Ômega 3 1 g e NAC 600 mg.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBackdrop(
      child: SafeArea(
        bottom: false,
        child: ResponsiveFrame(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
                sliver: SliverToBoxAdapter(child: _Header()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
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
                        childAspectRatio: wide ? 2.2 : 3.25,
                        children: const [
                          _MetricCard(icon: Icons.water_drop_outlined, value: '4–4,5 L', label: 'Água por dia'),
                          _MetricCard(icon: Icons.directions_run_rounded, value: '45 / 60 min', label: 'Cardio treino / descanso'),
                          _MetricCard(icon: Icons.event_repeat_rounded, value: '7 dias', label: 'Intervalo do refeed'),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                sliver: SliverToBoxAdapter(
                  child: _InfoPanel(
                    title: 'Rotina ao acordar',
                    icon: Icons.wb_sunny_outlined,
                    lines: const [
                      '300–500 ml de água de uma vez',
                      '10 sessões de vacuum abdominal',
                      '5 séries de prancha abdominal',
                      'Em dia sem musculação: reduzir pela metade os carboidratos das refeições',
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.crossAxisExtent;
                    final columns = width >= 1100 ? 3 : width >= 680 ? 2 : 1;
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: columns == 1 ? 1.55 : 1.18,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _MealCard(meal: meals[index]),
                        childCount: meals.length,
                      ),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                sliver: SliverToBoxAdapter(
                  child: _InfoPanel(
                    title: 'Refeed',
                    icon: Icons.restaurant_menu_rounded,
                    lines: const [
                      '1 refeição livre controlada no sábado OU domingo, substituindo o jantar.',
                      'Manter uma boa fonte de proteína e moderar doces.',
                      'Exemplos da ficha: hambúrguer artesanal com fritas + doce pequeno, 4 fatias de pizza ou churrasco.',
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 110),
                sliver: SliverToBoxAdapter(
                  child: _InfoPanel(
                    title: 'Observações importantes',
                    icon: Icons.info_outline_rounded,
                    lines: const [
                      'As quantidades se referem ao alimento já pronto.',
                      'Temperos naturais podem ser usados normalmente; sal com moderação.',
                      'Evitar adicionar gordura no preparo dos alimentos.',
                      'Café preto sem açúcar pode ser usado com moderação.',
                      'Bebidas zero kcal apenas esporadicamente, priorizando água.',
                      'Protocolos hormonais ou medicamentosos não são gerenciados por este app; qualquer uso deve ser tratado com profissional médico habilitado.',
                    ],
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
        const Text(
          'PLANO ALIMENTAR',
          style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w800, letterSpacing: 1.4, fontSize: 12),
        ),
        const SizedBox(height: 7),
        Text('11 semanas', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        const Text(
          'Sem horários fixos: adapte as refeições à rotina, mantendo todas ao longo do dia e a ordem sempre que possível.',
          style: TextStyle(color: AppTheme.muted, height: 1.45),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _MetricCard({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: AppTheme.accent.withValues(alpha: .12), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: AppTheme.accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                Text(label, style: const TextStyle(color: AppTheme.muted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final _Meal meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: AppTheme.accent.withValues(alpha: .12), borderRadius: BorderRadius.circular(999)),
                child: Text(meal.title, style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w800, fontSize: 12)),
              ),
              const Spacer(),
              const Icon(Icons.restaurant_rounded, color: AppTheme.muted, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(meal.subtitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 12),
          ...meal.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(Icons.circle, size: 5, color: AppTheme.accent),
                  ),
                  const SizedBox(width: 9),
                  Expanded(child: Text(item, style: const TextStyle(color: Color(0xFFD7DCE2), height: 1.35, fontSize: 13))),
                ],
              ),
            ),
          ),
          if (meal.note != null) ...[
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppTheme.surfaceAlt, borderRadius: BorderRadius.circular(12)),
              child: Text(meal.note!, style: const TextStyle(color: AppTheme.muted, fontSize: 11.5, height: 1.35)),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> lines;
  const _InfoPanel({required this.title, required this.icon, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.accent),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 14),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_rounded, color: AppTheme.success, size: 18),
                  const SizedBox(width: 9),
                  Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFD7DCE2), height: 1.4))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Meal {
  final String title;
  final String subtitle;
  final List<String> items;
  final String? note;
  const _Meal({required this.title, required this.subtitle, required this.items, this.note});
}
