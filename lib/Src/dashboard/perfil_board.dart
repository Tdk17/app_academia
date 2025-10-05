import 'dart:math' as math;
import 'package:flutter/material.dart';

/// ======== DADOS ESTÁTICOS (por enquanto) ========
const kPeso = 77.0; // kg
const kMetaSupino = 100.0; // kg
const kCarga = 30; // %
const kFoco = 100; // %
const kForca = 130; // pontos (ajusto no gráfico para 0–100)
const kRepScore = 80; // nota de repetições (0–100)

// Medidas básicas (tabela da segunda imagem)
const medidasBasicas = {
  'Peso atual (kg)': '75',
  'Altura (cm)': '170',
  'IMC (kg/m²)': '26',
  'Classificação IMC': 'Sobrepeso',
  'RCQ': '0.82',
  'Risco por RCQ': 'Baixo',
  'CMB (cm)': '34.4',
  'Percentual de gordura (%)': '11.2',
  'Massa de gordura (kg)': '8.4',
  'Massa residual (kg)': '18.1',
  'Massa livre de gordura (kg)': '66.6',
  'Somatório de dobras (mm)': '35',
  'Densidade corporal (g/mL)': '1.074',
};

/// ======== PÁGINA ========
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // === fundo igual à primeira tela ===
    final useBluePalette = false; // mude p/ true se quiser azul + preto
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

    final green = Colors.green[800]!;
    final white = Colors.white;
    final cardBorder = Colors.white.withOpacity(0.12);

    // Gráfico radar
    final chartValues = <String, double>{
      'Força': _normalize(kForca, 0, 150), // 0–100
      'Rep': kRepScore.toDouble(),
      'Carga': kCarga.toDouble(),
      'Foco': kFoco.toDouble(),
    };

    return Container(
      // <<< fundo aplicado aqui
      decoration: gradientBg,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            // ===== Radar Chart =====
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 0, 0, 0), Color(0xFF22C55E)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cardBorder, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: AspectRatio(
                aspectRatio: 1.1,
                child: RadarChart(
                  values: chartValues,
                  maxValue: 100,
                  gridCount: 6,
                  fillColor: Colors.black.withOpacity(0.4),
                  strokeColor: white,
                  axisLabelStyle: const TextStyle(
                    color: Color.fromARGB(210, 255, 255, 255),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  gridColor: Colors.white.withOpacity(0.10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ===== Card métricas rápidas =====
            _CardRounded(
              color: green,
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.25,
                ),
                child: Column(
                  children: [
                    _duo(
                      'Força: ${kForca.toStringAsFixed(0)}',
                      'Meta: ${kMetaSupino.toStringAsFixed(0)} kg',
                    ),
                    const SizedBox(height: 10),
                    _duo(
                      'Carga: ${kCarga.toStringAsFixed(0)}%',
                      'Peso:  ${kPeso.toStringAsFixed(1)} kg',
                    ),
                    const SizedBox(height: 10),
                    _duo('Foco:  ${kFoco.toStringAsFixed(0)}%', ''),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ===== Objetivo =====
            const _CardRounded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Objetivo: Competir em uma competição de fisiculturismo 2026',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ===== Medidas básicas =====
            _CardRounded(
              color: green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Análises básicas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...medidasBasicas.entries.map(
                    (e) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  e.key,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                e.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // mantém assinatura/lógica
  Widget _duo(String left, String right) {
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (right.isNotEmpty)
          Expanded(
            child: Text(
              right,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
      ],
    );
  }
}

/// ======== WIDGETS AUXILIARES ========

class _CardRounded extends StatelessWidget {
  final Widget child;
  final Color? color;
  const _CardRounded({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    final base = color ?? Colors.green[800]!;

    return Stack(
      children: [
        // fundo “glass” com gradiente
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [base.withOpacity(0.85), base.withOpacity(0.70)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black.withOpacity(0.12), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
        // brilho suave no canto superior direito (só estética)
        Positioned(
          right: 8,
          top: 8,
          child: IgnorePointer(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.10), Colors.transparent],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ======== RADAR CHART SIMPLES (CustomPainter) ========
class RadarChart extends StatelessWidget {
  final Map<String, double> values; // label -> 0..maxValue
  final double maxValue;
  final int gridCount;
  final Color fillColor;
  final Color strokeColor;
  final Color gridColor;
  final TextStyle axisLabelStyle;

  const RadarChart({
    super.key,
    required this.values,
    required this.maxValue,
    this.gridCount = 4,
    required this.fillColor,
    required this.strokeColor,
    required this.gridColor,
    required this.axisLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final labels = values.keys.toList();
    final normalized = labels
        .map((k) => values[k]!.clamp(0, maxValue) / maxValue)
        .toList();

    return CustomPaint(
      painter: _RadarPainter(
        labels: labels,
        data: normalized,
        gridCount: gridCount,
        fill: fillColor,
        stroke: strokeColor,
        grid: gridColor,
        labelStyle: axisLabelStyle,
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final List<String> labels;
  final List<double> data; // 0..1
  final int gridCount;
  final Color fill, stroke, grid;
  final TextStyle labelStyle;

  _RadarPainter({
    required this.labels,
    required this.data,
    required this.gridCount,
    required this.fill,
    required this.stroke,
    required this.grid,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.78;
    final axisCount = labels.length;
    final angle = (2 * math.pi) / axisCount;

    final gridPaint = Paint()
      ..color = grid
      ..style = PaintingStyle.stroke;

    // grades
    for (int g = 1; g <= gridCount; g++) {
      final r = radius * (g / gridCount);
      final path = Path();
      for (int i = 0; i < axisCount; i++) {
        final a = -math.pi / 2 + angle * i;
        final p = center + Offset(math.cos(a) * r, math.sin(a) * r);
        if (i == 0) {
          path.moveTo(p.dx, p.dy);
        } else {
          path.lineTo(p.dx, p.dy);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // eixos + rótulos
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    for (int i = 0; i < axisCount; i++) {
      final a = -math.pi / 2 + angle * i;
      final end = center + Offset(math.cos(a) * radius, math.sin(a) * radius);
      canvas.drawLine(center, end, gridPaint);

      // label
      final labelOffset =
          center +
          Offset(math.cos(a) * (radius + 16), math.sin(a) * (radius + 16));
      textPainter.text = TextSpan(text: labels[i], style: labelStyle);
      textPainter.layout();
      final tp =
          labelOffset - Offset(textPainter.width / 2, textPainter.height / 2);
      textPainter.paint(canvas, tp);
    }

    // área preenchida (dados)
    final dataPath = Path();
    for (int i = 0; i < axisCount; i++) {
      final a = -math.pi / 2 + angle * i;
      final r = radius * data[i];
      final p = center + Offset(math.cos(a) * r, math.sin(a) * r);
      if (i == 0) {
        dataPath.moveTo(p.dx, p.dy);
      } else {
        dataPath.lineTo(p.dx, p.dy);
      }
    }
    dataPath.close();

    canvas.drawPath(
      dataPath,
      Paint()
        ..color = fill
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      dataPath,
      Paint()
        ..color = stroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) =>
      oldDelegate.data != data || oldDelegate.labels != labels;
}

/// ======== helpers ========
double _normalize(num value, num min, num max) {
  final v = (value - min) / (max - min);
  return (v * 100).clamp(0, 100).toDouble();
}
