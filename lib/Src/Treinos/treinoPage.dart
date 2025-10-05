import 'dart:convert';

import 'dart:ui' show ImageFilter; // ⭐ para possível blur futuro
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TreinoDetalhePage extends StatefulWidget {
  const TreinoDetalhePage({super.key});

  @override
  State<TreinoDetalhePage> createState() => _TreinoDetalhePageState();
}

class _TreinoDetalhePageState extends State<TreinoDetalhePage> {
  final _exercises = <Exercise>[
    Exercise(title: 'Supino Inclinado na Barra 4×8'),
    Exercise(title: 'Supino reto halter 4×8'),
    Exercise(title: 'Elevação Lateral 4×8'),
  ];

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('treino_peito');
    if (raw == null || raw.isEmpty) return;

    final list = jsonDecode(raw) as List<dynamic>;
    for (int i = 0; i < _exercises.length && i < list.length; i++) {
      final map = Map<String, dynamic>.from(list[i] as Map);
      _exercises[i] = Exercise.fromJson(map);
    }
    if (mounted) setState(() {});
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = jsonEncode(_exercises.map((e) => e.toJson()).toList());
    await prefs.setString('treino_peito', payload);

    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(const SnackBar(content: Text('Pesos salvos!')));
  }

  void _onExerciseCompleted(int index) {
    final ok = _exercises[index].weights.every((w) => w.trim().isNotEmpty);
    if (ok) _save();
  }

  @override
  Widget build(BuildContext context) {
    // ⭐ Paleta alinhada às outras telas
    final useBluePalette = false; // mude p/ true se quiser azul+preto
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

    return Container(
      // ⭐ fundo igual às outras telas
      decoration: gradientBg,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Treino Detalhe'),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.transparent, // ⭐
          flexibleSpace: Container(
            // ⭐ gradiente na AppBar
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, base.withOpacity(0.28)],
              ),
            ),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
            letterSpacing: 0.2,
          ), // ⭐
        ),
        body: Material(
          color: Colors.transparent, // ⭐ deixa ver o gradiente
          child: Padding(
            padding: const EdgeInsets.only(top: 24), // 40 -> 24 ⭐
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (ctx, i) => ExerciseCard(
                accent: base, // ⭐ passa a cor p/ o card
                exercise: _exercises[i],
                onChanged: (weights) {
                  setState(() {
                    _exercises[i] = _exercises[i].copyWith(weights: weights);
                  });
                },
                onLastFieldCompleted: () => _onExerciseCompleted(i),
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: _exercises.length,
            ),
          ),
        ),
      ),
    );
  }
}

/// Modelo simples
class Exercise {
  final String title;
  final List<String> weights; // [aquecimento, s1, s2, s3]

  Exercise({required this.title, List<String>? weights})
    : weights = weights ?? List.filled(4, '');

  Exercise copyWith({String? title, List<String>? weights}) =>
      Exercise(title: title ?? this.title, weights: weights ?? this.weights);

  Map<String, dynamic> toJson() => {'title': title, 'weights': weights};

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    title: json['title'] as String,
    weights: (json['weights'] as List).cast<String>(),
  );
}

/// Cartão do exercício
class ExerciseCard extends StatefulWidget {
  final Exercise exercise;
  final ValueChanged<List<String>> onChanged;
  final VoidCallback onLastFieldCompleted;
  final Color accent; // ⭐

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onChanged,
    required this.onLastFieldCompleted,
    required this.accent, // ⭐
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
      (i) => TextEditingController(text: widget.exercise.weights[i]),
    );
  }

  @override
  void didUpdateWidget(covariant ExerciseCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (var i = 0; i < 4; i++) {
      final newText = widget.exercise.weights[i];
      if (_controllers[i].text != newText) {
        _controllers[i].text = newText;
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _propagate() {
    widget.onChanged(_controllers.map((c) => c.text).toList());
  }

  InputDecoration _boxDecoration() => InputDecoration(
    labelText: ' ', // mantém rótulo vazio
    labelStyle: const TextStyle(color: Colors.white70, fontSize: 11),
    filled: true,
    fillColor: Colors.white.withOpacity(0.06), // ⭐ dark input
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    counterText: '',
    suffixText: 'kg',
    suffixStyle: const TextStyle(color: Colors.white70), // ⭐
    enabledBorder: OutlineInputBorder(
      // ⭐ borda sutil
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
    ),
    focusedBorder: OutlineInputBorder(
      // ⭐ foco com a cor de destaque
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: widget.accent.withOpacity(0.6), width: 1.5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final green = widget.accent; // Colors.green[800]!;
    return Stack(
      children: [
        // ⭐ fundo glass + borda + sombra leve
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [green.withOpacity(0.28), green.withOpacity(0.18)],
            ),
            borderRadius: BorderRadius.circular(16), // 14 -> 16
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // ⭐ evita quebra feia de título grande
                    child: Text(
                      widget.exercise.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700, // 600 -> 700
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.save),
                    color: Colors.white,
                    onPressed: () =>
                        Navigator.of(context).pop(), // mantém lógica
                    tooltip: 'Salvar',
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // chips estáticos
              Row(
                children: const [
                  _Pill('Aquecimento'),
                  SizedBox(width: 8),
                  _Pill('Válida'),
                  SizedBox(width: 8),
                  _Pill('Válida'),
                  SizedBox(width: 8),
                  _Pill('Válida'),
                ],
              ),
              const SizedBox(height: 10),

              // inputs
              Row(
                children: [
                  for (int i = 0; i < 4; i++) ...[
                    Expanded(
                      child: TextField(
                        controller: _controllers[i],
                        style: const TextStyle(color: Colors.white), // ⭐
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        maxLength: 5,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d{0,3}([.,]\d{0,1})?$'),
                          ),
                          TextInputFormatter.withFunction((oldV, newV) {
                            final t = newV.text.replaceAll(',', '.');
                            return newV.copyWith(
                              text: t,
                              selection: TextSelection.collapsed(
                                offset: t.length,
                              ),
                            );
                          }),
                        ],
                        onChanged: (_) => _propagate(),
                        onEditingComplete: () {
                          _propagate();
                          if (i == 3)
                            widget.onLastFieldCompleted(); // salva no último
                          FocusScope.of(context).unfocus();
                        },
                        decoration: _boxDecoration(),
                      ),
                    ),
                    if (i != 3) const SizedBox(width: 12),
                  ],
                ],
              ),
            ],
          ),
        ),
        // ⭐ brilho suave no canto (estético)
        Positioned(
          right: 12,
          top: 10,
          child: IgnorePointer(
            child: Container(
              width: 56,
              height: 56,
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

class _Pill extends StatelessWidget {
  final String text;
  const _Pill(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
