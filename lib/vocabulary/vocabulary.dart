import 'package:flutter/material.dart';

class ITVocabulary extends StatefulWidget {
  const ITVocabulary({super.key});

  @override
  State<ITVocabulary> createState() => _ITVocabularyState();
}

class _ITVocabularyState extends State<ITVocabulary> {
  int _currentCategory = 0;
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showSearchResults = false;
  List<Map<String, dynamic>> _searchResults = [];

  // Categorías de vocabulario de TI expandidas
  final List<Map<String, dynamic>> vocabularyCategories = [
    {
      'title': 'Hardware',
      'color': Colors.blue,
      'icon': Icons.computer,
      'words': [
        {
          'word': 'Computer',
          'translation': 'Computadora',
          'definition': 'Dispositivo electrónico que procesa datos',
          'example': 'I use my computer for work and games.',
          'pronunciation': '/kəmˈpjuːtər/',
          'image': '💻'
        },
        {
          'word': 'Keyboard',
          'translation': 'Teclado',
          'definition': 'Dispositivo de entrada con teclas para escribir',
          'example': 'The keyboard has 104 keys.',
          'pronunciation': '/ˈkiːbɔːrd/',
          'image': '⌨️'
        },
        {
          'word': 'Mouse',
          'translation': 'Ratón',
          'definition': 'Dispositivo de entrada para controlar el cursor',
          'example': 'I need a new mouse for my computer.',
          'pronunciation': '/maʊs/',
          'image': '🖱️'
        },
        {
          'word': 'Monitor',
          'translation': 'Monitor',
          'definition': 'Pantalla que muestra la información de la computadora',
          'example': 'My monitor is 24 inches.',
          'pronunciation': '/ˈmɒnɪtə/',
          'image': '🖥️'
        },
        {
          'word': 'Printer',
          'translation': 'Impresora',
          'definition': 'Dispositivo que produce copias en papel de documentos digitales',
          'example': 'The printer is out of ink.',
          'pronunciation': '/ˈprɪntər/',
          'image': '🖨️'
        },
        {
          'word': 'Server',
          'translation': 'Servidor',
          'definition': 'Computadora que proporciona servicios a otras computadoras',
          'example': 'The company has a powerful server.',
          'pronunciation': '/ˈsɜːrvər/',
          'image': '🖧'
        },
        {
          'word': 'Router',
          'translation': 'Enrutador',
          'definition': 'Dispositivo que dirige el tráfico entre redes',
          'example': 'The router provides Wi-Fi to the whole house.',
          'pronunciation': '/ˈruːtər/',
          'image': '📡'
        },
        {
          'word': 'Switch',
          'translation': 'Conmutador',
          'definition': 'Dispositivo que conecta dispositivos en una red local',
          'example': 'The network switch has 24 ports.',
          'pronunciation': '/swɪtʃ/',
          'image': '🔀'
        },
        {
          'word': 'Motherboard',
          'translation': 'Placa base',
          'definition': 'Placa de circuito principal de una computadora',
          'example': 'The motherboard connects all components.',
          'pronunciation': '/ˈmʌðəbɔːrd/',
          'image': '🔌'
        },
        {
          'word': 'RAM',
          'translation': 'Memoria RAM',
          'definition': 'Memoria de acceso aleatorio para datos temporales',
          'example': 'My computer has 16GB of RAM.',
          'pronunciation': '/ræm/',
          'image': '🧠'
        },
      ]
    },
    {
      'title': 'Software',
      'color': Colors.green,
      'icon': Icons.apps,
      'words': [
        {
          'word': 'Operating System',
          'translation': 'Sistema Operativo',
          'definition': 'Software que gestiona el hardware y otros software',
          'example': 'Windows and macOS are operating systems.',
          'pronunciation': '/ˈɒpəreɪtɪŋ ˈsɪstəm/',
          'image': '⚙️'
        },
        {
          'word': 'Application',
          'translation': 'Aplicación',
          'definition': 'Programa diseñado para una tarea específica',
          'example': 'I use a photo editing application.',
          'pronunciation': '/ˌæplɪˈkeɪʃən/',
          'image': '📱'
        },
        {
          'word': 'Database',
          'translation': 'Base de Datos',
          'definition': 'Colección organizada de datos',
          'example': 'The company has a large customer database.',
          'pronunciation': '/ˈdeɪtəbeɪs/',
          'image': '🗄️'
        },
        {
          'word': 'Algorithm',
          'translation': 'Algoritmo',
          'definition': 'Conjunto de pasos para resolver un problema',
          'example': 'The search algorithm is very efficient.',
          'pronunciation': '/ˈælɡərɪðəm/',
          'image': '🔢'
        },
        {
          'word': 'Firewall',
          'translation': 'Cortafuegos',
          'definition': 'Sistema de seguridad que controla el tráfico de red',
          'example': 'The firewall blocks suspicious connections.',
          'pronunciation': '/ˈfaɪəwɔːl/',
          'image': '🛡️'
        },
        {
          'word': 'Browser',
          'translation': 'Navegador',
          'definition': 'Software para acceder a la World Wide Web',
          'example': 'Chrome is my favorite web browser.',
          'pronunciation': '/ˈbraʊzər/',
          'image': '🌐'
        },
        {
          'word': 'Compiler',
          'translation': 'Compilador',
          'definition': 'Programa que traduce código fuente a código máquina',
          'example': 'The C++ compiler found syntax errors.',
          'pronunciation': '/kəmˈpaɪlər/',
          'image': '⚡'
        },
        {
          'word': 'Kernel',
          'translation': 'Kernel',
          'definition': 'Núcleo del sistema operativo que gestiona recursos',
          'example': 'The Linux kernel is open source.',
          'pronunciation': '/ˈkɜːrnl/',
          'image': '🎯'
        },
      ]
    },
    {
      'title': 'Programming',
      'color': Colors.purple,
      'icon': Icons.code,
      'words': [
        {
          'word': 'Variable',
          'translation': 'Variable',
          'definition': 'Contenedor para almacenar datos en programación',
          'example': 'Create a variable to store the user name.',
          'pronunciation': '/ˈveəriəbl/',
          'image': '📦'
        },
        {
          'word': 'Function',
          'translation': 'Función',
          'definition': 'Bloque de código que realiza una tarea específica',
          'example': 'This function calculates the total price.',
          'pronunciation': '/ˈfʌŋkʃən/',
          'image': '🔧'
        },
        {
          'word': 'Loop',
          'translation': 'Bucle',
          'definition': 'Estructura que repite código múltiples veces',
          'example': 'Use a loop to process all items in the list.',
          'pronunciation': '/luːp/',
          'image': '🔄'
        },
        {
          'word': 'Debug',
          'translation': 'Depurar',
          'definition': 'Proceso de encontrar y corregir errores en el código',
          'example': 'I need to debug this program before deployment.',
          'pronunciation': '/ˌdiːˈbʌɡ/',
          'image': '🐛'
        },
        {
          'word': 'Syntax',
          'translation': 'Sintaxis',
          'definition': 'Reglas que definen la estructura del código',
          'example': 'Python has clean and readable syntax.',
          'pronunciation': '/ˈsɪntæks/',
          'image': '📝'
        },
        {
          'word': 'Framework',
          'translation': 'Framework',
          'definition': 'Estructura para desarrollar aplicaciones de software',
          'example': 'We use React framework for web development.',
          'pronunciation': '/ˈfreɪmwɜːrk/',
          'image': '🏗️'
        },
        {
          'word': 'API',
          'translation': 'API',
          'definition': 'Interfaz de programación de aplicaciones',
          'example': 'The weather app uses a third-party API.',
          'pronunciation': '/eɪ piː aɪ/',
          'image': '🔗'
        },
        {
          'word': 'Repository',
          'translation': 'Repositorio',
          'definition': 'Almacenamiento para código y archivos de proyecto',
          'example': 'The code is stored in a Git repository.',
          'pronunciation': '/rɪˈpɒzɪtəri/',
          'image': '📚'
        },
      ]
    },
    {
      'title': 'Networking',
      'color': Colors.orange,
      'icon': Icons.wifi,
      'words': [
        {
          'word': 'IP Address',
          'translation': 'Dirección IP',
          'definition': 'Identificador único para un dispositivo en una red',
          'example': 'Each device has a unique IP address.',
          'pronunciation': '/aɪ ˈpiː əˈdres/',
          'image': '📍'
        },
        {
          'word': 'Bandwidth',
          'translation': 'Ancho de Banda',
          'definition': 'Cantidad de datos que se pueden transmitir en una red',
          'example': 'Streaming video requires high bandwidth.',
          'pronunciation': '/ˈbændwɪdθ/',
          'image': '📊'
        },
        {
          'word': 'Ethernet',
          'translation': 'Ethernet',
          'definition': 'Tecnología para redes de área local cableadas',
          'example': 'I connect my computer via Ethernet for faster speed.',
          'pronunciation': '/ˈiːθərnɛt/',
          'image': '🔌'
        },
        {
          'word': 'VPN',
          'translation': 'VPN (Red Privada Virtual)',
          'definition': 'Conexión segura y encriptada a través de Internet',
          'example': 'I use a VPN to access work files from home.',
          'pronunciation': '/viː piː ɛn/',
          'image': '🔒'
        },
        {
          'word': 'Protocol',
          'translation': 'Protocolo',
          'definition': 'Conjunto de reglas para la comunicación en red',
          'example': 'HTTP is a protocol for web communication.',
          'pronunciation': '/ˈprəʊtəkɒl/',
          'image': '📋'
        },
        {
          'word': 'Latency',
          'translation': 'Latencia',
          'definition': 'Tiempo que toma para los datos viajar en una red',
          'example': 'Online gaming requires low latency.',
          'pronunciation': '/ˈleɪtənsi/',
          'image': '⏱️'
        },
        {
          'word': 'LAN',
          'translation': 'LAN (Red de Área Local)',
          'definition': 'Red que conecta dispositivos en un área geográfica pequeña',
          'example': 'The office has a LAN for internal communication.',
          'pronunciation': '/læn/',
          'image': '🏢'
        },
        {
          'word': 'WAN',
          'translation': 'WAN (Red de Área Amplia)',
          'definition': 'Red que cubre un área geográfica extensa',
          'example': 'The company uses WAN to connect different branches.',
          'pronunciation': '/wæn/',
          'image': '🌍'
        },
        {
          'word': 'DNS',
          'translation': 'DNS (Sistema de Nombres de Dominio)',
          'definition': 'Sistema que traduce nombres de dominio a direcciones IP',
          'example': 'DNS resolves google.com to its IP address.',
          'pronunciation': '/diː en es/',
          'image': '🔤'
        },
        {
          'word': 'DHCP',
          'translation': 'DHCP (Protocolo de Configuración Dinámica de Host)',
          'definition': 'Protocolo que asigna automáticamente direcciones IP',
          'example': 'DHCP automatically assigns IP addresses to devices.',
          'pronunciation': '/diː eɪtʃ siː piː/',
          'image': '🎯'
        },
        {
          'word': 'SSH',
          'translation': 'SSH (Secure Shell)',
          'definition': 'Protocolo para acceso remoto seguro a sistemas',
          'example': 'I use SSH to connect to the Linux server.',
          'pronunciation': '/es es eɪtʃ/',
          'image': '🖥️'
        },
        {
          'word': 'FTP',
          'translation': 'FTP (Protocolo de Transferencia de Archivos)',
          'definition': 'Protocolo para transferir archivos entre sistemas',
          'example': 'We use FTP to upload files to the web server.',
          'pronunciation': '/ef tiː piː/',
          'image': '📁'
        },
        {
          'word': 'TCP/IP',
          'translation': 'TCP/IP',
          'definition': 'Conjunto de protocolos para comunicación en Internet',
          'example': 'TCP/IP ensures reliable data transmission.',
          'pronunciation': '/tiː siː piː aɪ piː/',
          'image': '🌐'
        },
        {
          'word': 'Subnet',
          'translation': 'Subred',
          'definition': 'División lógica de una red IP',
          'example': 'We created a subnet for the development team.',
          'pronunciation': '/ˈsʌbnɛt/',
          'image': '🔀'
        },
        {
          'word': 'Gateway',
          'translation': 'Puerta de Enlace',
          'definition': 'Dispositivo que conecta redes diferentes',
          'example': 'The gateway routes traffic between networks.',
          'pronunciation': '/ˈɡeɪtweɪ/',
          'image': '🚪'
        },
      ]
    },
    {
      'title': 'Cybersecurity',
      'color': Colors.red,
      'icon': Icons.security,
      'words': [
        {
          'word': 'Encryption',
          'translation': 'Encriptación',
          'definition': 'Proceso de convertir datos en código secreto',
          'example': 'Use encryption to protect sensitive files.',
          'pronunciation': '/ɪnˈkrɪpʃən/',
          'image': '🔐'
        },
        {
          'word': 'Malware',
          'translation': 'Malware',
          'definition': 'Software diseñado para dañar computadoras',
          'example': 'Install antivirus to protect against malware.',
          'pronunciation': '/ˈmælweər/',
          'image': '🦠'
        },
        {
          'word': 'Phishing',
          'translation': 'Phishing',
          'definition': 'Ataque para robar información personal',
          'example': 'Be careful of phishing emails asking for passwords.',
          'pronunciation': '/ˈfɪʃɪŋ/',
          'image': '🎣'
        },
        {
          'word': 'Authentication',
          'translation': 'Autenticación',
          'definition': 'Proceso de verificar la identidad de un usuario',
          'example': 'Two-factor authentication adds extra security.',
          'pronunciation': '/ɔːˌθentɪˈkeɪʃən/',
          'image': '🆔'
        },
        {
          'word': 'Vulnerability',
          'translation': 'Vulnerabilidad',
          'definition': 'Debilidad en un sistema que puede ser explotada',
          'example': 'Update software to fix security vulnerabilities.',
          'pronunciation': '/ˌvʌlnərəˈbɪləti/',
          'image': '🎯'
        },
        {
          'word': 'Backup',
          'translation': 'Copia de Seguridad',
          'definition': 'Copia de datos para recuperación en caso de pérdida',
          'example': 'Always keep a backup of important files.',
          'pronunciation': '/ˈbækʌp/',
          'image': '💾'
        },
        {
          'word': 'Firewall',
          'translation': 'Cortafuegos',
          'definition': 'Sistema que controla el tráfico de red',
          'example': 'The firewall blocks unauthorized access.',
          'pronunciation': '/ˈfaɪəwɔːl/',
          'image': '🔥'
        },
        {
          'word': 'Penetration Testing',
          'translation': 'Pruebas de Penetración',
          'definition': 'Evaluación de seguridad simulando ataques',
          'example': 'We conduct penetration testing annually.',
          'pronunciation': '/ˌpɛnɪˈtreɪʃən ˈtɛstɪŋ/',
          'image': '🔍'
        },
      ]
    },
    {
      'title': 'Cloud Computing',
      'color': Colors.teal,
      'icon': Icons.cloud,
      'words': [
        {
          'word': 'Cloud Storage',
          'translation': 'Almacenamiento en la Nube',
          'definition': 'Servicio de almacenamiento de datos en Internet',
          'example': 'I save my photos in cloud storage.',
          'pronunciation': '/klaʊd ˈstɔːrɪdʒ/',
          'image': '☁️'
        },
        {
          'word': 'Virtual Machine',
          'translation': 'Máquina Virtual',
          'definition': 'Software que emula un sistema computacional',
          'example': 'Run different operating systems using virtual machines.',
          'pronunciation': '/ˈvɜːtʃuəl məˈʃiːn/',
          'image': '🖥️'
        },
        {
          'word': 'SaaS',
          'translation': 'Software como Servicio',
          'definition': 'Modelo de distribución de software a través de Internet',
          'example': 'Google Workspace is a SaaS product.',
          'pronunciation': '/sæs/',
          'image': '🔄'
        },
        {
          'word': 'Scalability',
          'translation': 'Escalabilidad',
          'definition': 'Capacidad de un sistema para manejar crecimiento',
          'example': 'Cloud services offer excellent scalability.',
          'pronunciation': '/ˌskeɪləˈbɪləti/',
          'image': '📈'
        },
        {
          'word': 'API',
          'translation': 'API (Interfaz de Programación)',
          'definition': 'Conjunto de reglas para comunicación entre software',
          'example': 'The app uses weather API to get forecast data.',
          'pronunciation': '/eɪ piː aɪ/',
          'image': '🔗'
        },
        {
          'word': 'Deployment',
          'translation': 'Despliegue',
          'definition': 'Proceso de hacer disponible una aplicación',
          'example': 'The deployment to production server was successful.',
          'pronunciation': '/dɪˈplɔɪmənt/',
          'image': '🚀'
        },
        {
          'word': 'IaaS',
          'translation': 'Infraestructura como Servicio',
          'definition': 'Servicio de infraestructura informática en la nube',
          'example': 'AWS EC2 is an IaaS offering.',
          'pronunciation': '/aɪ æs/',
          'image': '🏗️'
        },
        {
          'word': 'PaaS',
          'translation': 'Plataforma como Servicio',
          'definition': 'Plataforma para desarrollar y ejecutar aplicaciones',
          'example': 'Heroku is a popular PaaS provider.',
          'pronunciation': '/pæs/',
          'image': '🛠️'
        },
      ]
    },
    {
      'title': 'Web Development',
      'color': Colors.amber,
      'icon': Icons.language,
      'words': [
        {
          'word': 'HTML',
          'translation': 'HTML',
          'definition': 'Lenguaje de marcado para crear páginas web',
          'example': 'HTML defines the structure of web pages.',
          'pronunciation': '/eɪtʃ tiː em el/',
          'image': '📄'
        },
        {
          'word': 'CSS',
          'translation': 'CSS',
          'definition': 'Lenguaje para diseñar y dar estilo a páginas web',
          'example': 'CSS makes websites look beautiful.',
          'pronunciation': '/siː es es/',
          'image': '🎨'
        },
        {
          'word': 'JavaScript',
          'translation': 'JavaScript',
          'definition': 'Lenguaje de programación para web interactiva',
          'example': 'JavaScript adds interactivity to websites.',
          'pronunciation': '/ˈdʒɑːvəskrɪpt/',
          'image': '⚡'
        },
        {
          'word': 'Responsive Design',
          'translation': 'Diseño Responsivo',
          'definition': 'Diseño que se adapta a diferentes tamaños de pantalla',
          'example': 'Responsive design works on mobile and desktop.',
          'pronunciation': '/rɪˈspɒnsɪv dɪˈzaɪn/',
          'image': '📱'
        },
        {
          'word': 'Frontend',
          'translation': 'Frontend',
          'definition': 'Parte cliente de una aplicación web',
          'example': 'Frontend developers work with HTML, CSS, and JavaScript.',
          'pronunciation': '/ˈfrʌntend/',
          'image': '🎭'
        },
        {
          'word': 'Backend',
          'translation': 'Backend',
          'definition': 'Parte servidor de una aplicación web',
          'example': 'Backend developers work with databases and servers.',
          'pronunciation': '/ˈbækend/',
          'image': '⚙️'
        },
        {
          'word': 'Database',
          'translation': 'Base de Datos',
          'definition': 'Sistema para almacenar y organizar datos',
          'example': 'MySQL is a popular database system.',
          'pronunciation': '/ˈdeɪtəbeɪs/',
          'image': '🗃️'
        },
        {
          'word': 'API',
          'translation': 'API',
          'definition': 'Interfaz para comunicación entre aplicaciones',
          'example': 'The app fetches data from a weather API.',
          'pronunciation': '/eɪ piː aɪ/',
          'image': '🔌'
        },
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _showSearchResults = _searchQuery.isNotEmpty;
      
      if (_showSearchResults) {
        _searchResults = _performSearch(_searchQuery);
      }
    });
  }

