import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../componets/app_theme.dart';
import '../data/training_data.dart';

class TreinoDetalhePage extends StatefulWidget {
  final WorkoutData workout;
  const TreinoDetalhePage({super.key, required this.workout});

  @override
  State<TreinoDetalhePage> createState() => _TreinoDetalhePageState();
}

class _TreinoDetalhePageState extends State<TreinoDetalhePage> {
  final Set<int> _completed = {};

  @override
  void initState() {
    super.initState();
    _restoreProgress();
  }

  String _completionKey(int index) => 'w${widget.workout.number}_exercise_${index}_done';

  Future<void> _restoreProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final restored = <int>{};
    for (var i = 0; i < widget.workout.exercises.length; i++) {
      if (prefs.getBool(_completionKey(i)) ?? false) restored.add(i);
    }
    if (mounted) setState(() => _completed.addAll(restored));
  }

  Future<void> _toggleComplete(int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completionKey(index), value);
    if (!mounted) return;
    setState(() {
      if (value) {
        _completed.add(index);
      } else {
        _completed.remove(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.workout.exercises.isEmpty
        ? 0.0
        : _completed.length / widget.workout.exercises.length;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: Text(widget.workout.title, style: const TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: AppTheme.bg,
      ),
      body: AppBackdrop(
        child: SafeArea(
          top: false,
          child: ResponsiveFrame(
            maxWidth: 980,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
                  sliver: SliverToBoxAdapter(
                    child: _WorkoutHeader(
                      workout: widget.workout,
                      progress: progress,
                      completed: _completed.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 120),
                  sliver: SliverList.separated(
                    itemCount: widget.workout.exercises.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final exercise = widget.workout.exercises[index];
                      return ExerciseCard(
                        workoutNumber: widget.workout.number,
                        exerciseIndex: index,
                        exercise: exercise,
                        completed: _completed.contains(index),
                        onCompleted: (value) => _toggleComplete(index, value),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkoutHeader extends StatelessWidget {
  final WorkoutData workout;
  final double progress;
  final int completed;

  const _WorkoutHeader({
    required this.workout,
    required this.progress,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workout.focus,
            style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w800, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            workout.description,
            style: const TextStyle(color: AppTheme.muted, height: 1.4),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: AppTheme.surfaceAlt,
                    valueColor: const AlwaysStoppedAnimation(AppTheme.accent),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$completed/${workout.exercises.length}',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'As cargas ficam salvas neste dispositivo. Priorize execução, amplitude e controle antes de aumentar o peso.',
            style: TextStyle(color: AppTheme.muted, fontSize: 12, height: 1.35),
          ),
        ],
      ),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final int workoutNumber;
  final int exerciseIndex;
  final ExerciseData exercise;
  final bool completed;
  final ValueChanged<bool> onCompleted;

  const ExerciseCard({
    super.key,
    required this.workoutNumber,
    required this.exerciseIndex,
    required this.exercise,
    required this.completed,
    required this.onCompleted,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late final List<TextEditingController> _controllers;
  bool _expanded = false;
  bool _savedFlash = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.exercise.prescriptions.length,
      (_) => TextEditingController(),
    );
    _restoreLoads();
  }

  String _loadKey(int prescriptionIndex) =>
      'w${widget.workoutNumber}_e${widget.exerciseIndex}_p${prescriptionIndex}_kg';

  Future<void> _restoreLoads() async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < _controllers.length; i++) {
      _controllers[i].text = prefs.getString(_loadKey(i)) ?? '';
    }
    if (mounted) setState(() {});
  }

  Future<void> _saveLoads() async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < _controllers.length; i++) {
      await prefs.setString(_loadKey(i), _controllers[i].text.trim());
    }
    if (!mounted) return;
    setState(() => _savedFlash = true);
    Future<void>.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _savedFlash = false);
    });
  }

  void _showReference() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surface,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.exercise.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 7),
              Text(widget.exercise.muscles, style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w700)),
              const SizedBox(height: 18),
              const Text('PONTO-CHAVE DE EXECUÇÃO', style: TextStyle(color: AppTheme.muted, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.1)),
              const SizedBox(height: 7),
              Text(widget.exercise.executionCue, style: const TextStyle(height: 1.5, fontSize: 15)),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _openVideoReference,
                  icon: const Icon(Icons.play_circle_outline_rounded),
                  label: const Text('VER REFERÊNCIA EM VÍDEO'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.accent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'A referência abre uma busca pelo exercício. Compare a execução com a orientação do seu treinador e ajuste máquinas conforme o equipamento da sua academia.',
                style: TextStyle(color: AppTheme.muted, fontSize: 11.5, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openVideoReference() async {
    final uri = Uri.https(
      'www.youtube.com',
      '/results',
      {'search_query': widget.exercise.referenceQuery},
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: widget.completed ? const Color(0xFF121B17) : AppTheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: widget.completed ? AppTheme.success.withValues(alpha: .45) : AppTheme.border,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => widget.onCompleted(!widget.completed),
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: widget.completed ? AppTheme.success : AppTheme.surfaceAlt,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        widget.completed ? Icons.check_rounded : Icons.fitness_center_rounded,
                        color: widget.completed ? Colors.black : AppTheme.accent,
                        size: 21,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w900,
                            decoration: widget.completed ? TextDecoration.lineThrough : null,
                            decorationColor: AppTheme.muted,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(exercise.muscles, style: const TextStyle(color: AppTheme.muted, fontSize: 12.5)),
                        const SizedBox(height: 9),
                        Wrap(
                          spacing: 7,
                          runSpacing: 7,
                          children: exercise.prescriptions
                              .map(
                                (p) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceAlt,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    '${p.sets > 1 ? '${p.sets}× ' : ''}${p.reps}',
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFFD7DCE2)),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(_expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: AppTheme.muted),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 180),
            crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: Column(
                children: [
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  ...List.generate(
                    exercise.prescriptions.length,
                    (index) => _LoadRow(
                      prescription: exercise.prescriptions[index],
                      controller: _controllers[index],
                    ),
                  ),
                  const SizedBox(height: 6),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final narrow = constraints.maxWidth < 520;
                      final referenceButton = OutlinedButton.icon(
                        onPressed: _showReference,
                        icon: const Icon(Icons.ondemand_video_rounded, size: 19),
                        label: const Text('VER EXECUÇÃO'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.accent,
                          side: BorderSide(color: AppTheme.accent.withValues(alpha: .45)),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                          textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                        ),
                      );
                      final saveButton = FilledButton.icon(
                        onPressed: _saveLoads,
                        icon: Icon(_savedFlash ? Icons.check_rounded : Icons.save_outlined, size: 19),
                        label: Text(_savedFlash ? 'SALVO' : 'SALVAR CARGAS'),
                        style: FilledButton.styleFrom(
                          backgroundColor: _savedFlash ? AppTheme.success : AppTheme.accent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                          textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                        ),
                      );

                      if (narrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [referenceButton, const SizedBox(height: 10), saveButton],
                        );
                      }
                      return Row(
                        children: [Expanded(child: referenceButton), const SizedBox(width: 10), Expanded(child: saveButton)],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadRow extends StatelessWidget {
  final SetPrescription prescription;
  final TextEditingController controller;
  const _LoadRow({required this.prescription, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 520;
        final info = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prescription.label,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              '${prescription.sets > 1 ? '${prescription.sets} séries • ' : ''}${prescription.reps}',
              style: const TextStyle(color: AppTheme.muted, fontSize: 12),
            ),
          ],
        );

        final input = SizedBox(
          width: narrow ? double.infinity : 120,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
            decoration: const InputDecoration(
              hintText: 'Carga',
              suffixText: 'kg',
              isDense: true,
            ),
          ),
        );

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceAlt,
            borderRadius: BorderRadius.circular(15),
          ),
          child: narrow
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [info, const SizedBox(height: 10), input])
              : Row(children: [Expanded(child: info), const SizedBox(width: 12), input]),
        );
      },
    );
  }
}
