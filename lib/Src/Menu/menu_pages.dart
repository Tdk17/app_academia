import 'dart:ui';
import 'package:flutter/material.dart';

class MenuPages extends StatelessWidget {
  const MenuPages({super.key});

  @override
  Widget build(BuildContext context) {
    final useBluePalette = false;
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
                        'Finalização • 14 dias',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 16),

                      // CARD VISÃO GERAL (AJUSTADO AO DOCUMENTO)
                      _OverviewCard(accent: base),

                      const SizedBox(height: 20),

                      _SectionTitle(text: 'Regras do protocolo'),
                      const SizedBox(height: 10),
                      _DietCard(
                        accent: base,
                        icon: Icons.rule_rounded,
                        title: 'Leia atentamente',
                        subtitle: 'Sem desvios',
                        items: const [
                          'Começar a esfoliação da pele na segunda à noite com fubá e detergente neutro (com bucha vegetal e sem riscar).',
                          'Não pode usar nenhum hidratante.',
                          'Cortar: gelatina zero/diet, refrigerante zero, adoçante e molhos de qualquer tipo.',
                          'Preparar as comidas sem sal e usar somente o sal do protocolo após pesar a refeição.',
                          'Comprar sachê de sal e adicionar nas comidas conforme protocolo.',
                          'Não utilizar nenhum tempero: sem óleo, sem temperos prontos.',
                          'Não usar alho e nem cebola.',
                          'Não fazer nada diferente do protocolo sem consultar o coach.',
                          'Folhas verdes: alface, agrião, chicória, couve, espinafre e rúcula.',
                          'Vegetais: cenoura OU pepino japonês.',
                          'Café preto puro e canela em pó liberados (a água do café conta na hidratação).',
                          'Seguir a ordem prescrita das refeições e o planejamento de treinos sem erros.',
                        ],
                      ),

                      const SizedBox(height: 20),
                      _SectionTitle(text: 'Rotina & Cardio'),
                      const SizedBox(height: 10),

                      _DietCard(
                        accent: base,
                        icon: Icons.wb_sunny_outlined,
                        title: 'Ao acordar',
                        subtitle: 'Começo do dia',
                        items: const [
                          'Tomar imediatamente 500ml de água.',
                          'Realizar 10 sessões de vacuum abdominal.',
                        ],
                      ),
                      const SizedBox(height: 14),
                      _DietCard(
                        accent: base,
                        icon: Icons.directions_run_rounded,
                        title: 'Atividade cardiovascular',
                        subtitle: 'Todos os dias',
                        items: const [
                          '120 min de cardio TODOS OS DIAS.',
                          '1 hora ao acordar em jejum + 1 hora após o treino.',
                        ],
                      ),

                      const SizedBox(height: 24),
                      _SectionTitle(text: 'Hidratação & sódio'),
                      const SizedBox(height: 10),
                      _DietCard(
                        accent: base,
                        icon: Icons.water_drop_outlined,
                        title: 'Protocolo (até sexta 20/02/2026)',
                        subtitle: 'Controle diário',
                        items: const [
                          '5 litros de água/dia.',
                          '7g de sal por dia dividido nas refeições de proteína.',
                          '2g de vitamina C divididos durante o dia.',
                        ],
                      ),

                      const SizedBox(height: 24),
                      _SectionTitle(text: 'Refeições do dia'),
                      const SizedBox(height: 10),

                      // Refeição 1
                      _DietCard(
                        accent: base,
                        icon: Icons.free_breakfast_rounded,
                        title: 'Refeição 1',
                        subtitle: 'Café da manhã',
                        items: const [
                          '2 ovos inteiros.',
                          '2 claras.',
                          '50g tomate + 50g couve OU espinafre OU rúcula.',
                          '150g mamão.',
                          'Após a refeição: Vitamina C 1g / Ômega 3 (1g) / NAC 600mg / 1 multivitamínico.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Refeição 2
                      _DietCard(
                        accent: base,
                        icon: Icons.lunch_dining_rounded,
                        title: 'Refeição 2',
                        subtitle: 'Proteína + vegetais',
                        items: const [
                          '100g peito de frango.',
                          '100g legumes/vegetais.',
                          'Folhas verdes à vontade.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Refeição 3 (Pré-treino)
                      _DietCard(
                        accent: base,
                        icon: Icons.fitness_center_rounded,
                        title: 'Refeição 3 – Pré-treino',
                        subtitle: 'Somente dia de treino',
                        items: const [
                          '100g arroz (somente dias de treino; em dias sem treino NÃO comer).',
                          '170g peito de frango.',
                          '100g legumes/vegetais.',
                          'Folhas verdes à vontade.',
                          '100g mamão OU 100g abacaxi.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Intra-treino
                      _DietCard(
                        accent: base,
                        icon: Icons.local_drink_rounded,
                        title: 'Intra-treino',
                        subtitle: 'Durante o treino',
                        items: const [
                          '2 litros de água gelada.',
                          '10g creatina.',
                          '2g sal (conta do total do dia).',
                          '20g glicerina líquida.',
                          'Clight 0/5 OU um “chorinho” de pré-treino para dar gosto.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Refeição 4 (Pós-treino)
                      _DietCard(
                        accent: base,
                        icon: Icons.restaurant_rounded,
                        title: 'Refeição 4 – Pós-treino',
                        subtitle: 'Recuperação',
                        items: const [
                          '150g peito de frango.',
                          '40g goma de tapioca.',
                          '100g legumes/vegetais.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Refeição 5
                      _DietCard(
                        accent: base,
                        icon: Icons.dinner_dining_rounded,
                        title: 'Refeição 5',
                        subtitle: 'Jantar',
                        items: const [
                          '150g peito de frango OU 200g filé de tilápia.',
                          '100g legumes/vegetais.',
                          'Folhas verdes à vontade.',
                          '100g mamão OU 100g abacaxi.',
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Refeição 6 (Ceia)
                      _DietCard(
                        accent: base,
                        icon: Icons.nightlight_round_rounded,
                        title: 'Refeição 6 – Ceia',
                        subtitle: 'Antes de dormir',
                        items: const [
                          '160g iogurte natural desnatado.',
                          '20g whey.',
                          '100g maçã.',
                          'Vitamina C 1g / Ômega 3 (1g) / NAC 600mg.',
                        ],
                      ),

                      const SizedBox(height: 24),
                      _SectionTitle(text: 'Protocolos médicos (bloqueado)'),
                      const SizedBox(height: 10),
                      _DietCard(
                        accent: base,
                        icon: Icons.health_and_safety_rounded,
                        title: 'Apenas com liberação profissional',
                        subtitle: 'Conteúdo sensível',
                        items: const [
                          'O documento contém protocolos farmacológicos/termogênicos com doses.',
                          'Por segurança, esta tela não exibe essas instruções.',
                          'Se você quiser, eu deixo pronto um “toggle” (admin) pra mostrar só com senha e confirmação médica.',
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
                  const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
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
                  const Icon(
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
                  const Icon(
                    Icons.update_rounded,
                    size: 18,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Próxima atualização: 20/02/2026',
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Sem horário fixo: cumprir todas as refeições no dia.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
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
