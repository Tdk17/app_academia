import 'dart:ui';
import 'package:flutter/material.dart';

class MenuPages extends StatelessWidget {
  const MenuPages({super.key});

  @override
  Widget build(BuildContext context) {
    final useBluePalette = false; // mesmo esquema do TreinoPage
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
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Minha Dieta',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sugestão alimentar adaptativa',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 16),

                      // CARD VISÃO GERAL
                      _OverviewCard(accent: base),

                      const SizedBox(height: 20),

                      _SectionTitle(text: 'Rotina & Cardio'),
                      const SizedBox(height: 10),
                      _DietCard(
                        accent: base,
                        icon: Icons.water_drop_outlined,
                        title: 'Hidratação & Rotina',
                        subtitle: 'Base diária',
                        items: const [
                          '4 a 4,5 litros de água durante o dia.',
                          'Ao acordar: 300 a 500ml de água.',
                          'Realizar 5 sessões de vácuo abdominal ao acordar.',
                          'Café preto sem açúcar à vontade, mas com moderação.',
                          'Gelatina zero/diet e calda zero quando bater vontade de doce.',
                        ],
                      ),
                      const SizedBox(height: 14),
                      _DietCard(
                        accent: base,
                        icon: Icons.directions_run_rounded,
                        title: 'Atividade cardiovascular',
                        subtitle: 'Dias de treino e descanso',
                        items: const [
                          '45 minutos de cardio nos dias de treino de musculação.',
                          '60 minutos de cardio nos dias de descanso da musculação.',
                        ],
                      ),

                      const SizedBox(height: 24),
                      _SectionTitle(text: 'Refeições do dia'),
                      const SizedBox(height: 10),

