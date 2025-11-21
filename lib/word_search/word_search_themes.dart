// Módulo de temas y palabras para la sopa de letras
class WordSearchTheme {
  final String name;
  final List<String> words;
  final String icon;

  WordSearchTheme({
    required this.name,
    required this.words,
    required this.icon,
  });
}

class WordSearchThemes {
  static List<WordSearchTheme> getThemes() {
    return [
      WordSearchTheme(
        name: 'Hardware',
        icon: '💻',
        words: [
          'COMPUTER', 'KEYBOARD', 'MOUSE', 'MONITOR', 'PRINTER',
          'SERVER', 'ROUTER', 'SWITCH', 'MOTHERBOARD', 'RAM',
          'PROCESSOR', 'HARDDISK', 'GRAPHICSCARD', 'USB', 'HDMI'
        ],
      ),
      WordSearchTheme(
        name: 'Software',
        icon: '📱',
        words: [
          'OPERATINGSYSTEM', 'APPLICATION', 'DATABASE', 'ALGORITHM',
          'FIREWALL', 'BROWSER', 'COMPILER', 'KERNEL', 'INTERFACE',
          'PLATFORM', 'FIRMWARE', 'DRIVER', 'UTILITY', 'PATCH', 'UPDATE'
        ],
      ),
      WordSearchTheme(
        name: 'Programming',
        icon: '💻',
        words: [
          'VARIABLE', 'FUNCTION', 'LOOP', 'DEBUG', 'SYNTAX',
          'FRAMEWORK', 'API', 'REPOSITORY', 'GIT', 'JAVASCRIPT',
          'PYTHON', 'JAVA', 'HTML', 'CSS', 'DATABASE'
        ],
      ),
      WordSearchTheme(
        name: 'Networking',
        icon: '🌐',
        words: [
          'IPADDRESS', 'BANDWIDTH', 'ETHERNET', 'VPN', 'PROTOCOL',
          'LATENCY', 'LAN', 'WAN', 'DNS', 'DHCP', 'SSH', 'FTP',
          'TCPIP', 'SUBNET', 'GATEWAY', 'ROUTER', 'SWITCH'
        ],
      ),
      WordSearchTheme(
        name: 'Cybersecurity',
        icon: '🔒',
        words: [
          'ENCRYPTION', 'MALWARE', 'PHISHING', 'AUTHENTICATION',
          'VULNERABILITY', 'BACKUP', 'FIREWALL', 'PENETRATION',
          'ANTIVIRUS', 'PASSWORD', 'SECURITY', 'HACKER', 'BREACH',
          'FIREWALL', 'ENCRYPT', 'DECRYPT', 'BIOMETRICS'
        ],
      ),
      WordSearchTheme(
        name: 'Cloud Computing',
        icon: '☁️',
        words: [
          'CLOUD', 'STORAGE', 'VIRTUALMACHINE', 'SAAS', 'SCALABILITY',
          'API', 'DEPLOYMENT', 'IAAS', 'PAAS', 'SERVERLESS',
          'CONTAINER', 'MICROSERVICES', 'AWS', 'AZURE', 'GOOGLECLOUD'
        ],
      ),
    ];
  }

  // Función para obtener palabras ajustadas al tamaño del grid
  static List<String> getWordsForGrid(WordSearchTheme theme, int gridSize) {
    List<String> filteredWords = [];
    
    for (String word in theme.words) {
      if (word.length <= gridSize) {
        filteredWords.add(word);
      }
    }
    
    // Si no hay suficientes palabras, agregar algunas cortas
    if (filteredWords.length < 8) {
      List<String> shortWords = ['CPU', 'RAM', 'USB', 'LAN', 'WAN', 'DNS', 'API', 'IP'];
      for (String word in shortWords) {
        if (!filteredWords.contains(word) && word.length <= gridSize) {
          filteredWords.add(word);
        }
      }
    }
    
    return filteredWords.take(10).toList(); // Máximo 10 palabras
  }
}