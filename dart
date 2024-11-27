import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athena App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(), // Página Home
        '/register': (context) => RegisterPage(),
        '/choose_themes': (context) => ChooseInterestsPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

// Página de Splash
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/login');
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade200, Colors.purple.shade700],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/logo.png',
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}

// Página de Login
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.purple.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  height: 180,
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(_emailController, 'Email'),
                      SizedBox(height: 16),
                      _buildTextField(_passwordController, 'Senha',
                          obscureText: true),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Entrar',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Não tem uma conta? Cadastre-se.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira $hintText';
        }
        return null;
      },
    );
  }
}

// Página de Cadastro
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, '/choose_themes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_nameController, 'Nome completo'),
              SizedBox(height: 16),
              _buildTextField(_emailController, 'Email'),
              SizedBox(height: 16),
              _buildTextField(_birthdateController, 'Data de Nascimento'),
              SizedBox(height: 16),
              _buildTextField(_phoneController, 'Telefone'),
              SizedBox(height: 16),
              _buildTextField(_passwordController, 'Senha', obscureText: true),
              SizedBox(height: 16),
              _buildTextField(_confirmPasswordController, 'Confirmar Senha',
                  obscureText: true),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _register,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira $hintText';
        }
        if (hintText == 'Confirmar Senha' &&
            value != _passwordController.text) {
          return 'As senhas não coincidem';
        }
        return null;
      },
    );
  }
}

// Página de escolha de interesses
class ChooseInterestsPage extends StatefulWidget {
  @override
  _ChooseInterestsPageState createState() => _ChooseInterestsPageState();
}

class _ChooseInterestsPageState extends State<ChooseInterestsPage> {
  final List<String> interests = [
    'Esportes',
    'Cinema',
    'Música',
    'Viagens',
    'Gastronomia',
    'Leitura',
    'Animais',
    'Arte',
    'Tecnologia',
    'Jogos',
    'Moda',
    'Dança',
    'Natureza',
    'História',
    'Fotografia',
    'Bem-estar',
    'Yoga',
    'Ciclismo',
    'Escrita',
    'Café',
    'Pintura',
    'Voluntariado',
    'Festas',
    'Astrologia',
    'Caridade',
    'Séries',
    'Culinária',
    'Academia',
    'Podcast',
    'Meditação'
  ];

  final List<String> selectedInterests = [];

  void toggleSelection(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else if (selectedInterests.length < 5) {
        selectedInterests.add(interest);
      }
    });
  }

  void _submit() {
    if (selectedInterests.isNotEmpty) {
      Navigator.pushNamed(context, '/profile');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Por favor, selecione pelo menos um interesse!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha seus interesses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Escolha até 5 interesses', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: List.generate(
                interests.length,
                (index) => ChoiceChip(
                  label: Text(interests[index]),
                  selected: selectedInterests.contains(interests[index]),
                  onSelected: (selected) => toggleSelection(interests[index]),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}

// Página de perfil
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _selectedAvatar;
  final List<String> _avatars = [
    'assets/avatar1.png',
    'assets/avatar2.png',
    'assets/avatar3.png',
    'assets/avatar4.png',
  ];

  bool _hasChildren = false; // Para a resposta da pergunta sobre filhos
  List<bool> _childrenSelection = [true, false]; // "Sim" e "Não" padrão

  void _chooseAvatar(String avatar) {
    setState(() {
      _selectedAvatar = avatar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.purple.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                _selectedAvatar != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(_selectedAvatar!),
                      )
                    : CircleAvatar(
                        radius: 60,
                        child: Icon(Icons.add_a_photo, size: 30),
                      ),
                SizedBox(height: 20),
                Text(
                  'Escolha seu avatar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 16.0,
                  children: _avatars.map((avatar) {
                    return GestureDetector(
                      onTap: () => _chooseAvatar(avatar),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(avatar),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                _buildTextField('Fale sobre você'),
                SizedBox(height: 16),
                _buildTextField('Ocupação'),
                SizedBox(height: 16),
                _buildTextField('Idade'),
                SizedBox(height: 16),
                _buildTextField('Signo'),
                SizedBox(height: 16),
                Text(
                  'Tem filhos?',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 10),
                ToggleButtons(
                  isSelected: _childrenSelection,
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < _childrenSelection.length; i++) {
                        _childrenSelection[i] = i == index;
                      }
                      _hasChildren = index == 0;
                    });
                  },
                  fillColor: Colors.purple.shade700,
                  selectedColor: Colors.white,
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(30),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Sim'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Não'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Salvar e Continuar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, String>> forums = [
    {
      'title': 'Tecnologia',
      'description': 'Discussões sobre o mundo tech, IA e programação.',
      'image': 'assets/tech.jpg',
    },
    {
      'title': 'Viagens',
      'description': 'Compartilhe destinos incríveis e dicas de viagem.',
      'image': 'assets/viagens.jpg',
    },
    {
      'title': 'Culinária',
      'description': 'Receitas e truques para quem ama cozinhar.',
      'image': 'assets/culinaria.jpg',
    },
    {
      'title': 'Fitness',
      'description': 'Dicas de saúde, bem-estar e exercícios.',
      'image': 'assets/fitness.jpg',
    },
    {
      'title': 'Entretenimento',
      'description': 'Filmes, séries e tudo sobre cultura pop.',
      'image': 'assets/entretenimento.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'FÓRUNS DE INTERESSE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.purple.shade700,
        elevation: 0, // Remove a sombra para um visual mais limpo
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.purple.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: forums.length,
          itemBuilder: (context, index) {
            final forum = forums[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForumDetailPage(
                      title: forum['title']!,
                      description: forum['description']!,
                    ),
                  ),
                );
              },
              child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.asset(
                        forum['image']!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forum['title']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            forum['description']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ForumDetailPage extends StatelessWidget {
  final String title;
  final String description;

  const ForumDetailPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.purple.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            Text(
              'Aqui você pode participar de discussões, criar tópicos e interagir com outros usuários.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