  List<Map<String, dynamic>> _performSearch(String query) {
    final results = <Map<String, dynamic>>[];
    
    for (final category in vocabularyCategories) {
      for (final word in category['words']) {
        if (word['word'].toLowerCase().contains(query) ||
            word['translation'].toLowerCase().contains(query) ||
            word['definition'].toLowerCase().contains(query) ||
            word['example'].toLowerCase().contains(query)) {
          results.add({
            ...word,
            'category': category['title'],
            'categoryColor': category['color'],
            'categoryIcon': category['icon'],
          });
        }
      }
    }
    
    return results;
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _showSearchResults = false;
      _searchResults.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IT Vocabulary'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade600],
            ),
          ),
        ),
        elevation: 0,
        actions: [
          if (_showSearchResults)
            IconButton(
              onPressed: _clearSearch,
              icon: const Icon(Icons.clear),
              tooltip: 'Clear search',
            ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          _buildSearchBar(),
          // Selector de categorías (solo mostrar cuando no hay búsqueda)
          if (!_showSearchResults) _buildCategorySelector(),
          // Contenido - resultados de búsqueda o vocabulario normal
          Expanded(
            child: _showSearchResults 
                ? _buildSearchResults() 
                : _buildVocabularyContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search IT terms...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearSearch,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.deepPurple.shade50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vocabularyCategories.length,
        itemBuilder: (context, index) {
          final category = vocabularyCategories[index];
          final isSelected = index == _currentCategory;
          
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? category['color'] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: category['color'],
                  width: 2,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: category['color'].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category['icon'],
                    color: isSelected ? Colors.white : category['color'],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category['title'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : category['color'],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVocabularyContent() {
    return PageView.builder(
      controller: _pageController,
      itemCount: vocabularyCategories.length,
      onPageChanged: (index) {
        setState(() {
          _currentCategory = index;
        });
      },
      itemBuilder: (context, index) {
        return _buildVocabularyPage(vocabularyCategories[index]);
      },
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No results found for "$_searchQuery"',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try different keywords',
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Found ${_searchResults.length} results for "$_searchQuery"',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return _buildSearchResultCard(_searchResults[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultCard(Map<String, dynamic> word) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categoría badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: word['categoryColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: word['categoryColor']),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(word['categoryIcon'], size: 14, color: word['categoryColor']),
                      const SizedBox(width: 4),
                      Text(
                        word['category'],
                        style: TextStyle(
                          fontSize: 12,
                          color: word['categoryColor'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: word['categoryColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    word['image'],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            child: Text(
                              word['word'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            word['pronunciation'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        word['translation'],
                        style: TextStyle(
                          fontSize: 16,
                          color: word['categoryColor'],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Definición:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    word['definition'],
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: word['categoryColor'].withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: word['categoryColor'].withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, size: 16, color: word['categoryColor']),
                      const SizedBox(width: 4),
                      Text(
                        'Ejemplo:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: word['categoryColor'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    word['example'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
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

  Widget _buildVocabularyPage(Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: category['color'].withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(category['icon'], color: category['color'], size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category['title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: category['color'],
                          ),
                        ),
                        Text(
                          '${category['words'].length} palabras',
                          style: TextStyle(
                            color: category['color'].withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: category['words'].length,
              itemBuilder: (context, index) {
                return _buildWordCard(category['words'][index], category['color']);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordCard(Map<String, dynamic> word, Color categoryColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    word['image'],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            child: Text(
                              word['word'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            word['pronunciation'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        word['translation'],
                        style: TextStyle(
                          fontSize: 16,
                          color: categoryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Definición:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    word['definition'],
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: categoryColor.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, size: 16, color: categoryColor),
                      const SizedBox(width: 4),
                      Text(
                        'Ejemplo:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: categoryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    word['example'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
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
}