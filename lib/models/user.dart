class Usuario {
  // Atributos do usuário
  String nome;
  String sobrenome;
  String email;
  String senha;
  String tipoUsuario; // Pode ser 'admin', 'cliente', 'funcionario', etc.

  // Construtor
  Usuario({
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.senha,
    required this.tipoUsuario,
  });

  // Método para converter um mapa para um objeto Usuario
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'] as String,
      sobrenome: map['sobrenome'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
      tipoUsuario: map['tipoUsuario'] as String,
    );
  }

  // Método para converter um objeto Usuario para um mapa
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'senha': senha,
      'tipoUsuario': tipoUsuario,
    };
  }

  @override
  String toString() {
    return 'Usuario(nome: $nome, sobrenome: $sobrenome, email: $email, senha: [oculta], tipoUsuario: $tipoUsuario)';
  }
}
