class SetPrescription {
  final String label;
  final String reps;
  final int sets;

  const SetPrescription({
    required this.label,
    required this.reps,
    this.sets = 1,
  });
}

class ExerciseData {
  final String name;
  final String muscles;
  final String executionCue;
  final String referenceQuery;
  final List<SetPrescription> prescriptions;

  const ExerciseData({
    required this.name,
    required this.muscles,
    required this.executionCue,
    required this.referenceQuery,
    required this.prescriptions,
  });
}

class WorkoutData {
  final int number;
  final String title;
  final String focus;
  final String description;
  final List<ExerciseData> exercises;

  const WorkoutData({
    required this.number,
    required this.title,
    required this.focus,
    required this.description,
    required this.exercises,
  });
}

const workouts = <WorkoutData>[
  WorkoutData(
    number: 1,
    title: 'Treino 1',
    focus: 'Costas • bíceps • core',
    description: 'Dorsais, remadas, levantamento terra e finalização de bíceps.',
    exercises: [
      ExerciseData(
        name: 'Abdominal infra na paralela',
        muscles: 'Abdômen inferior • flexores do quadril',
        executionCue: 'Evite embalar o corpo. Suba os joelhos controlando a pelve e termine o movimento aproximando o púbis das costelas.',
        referenceQuery: 'abdominal infra paralela execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '15 reps', sets: 4)],
      ),
      ExerciseData(
        name: 'Levantamento terra barra livre',
        muscles: 'Posterior • glúteos • dorsais • core',
        executionCue: 'Crie pressão abdominal antes de tirar a barra do chão, mantenha-a próxima das pernas e faça quadril e ombros subirem juntos.',
        referenceQuery: 'levantamento terra barra livre execução correta',
        prescriptions: [
          SetPrescription(label: 'Aquecimento', reps: '20 reps'),
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Reconhecimento pesado', reps: '2–4 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 2),
          SetPrescription(label: 'Série pesada', reps: '4–6 reps'),
        ],
      ),
      ExerciseData(
        name: 'Remada curvada barra livre',
        muscles: 'Dorsais • romboides • bíceps',
        executionCue: 'Mantenha coluna neutra, tronco firme e puxe a barra em direção à região inferior do abdômen sem transformar o movimento em encolhimento.',
        referenceQuery: 'remada curvada barra livre execução correta',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Remada máquina pegada neutra unilateral',
        muscles: 'Dorsais • romboides',
        executionCue: 'Deixe o peito estável no apoio e conduza o cotovelo para trás e levemente para o quadril. Evite girar o tronco.',
        referenceQuery: 'remada máquina unilateral pegada neutra execução',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Pulldown barra na polia',
        muscles: 'Latíssimo do dorso',
        executionCue: 'Mantenha os braços quase estendidos e leve a barra para as coxas usando extensão dos ombros. Evite roubar com o tronco.',
        referenceQuery: 'pulldown barra polia execução dorsal',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Pulldown máquina',
        muscles: 'Latíssimo do dorso',
        executionCue: 'Inicie deprimindo as escápulas e conduza os cotovelos para baixo, buscando encurtar o dorsal sem perder o controle na volta.',
        referenceQuery: 'pulldown máquina dorsal execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Rosca com corda no cross',
        muscles: 'Bíceps • braquial • braquiorradial',
        executionCue: 'Fixe os cotovelos ao lado do corpo, flexione sem projetar os ombros à frente e controle totalmente a descida.',
        referenceQuery: 'rosca corda cross execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Dead hang no espaldar',
        muscles: 'Pegada • mobilidade de ombro • relaxamento axial',
        executionCue: 'Segure com firmeza, deixe o corpo suspenso e relaxe gradualmente sem soltar de forma brusca. Interrompa se houver dor no ombro.',
        referenceQuery: 'dead hang espaldar execução correta',
        prescriptions: [SetPrescription(label: 'Tempo', reps: '60–120 s')],
      ),
    ],
  ),
  WorkoutData(
    number: 2,
    title: 'Treino 2',
    focus: 'Quadríceps • posterior • panturrilha',
    description: 'Treino de pernas com amplitude, unilateral e posterior controlado.',
    exercises: [
      ExerciseData(
        name: 'Cadeira extensora unilateral',
        muscles: 'Quadríceps',
        executionCue: 'Alinhe o joelho ao eixo da máquina, estenda sem tirar o quadril do banco e controle a volta até alongar o quadríceps.',
        referenceQuery: 'cadeira extensora unilateral execução correta',
        prescriptions: [
          SetPrescription(label: 'Aquecimento', reps: '20 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Agachamento livre ou Smith',
        muscles: 'Quadríceps • glúteos • core',
        executionCue: 'Mantenha os pés firmes, joelhos acompanhando a linha dos pés e desça na maior amplitude que preserve controle e posição do tronco.',
        referenceQuery: 'agachamento livre smith amplitude execução correta',
        prescriptions: [
          SetPrescription(label: 'Aquecimento', reps: '20 reps'),
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 2),
          SetPrescription(label: 'Série pesada', reps: '4–6 reps'),
        ],
      ),
      ExerciseData(
        name: 'Afundo no Smith com step',
        muscles: 'Quadríceps • glúteos',
        executionCue: 'Mantenha o pé da frente totalmente apoiado no step, desça de forma vertical e controlada e evite perder o alinhamento do joelho.',
        referenceQuery: 'afundo smith step pé frente execução',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Leg press 45°',
        muscles: 'Quadríceps • glúteos',
        executionCue: 'Mantenha quadril e lombar apoiados, desça até onde a pelve permaneça estável e empurre mantendo joelhos alinhados aos pés.',
        referenceQuery: 'leg press 45 execução correta amplitude',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 2),
          SetPrescription(label: 'Série pesada', reps: '4–6 reps'),
        ],
      ),
      ExerciseData(
        name: 'Stiff',
        muscles: 'Posterior de coxa • glúteos',
        executionCue: 'Leve o quadril para trás com joelhos destravados, mantenha a coluna neutra e pare quando perder tensão útil no posterior.',
        referenceQuery: 'stiff execução correta posterior de coxa',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Cadeira adutora',
        muscles: 'Adutores',
        executionCue: 'Mantenha quadril encostado no banco, feche as pernas sem impulso e controle a abertura evitando perder a posição.',
        referenceQuery: 'cadeira adutora execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 4)],
      ),
      ExerciseData(
        name: 'Panturrilha sentado',
        muscles: 'Sóleo • panturrilha',
        executionCue: 'Use amplitude completa: desça o calcanhar de forma controlada, faça pausa curta no alongamento e suba sem quicar.',
        referenceQuery: 'panturrilha sentado execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '12–15 reps', sets: 3)],
      ),
    ],
  ),
  WorkoutData(
    number: 3,
    title: 'Treino 3',
    focus: 'Peito • ombros • tríceps',
    description: 'Peito completo com deltoides e finalização de tríceps.',
    exercises: [
      ExerciseData(
        name: 'Voador peitoral',
        muscles: 'Peitoral',
        executionCue: 'Mantenha o peito alto, ombros estáveis e aproxime os braços sem deixar o ombro avançar excessivamente no final.',
        referenceQuery: 'voador peitoral máquina execução correta',
        prescriptions: [
          SetPrescription(label: 'Aquecimento', reps: '20 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Supino inclinado no Smith',
        muscles: 'Peitoral superior • tríceps • deltoide anterior',
        executionCue: 'Retraia as escápulas, mantenha o peito alto e desça a barra de forma controlada até a região superior do peito.',
        referenceQuery: 'supino inclinado smith execução correta',
        prescriptions: [
          SetPrescription(label: 'Aquecimento', reps: '20 reps'),
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Supino reto no Smith',
        muscles: 'Peitoral • tríceps • deltoide anterior',
        executionCue: 'Fixe as escápulas no banco, use trajetória estável e mantenha punhos alinhados aos antebraços durante toda a repetição.',
        referenceQuery: 'supino reto smith execução correta',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Crossover polia baixa unilateral',
        muscles: 'Peitoral superior',
        executionCue: 'Com tronco estável, conduza a mão de baixo para cima e para dentro, pensando em aproximar o braço da linha média do peito.',
        referenceQuery: 'crossover polia baixa unilateral peitoral execução',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Desenvolvimento máquina articulada ou Smith',
        muscles: 'Deltoides • tríceps',
        executionCue: 'Mantenha abdômen firme e antebraços sob as mãos; empurre para cima sem perder o contato do tronco com o apoio.',
        referenceQuery: 'desenvolvimento máquina articulada smith execução',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Elevação lateral com halter sentado',
        muscles: 'Deltoide lateral',
        executionCue: 'Eleve os braços no plano da escápula, sem encolher os ombros, e controle a descida mantendo tensão no deltoide.',
        referenceQuery: 'elevação lateral halter sentado execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 4)],
      ),
      ExerciseData(
        name: 'Elevação lateral máquina em pé',
        muscles: 'Deltoide lateral',
        executionCue: 'Mantenha o tronco estável e eleve pelos cotovelos. Evite impulso do corpo e excesso de elevação dos ombros.',
        referenceQuery: 'elevação lateral máquina em pé execução',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 4)],
      ),
      ExerciseData(
        name: 'Tríceps corda no cross',
        muscles: 'Tríceps',
        executionCue: 'Prenda os cotovelos ao corpo, estenda completamente sem mover os ombros e abra levemente a corda no final.',
        referenceQuery: 'tríceps corda cross execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
    ],
  ),
  WorkoutData(
    number: 4,
    title: 'Treino 4',
    focus: 'Glúteos • posterior • panturrilha',
    description: 'Sessão orientada a glúteos, amplitude e controle de posterior.',
    exercises: [
      ExerciseData(
        name: 'Cadeira abdutora',
        muscles: 'Glúteo médio • glúteo máximo',
        executionCue: 'Mantenha a pelve firme, abra as pernas sem impulso e controle a volta. No aquecimento, não force pico de contração.',
        referenceQuery: 'cadeira abdutora execução glúteo correta',
        prescriptions: [
          SetPrescription(label: 'Aquecimento', reps: '20 reps'),
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 4),
        ],
      ),
      ExerciseData(
        name: 'Elevação pélvica',
        muscles: 'Glúteo máximo • posterior',
        executionCue: 'Mantenha costelas controladas, empurre o chão com os pés e termine a subida contraindo glúteos sem hiperestender a lombar.',
        referenceQuery: 'elevação pélvica hip thrust execução correta',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Reconhecimento pesado', reps: '2–4 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
          SetPrescription(label: 'Série pesada', reps: '4–6 reps'),
        ],
      ),
      ExerciseData(
        name: 'Búlgaro no Smith inclinado à frente',
        muscles: 'Glúteos • quadríceps',
        executionCue: 'Use passada que permita descer com controle, incline moderadamente o tronco e mantenha o pé da frente inteiro no chão.',
        referenceQuery: 'agachamento búlgaro smith glúteo execução',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Hack squat com foco em glúteos',
        muscles: 'Glúteos • quadríceps',
        executionCue: 'Priorize amplitude com controle, mantenha os pés firmes e evite reduzir o movimento apenas para usar mais carga.',
        referenceQuery: 'hack squat glúteo amplitude execução correta',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Mesa flexora',
        muscles: 'Posterior de coxa',
        executionCue: 'Mantenha o quadril apoiado, flexione os joelhos sem levantar a pelve e controle a fase de retorno.',
        referenceQuery: 'mesa flexora execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Flexora em pé unilateral',
        muscles: 'Posterior de coxa',
        executionCue: 'Estabilize o tronco e a pelve, flexione o joelho sem compensar com o quadril e controle a extensão.',
        referenceQuery: 'flexora em pé unilateral execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Panturrilha em pé',
        muscles: 'Gastrocnêmio • panturrilha',
        executionCue: 'Desça o calcanhar com controle, mantenha os joelhos estáveis e suba até a máxima flexão plantar sem quicar.',
        referenceQuery: 'panturrilha em pé execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '12–15 reps', sets: 3)],
      ),
    ],
  ),
  WorkoutData(
    number: 5,
    title: 'Treino 5',
    focus: 'Costas • peito • ombros • core',
    description: 'Treino misto de superiores com lombar e abdômen.',
    exercises: [
      ExerciseData(
        name: 'Banco romano lombar',
        muscles: 'Eretores da coluna • glúteos • posterior',
        executionCue: 'Mova pelo quadril, mantenha a coluna neutra e suba apenas até alinhar o tronco, sem hiperextender a lombar.',
        referenceQuery: 'banco romano lombar execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Puxada alta barra pegada aberta',
        muscles: 'Dorsais • redondo maior',
        executionCue: 'Inicie deprimindo as escápulas e puxe a barra em direção à parte alta do peito sem jogar o tronco para trás.',
        referenceQuery: 'puxada alta barra pegada aberta execução correta',
        prescriptions: [
          SetPrescription(label: 'Aquecimento', reps: '20 reps'),
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Puxada alta com triângulo',
        muscles: 'Dorsais • bíceps',
        executionCue: 'Mantenha o peito alto e puxe o triângulo em direção ao esterno, conduzindo os cotovelos para baixo sem balançar.',
        referenceQuery: 'puxada alta triângulo execução correta dorsal',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Crucifixo invertido na polia alta',
        muscles: 'Deltoide posterior • romboides',
        executionCue: 'Braços levemente flexionados, peito estável e movimento aberto pelo ombro. Evite encolher ou puxar com o bíceps.',
        referenceQuery: 'crucifixo invertido polia alta execução correta',
        prescriptions: [
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Supino reto máquina',
        muscles: 'Peitoral • tríceps',
        executionCue: 'Ajuste o banco para que as mãos fiquem alinhadas ao peito, mantenha escápulas estáveis e controle a volta.',
        referenceQuery: 'supino reto máquina execução correta',
        prescriptions: [
          SetPrescription(label: 'Aquecimento', reps: '20 reps'),
          SetPrescription(label: 'Reconhecimento', reps: '4–6 reps'),
          SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3),
        ],
      ),
      ExerciseData(
        name: 'Elevação frontal com corda',
        muscles: 'Deltoide anterior',
        executionCue: 'Mantenha o tronco firme, eleve a corda sem impulso e pare antes de perder o controle do ombro.',
        referenceQuery: 'elevação frontal corda polia execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Elevação lateral polia baixa',
        muscles: 'Deltoide lateral',
        executionCue: 'Comece com tensão na polia, eleve pelo cotovelo mantendo o ombro longe da orelha e controle a descida.',
        referenceQuery: 'elevação lateral polia baixa execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 3)],
      ),
      ExerciseData(
        name: 'Abdominal máquina',
        muscles: 'Reto abdominal',
        executionCue: 'Faça flexão do tronco aproximando costelas da pelve. Evite puxar somente com os braços ou flexores do quadril.',
        referenceQuery: 'abdominal máquina execução correta',
        prescriptions: [SetPrescription(label: 'Válidas', reps: '9–12 reps', sets: 4)],
      ),
    ],
  ),
];