                      // REFEIÇÃO 1
                      _DietCard(
                        accent: base,
                        icon: Icons.free_breakfast_rounded,
                        title: 'Refeição 1 – Pré-treino',
                        subtitle: 'Ao acordar / antes do treino',
                        items: const [
                          '2 ovos inteiros.',
                          '20g de requeijão light.',
                          '2 fatias de pão (50g) OU 50g pão francês OU 50g aveia OU 50g goma de tapioca.',
                          '1 porção de fruta: 50g banana/uva OU 100g maçã/kiwi/mamão/abacaxi OU 150g melão/melancia/morango.',
                          '100ml de leite desnatado no café (somente nessa refeição).',
                          'Adoçante e canela em pó a gosto, sem exageros.',
                          'SUPLEMENTOS APÓS A REFEIÇÃO: Vitamina C 1g, 1 dose de ômega 3 (1g), 1 cps de NAC 600mg, 1 multivitamínico, 7g de creatina.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // REFEIÇÃO 2
                      _DietCard(
                        accent: base,
                        icon: Icons.lunch_dining_rounded,
                        title: 'Refeição 2 – Pós-treino',
                        subtitle: 'Recuperação',
                        items: const [
                          '100g de arroz OU 100g aipim (mandioca) OU 100g macarrão OU 200g batata inglesa.',
                          '100g peito de frango OU 100g carne vermelha magra OU 100g filé mignon suíno.',
                          '100g de legumes/vegetais à escolha.',
                          'Folhas verdes à vontade.',
                          '70g mamão OU 70g abacaxi.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // REFEIÇÃO 3
                      _DietCard(
                        accent: base,
                        icon: Icons.restaurant_rounded,
                        title: 'Refeição 3 – Almoço',
                        subtitle: 'Base de dia',
                        items: const [
                          '100g de arroz OU 100g aipim (mandioca) OU 100g macarrão OU 200g batata inglesa.',
                          '120g peito de frango OU 120g carne vermelha magra OU 120g filé mignon suíno.',
                          '100g de legumes/vegetais à escolha.',
                          'Folhas verdes à vontade.',
                          '70g mamão OU 70g abacaxi.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // REFEIÇÃO 4
                      _DietCard(
                        accent: base,
                        icon: Icons.bakery_dining_rounded,
                        title: 'Refeição 4 – Lanche da tarde',
                        subtitle: 'Lanche estratégico',
                        items: const [
                          '70g peito de frango OU 20g whey.',
                          '20g goma de tapioca OU 1 fatia de pão (25g) OU 1 Rap10 OU 25g pão francês OU 60g batata doce.',
                          '1 porção de fruta: 50g banana/uva OU 100g maçã/kiwi/mamão/abacaxi OU 150g melão/melancia/morango.',
                          'Tomate, alface, cebola a gosto.',
                          'DIA DE DESCANSO DE TREINO: adicionar 30g de amêndoas ou castanhas.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // REFEIÇÃO 5
                      _DietCard(
                        accent: base,
                        icon: Icons.dinner_dining_rounded,
                        title: 'Refeição 5 – Jantar',
                        subtitle: 'Fechando o dia',
                        items: const [
                          '100g arroz OU 100g aipim (mandioca) OU 100g macarrão OU 200g batata inglesa OU 50g pão francês.',
                          '120g peito de frango OU 120g carne vermelha magra OU 120g filé mignon suíno.',
                          '100g de legumes/vegetais à escolha.',
                          'Folhas verdes à vontade.',
                          '100g mamão OU 100g abacaxi.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // REFEIÇÃO 6
                      _DietCard(
                        accent: base,
                        icon: Icons.nightlight_round_rounded,
                        title: 'Refeição 6 – Ceia',
                        subtitle: 'Antes de dormir',
                        items: const [
                          '160g iogurte natural desnatado.',
                          '20g whey.',
                          '1 porção de fruta: 50g banana/uva OU 100g maçã/kiwi/mamão/abacaxi OU 150g melão/melancia/morango.',
                          '20g amêndoas ou castanhas.',
                          'SUPLEMENTOS: Vitamina C 1g, 1 dose de ômega 3 (1g), 1 cps de NAC 600mg.',
                        ],
                      ),

                      const SizedBox(height: 24),
                      _SectionTitle(text: 'Refeed & refeição livre'),
                      const SizedBox(height: 10),

                      _DietCard(
                        accent: base,
                        icon: Icons.celebration_rounded,
                        title: 'Refeed / Refeição livre',
                        subtitle: 'A cada ciclo bem feito',
                        items: const [
                          'Refeed somente após sequência de dias com dieta 100% (sem erros).',
                          '1 refeição “livre” no sábado OU domingo, substituindo o jantar.',
                          'Manter boa fonte de proteína e controlar doces.',
                          'Exemplos: 1 hambúrguer artesanal com fritas + 1 doce pequeno, OU 4 fatias de pizza, OU churrasco com moderação.',
                        ],
                      ),

                      const SizedBox(height: 24),
                      _SectionTitle(text: 'Regras e observações'),
                      const SizedBox(height: 10),

                      _DietCard(
                        accent: base,
                        icon: Icons.rule_rounded,
                        title: 'Observações importantes',
                        subtitle: 'Disciplina total',
                        items: const [
                          'Não fazer nada de diferente sem consultar o coach antes.',
                          'Não usar gordura no preparo dos alimentos (usar métodos mais limpos).',
                          'Todas as quantidades se referem ao alimento pronto, já cozido/assado.',
                          'Bebida alcoólica, mesmo pouca, atrasa os resultados.',
                          'Bebidas zero kcal só eventualmente; priorizar água (mínimo 4L).',
                          'Nenhum detalhe deve ser negligenciado: siga a dieta na ordem.',
                          'Planejamento é fundamental: montar as refeições do dia com antecedência.',
                          'A eficácia depende exclusivamente do seu comprometimento e dedicação.',
                        ],
                      ),

                      const SizedBox(height: 80),
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

/// =====================
/// COMPONENTES VISUAIS
/// =====================

class _OverviewCard extends StatelessWidget {
  final Color accent;
  const _OverviewCard({required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent.withOpacity(0.30), Colors.white.withOpacity(0.05)],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.16), width: 1),
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
          // brilho de fundo
          Positioned(
            right: -30,
            top: -30,
            child: _SoftBlob(size: 130, color: accent.withOpacity(0.20)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_rounded, color: Colors.white, size: 26),
                  const SizedBox(width: 8),
                  Text(
                    'Pedro Henrique',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 18,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Início: 30/11/2025  •  Vencimento: 30/11/2026',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.update_rounded, size: 18, color: Colors.white70),
                  const SizedBox(width: 6),
                  Text(
                    'Próxima atualização: 13/12/2025 (depois, todo sábado)',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.18),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Sem horário fixo: cumprir todas as refeições no dia.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _DietCard extends StatelessWidget {
  final Color accent;
  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> items;

  const _DietCard({
    required this.accent,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent.withOpacity(0.24), Colors.white.withOpacity(0.04)],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.14), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            top: -18,
            child: _SoftBlob(size: 90, color: accent.withOpacity(0.20)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _IconBadge(icon: icon, accent: accent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...items.map(
                (t) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Expanded(
                        child: Text(
                          t,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.20),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withOpacity(0.28), width: 1),
          ),
          child: Icon(icon, size: 22, color: Colors.white),
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
        boxShadow: [BoxShadow(color: color, blurRadius: 40, spreadRadius: 20)],
      ),
    );
  }
}
