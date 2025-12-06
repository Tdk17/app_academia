import 'dart:convert';
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// =======================================
///  PÁGINAS ESPECÍFICAS (TREINO 1 A 5)
/// =======================================

class Treino1Page extends StatelessWidget {
  const Treino1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return TreinoDetalheBase(
      appBarTitle: 'Treino 1',
      prefsKey: 'treino_1',
      initialExercises: const [
        Exercise(title: 'Prancha isométrica'),
        Exercise(title: 'Cadeira abdutora'),
        Exercise(title: 'Terra sumô'),
        Exercise(title: 'Elevação pélvica'),
        Exercise(title: 'Stiff RDL barra ou máquina'),
        Exercise(title: 'Mesa flexora'),
        Exercise(title: 'Cadeira flexora'),
        Exercise(title: 'Panturrilha em pé'),
      ],
    );
  }
}

class Treino2Page extends StatelessWidget {
  const Treino2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return TreinoDetalheBase(
      appBarTitle: 'Treino 2',
      prefsKey: 'treino_2',
      initialExercises: const [
        Exercise(title: 'Voador peitoral'),
        Exercise(title: 'Supino inclinado máquina'),
        Exercise(title: 'Supino inclinado com halter'),
        Exercise(title: 'Supino reto barra ou máquina'),
        Exercise(title: 'Desenvolvimento no Smith'),
        Exercise(title: 'Elevação lateral polia com triângulo no pulso'),
        Exercise(title: 'Tríceps francês no cross unilateral'),
        Exercise(title: 'Abdominal infra solo'),
      ],
    );
  }
}

class Treino3Page extends StatelessWidget {
  const Treino3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return TreinoDetalheBase(
      appBarTitle: 'Treino 3',
      prefsKey: 'treino_3',
      initialExercises: const [
        Exercise(title: 'Puxada alta pegada fechada'),
        Exercise(title: 'Puxada alta articulada unilateral'),
        Exercise(title: 'Pulldown corda no cross'),
        Exercise(title: 'Remada baixa triângulo'),
        Exercise(title: 'Remada curvada barra'),
        Exercise(title: 'Rosca Scott máquina ou barra W'),
        Exercise(title: 'Abdominal supra banco declinado'),
      ],
    );
  }
}

class Treino4Page extends StatelessWidget {
  const Treino4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return TreinoDetalheBase(
      appBarTitle: 'Treino 4',
      prefsKey: 'treino_4',
      initialExercises: const [
        Exercise(title: 'Prancha isométrica'),
        Exercise(title: 'Cadeira extensora'),
        Exercise(title: 'Agachamento livre ou Smith'),
        Exercise(title: 'Leg Press 45°'),
        Exercise(title: 'Hack 180'),
        Exercise(title: 'Búlgaro com halteres'),
        Exercise(title: 'Cadeira adutora'),
        Exercise(title: 'Panturrilha sentado'),
      ],
    );
  }
}

class Treino5Page extends StatelessWidget {
  const Treino5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return TreinoDetalheBase(
      appBarTitle: 'Treino 5',
      prefsKey: 'treino_5',
      initialExercises: const [
        Exercise(title: 'Crucifixo inclinado no cross'),
        Exercise(title: 'Supino declinado máquina'),
        Exercise(title: 'Elevação frontal com halteres'),
        Exercise(title: 'Elevação lateral com halteres'),
        Exercise(title: 'Remada cavalinho pegada aberta'),
        Exercise(title: 'Lombar no banco romano (segurando anilha)'),
        Exercise(title: 'Rosca concentrada sentado unilateral com halteres'),
        Exercise(title: 'Tríceps barra no cross'),
        Exercise(title: 'Abdominal corda no cross'),
      ],
    );
  }
}

/// =======================================
///  BASE GENÉRICA (MESMO PADRÃO QUE O TEU)
/// =======================================

class TreinoDetalheBase extends StatefulWidget {
  final String appBarTitle;
  final String prefsKey;
  final List<Exercise> initialExercises;

  const TreinoDetalheBase({
    super.key,
    required this.appBarTitle,
    required this.prefsKey,
    required this.initialExercises,
  });

  @override
  State<TreinoDetalheBase> createState() => _TreinoDetalheBaseState();
}

class _TreinoDetalheBaseState extends State<TreinoDetalheBase> {
  late List<Exercise> _exercises;

  @override
  void initState() {
    super.initState();
    // cópia pra poder editar sem mexer na lista original
    _exercises = widget.initialExercises
        .map(
          (e) => Exercise(
            title: e.title,
            weights: [...e.weights],
            history: [...e.history],
          ),
        )
        .toList();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(widget.prefsKey);
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
    await prefs.setString(widget.prefsKey, payload);

    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(const SnackBar(content: Text('Pesos salvos!')));
  }

  void _onExerciseCompleted(int index) {
    final ex = _exercises[index];

    // garante que todas as 4 cargas foram preenchidas
    final ok = ex.weights.every((w) => w.trim().isNotEmpty);
    if (!ok) return;

    final List<List<String>> newHistory = List.from(ex.history);
    final current = List<String>.from(ex.weights);

    if (newHistory.isEmpty || !_listsEqual(newHistory.last, current)) {
      newHistory.add(current);
    }

    setState(() {
      _exercises[index] = ex.copyWith(history: newHistory);
    });

    _save();
  }

