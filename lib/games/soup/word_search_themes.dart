class WordSearchTheme {
  final String name;
  final List<String> words;
  final String description;

  WordSearchTheme({
    required this.name,
    required this.words,
    required this.description,
  });
}

final List<WordSearchTheme> itThemes = [
  WordSearchTheme(
    name: 'Programación',
    words: ['code', 'debug', 'function', 'variable', 'algorithm', 'syntax', 'compile', 'runtime'],
    description: 'Conceptos básicos de programación',
  ),
  WordSearchTheme(
    name: 'Base de Datos',
    words: ['query', 'table', 'index', 'transaction', 'sql', 'schema', 'primarykey', 'foreignkey'],
    description: 'Términos relacionados con bases de datos',
  ),
  WordSearchTheme(
    name: 'Redes',
    words: ['router', 'server', 'protocol', 'firewall', 'bandwidth', 'latency', 'packet', 'ethernet'],
    description: 'Conceptos de redes y conectividad',
  ),
  WordSearchTheme(
    name: 'Ciberseguridad',
    words: ['virus', 'malware', 'encryption', 'firewall', 'phishing', 'password', 'authentication', 'vulnerability'],
    description: 'Términos de seguridad informática',
  ),
  WordSearchTheme(
    name: 'Desarrollo Web',
    words: ['html', 'css', 'javascript', 'framework', 'responsive', 'backend', 'frontend', 'api'],
    description: 'Tecnologías de desarrollo web',
  ),
  WordSearchTheme(
    name: 'Inteligencia Artificial',
    words: ['neural', 'machine', 'learning', 'dataset', 'training', 'model', 'algorithm', 'prediction'],
    description: 'Conceptos de IA y machine learning',
  ),
];