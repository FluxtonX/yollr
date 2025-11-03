class PoolQuestion {
  final String emoji;
  final String text;
  final List<String> answers;
  final String progress;

  PoolQuestion({
    required this.emoji,
    required this.text,
    required List<String> answers,
    required this.progress,
  }) : answers = List<String>.from(answers);
}