  /// NOVO: remover o último treino desse exercício
  Future<void> _removeLastFromHistory(int index) async {
    final ex = _exercises[index];
    if (ex.history.isEmpty) return;

    final newHistory = List<List<String>>.from(ex.history)..removeLast();

    setState(() {
      _exercises[index] = ex.copyWith(history: newHistory);
    });

    await _save();

    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(
      const SnackBar(content: Text('Último treino apagado!')),
    );
  }

  bool _listsEqual(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final useBluePalette = false; // igual à tua
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
      decoration: gradientBg,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.appBarTitle),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
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
          ),
        ),
        body: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (ctx, i) => ExerciseCard(
                accent: base,
                exercise: _exercises[i],
                onChanged: (weights) {
                  setState(() {
                    _exercises[i] = _exercises[i].copyWith(weights: weights);
                  });
                },
                onLastFieldCompleted: () => _onExerciseCompleted(i),
                onDeleteLast: () => _removeLastFromHistory(i), // NOVO
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

/// =======================================
///  MODELO + CARD COM HISTÓRICO
/// =======================================

class Exercise {
  final String title;

  /// pesos atuais do treino [aquecimento, s1, s2, s3]
  final List<String> weights;

  /// histórico de treinos anteriores: cada item é uma lista de 4 pesos
  /// [aquecimento, s1, s2, s3]
  final List<List<String>> history;

  const Exercise({
    required this.title,
    List<String>? weights,
    List<List<String>>? history,
  }) : weights = weights ?? const ['', '', '', ''],
       history = history ?? const [];

  Exercise copyWith({
    String? title,
    List<String>? weights,
    List<List<String>>? history,
  }) => Exercise(
    title: title ?? this.title,
    weights: weights ?? this.weights,
    history: history ?? this.history,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'weights': weights,
    'history': history,
  };

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    title: json['title'] as String,
    weights:
        (json['weights'] as List?)?.cast<String>() ?? const ['', '', '', ''],
    history:
        (json['history'] as List?)
            ?.map((e) => (e as List).cast<String>())
            .toList() ??
        const [],
  );
}

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;
  final ValueChanged<List<String>> onChanged;
  final VoidCallback onLastFieldCompleted;
  final VoidCallback? onDeleteLast; // NOVO
  final Color accent;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onChanged,
    required this.onLastFieldCompleted,
    required this.accent,
    this.onDeleteLast, // NOVO
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
    labelText: ' ',
    labelStyle: const TextStyle(color: Colors.white70, fontSize: 11),
    filled: true,
    fillColor: Colors.white.withOpacity(0.06),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    counterText: '',
    suffixText: 'kg',
    suffixStyle: const TextStyle(color: Colors.white70),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: widget.accent.withOpacity(0.6), width: 1.5),
    ),
  );

  double? _parse(String s) {
    final t = s.replaceAll(',', '.').trim();
    if (t.isEmpty) return null;
    return double.tryParse(t);
  }

  @override
  Widget build(BuildContext context) {
    final green = widget.accent;
    final history = widget.exercise.history;
    List<String>? last;
    if (history.isNotEmpty) {
      last = history.last;
    }

    final currentValues = List.generate(4, (i) => _parse(_controllers[i].text));
    final previousValues = last == null
        ? List<double?>.filled(4, null)
        : List.generate(4, (i) => _parse(last![i]));

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [green.withOpacity(0.28), green.withOpacity(0.18)],
            ),
            borderRadius: BorderRadius.circular(16),
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
                    child: Text(
                      widget.exercise.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.save),
                    color: Colors.white,
                    onPressed: () {
                      _propagate();
                      widget.onLastFieldCompleted();
                    },
                    tooltip: 'Salvar treino',
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // chips estáticos
              const Row(
                children: [
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
                        style: const TextStyle(color: Colors.white),
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
                          if (i == 3) {
                            widget.onLastFieldCompleted();
                          }
                          FocusScope.of(context).unfocus();
                        },
                        decoration: _boxDecoration(),
                      ),
                    ),
                    if (i != 3) const SizedBox(width: 12),
                  ],
                ],
              ),

              // histórico (último treino + setinhas + botão excluir)
              if (last != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Último treino',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (widget.onDeleteLast != null)
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 18,
                          color: Colors.redAccent,
                        ),
                        onPressed: widget.onDeleteLast,
                        tooltip: 'Apagar último treino',
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: List.generate(4, (i) {
                    final prev = previousValues[i];
                    final curr = currentValues[i];
                    int diffFlag =
                        0; // 0 = igual/sem info, 1 = subiu, -1 = desceu

                    if (prev != null && curr != null) {
                      if (curr > prev) {
                        diffFlag = 1;
                      } else if (curr < prev) {
                        diffFlag = -1;
                      }
                    }

                    return Expanded(
                      child: _HistoryBadge(
                        label: last![i].isEmpty ? '--' : '${last[i]} kg',
                        diffFlag: diffFlag,
                      ),
                    );
                  }),
                ),
              ],
            ],
          ),
        ),
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

class _HistoryBadge extends StatelessWidget {
  final String label;

  /// 1 = aumento, -1 = diminuiu, 0 = igual / sem info
  final int diffFlag;

  const _HistoryBadge({required this.label, required this.diffFlag});

  @override
  Widget build(BuildContext context) {
    IconData? icon;
    Color color = Colors.white70;

    if (diffFlag == 1) {
      icon = Icons.arrow_upward_rounded;
      color = Colors.greenAccent;
    } else if (diffFlag == -1) {
      icon = Icons.arrow_downward_rounded;
      color = Colors.redAccent;
    }

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.14)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
