import SwiftUI

struct Tela01: View {
    @State private var username: String = "João da Silva"
    @State private var email: String = "joao.silva@email.com"
    @State private var showMenu: Bool = false // Controla a exibição do menu

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 30) {
                    HStack {
                        Button(action: {
                            showMenu.toggle() // Alterna o menu
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .foregroundColor(.purple)
                        }
                        Spacer()
                    }
                    .padding(.leading)

                    Text("Bem-vindo!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    Text("Fortaleça sua fé e encontre esperança em cada passo com Cristo.")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    HStack(spacing: 20) {
                        NavigationLink(destination: EvangelhoView()) {
                            optionCard(title: "Evangelho do Dia", color: .blue, iconName: "book")
                        }

                        NavigationLink(destination: PerguntasView()) {
                            optionCard(title: "Perguntas", color: .green, iconName: "questionmark.circle")
                        }
                    }

                    HStack(spacing: 20) {
                        NavigationLink(destination: ConfiguracaoView()) {
                            optionCard(title: "Configurações", color: .yellow, iconName: "gear")
                        }

                        NavigationLink(destination: LoginView()) {
                            optionCard(title: "Sair", color: .red, iconName: "arrow.right.square")
                        }
                    }

                    Spacer()
                }
                .padding()

                // Menu Lateral
                if showMenu {
                    MenuView(username: username, email: email, onDismiss: {
                        showMenu = false // Fecha o menu ao clicar fora
                    })
                }
            }
        }
    }
}

// Componente do Menu Lateral
struct MenuView: View {
    var username: String
    var email: String
    var onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.purple)

                VStack(alignment: .leading) {
                    Text(username)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 10)
            }
            .padding()

            Divider()

            VStack(alignment: .leading, spacing: 15) {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(.blue)
                        Text("Evangelho do Dia")
                    }
                }

                Button(action: {}) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.green)
                        Text("Perguntas")
                    }
                }

                Button(action: {}) {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(.yellow)
                        Text("Configurações")
                    }
                }

                Button(action: {}) {
                    HStack {
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(.red)
                        Text("Sair")
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

            Spacer()
        }
        .frame(maxWidth: 300)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            onDismiss()
        }
        .padding(.leading, 10)
    }
}

// Tela de Login com link para Criar Conta
struct LoginView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                TextField("E-mail", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Senha", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {}) {
                    Text("Entrar")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()

                NavigationLink(destination: CriarContaView()) {
                    Text("Criar uma conta")
                        .foregroundColor(.blue)
                        .underline()
                }

                Spacer()
            }
            .padding()
        }
    }
}

// Tela de Criar Conta
struct CriaContaView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var birthDate: Date = Date()
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Criar Conta")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Nome completo", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("E-mail", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()

                SecureField("Senha", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Confirmar senha", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                DatePicker("Data de Nascimento", selection: $birthDate, displayedComponents: .date)
                    .padding()

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }

                Button(action: createAccount) {
                    Text("Criar Conta")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
        }
    }

    private func createAccount() {
        guard !name.isEmpty else {
            errorMessage = "O nome é obrigatório."
            return
        }
        guard !email.isEmpty else {
            errorMessage = "O e-mail é obrigatório."
            return
        }
        guard password == confirmPassword else {
            errorMessage = "As senhas não coincidem."
            return
        }

        let calendar = Calendar.current
        let age = calendar.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        guard age >= 18 else {
            errorMessage = "Você deve ter pelo menos 18 anos."
            return
        }

        errorMessage = nil
        print("Conta criada com sucesso para \(name)!")
    }
}

// Outras Telas
struct EvangelhoView: View {
    var body: some View {
        VStack {
            Text("Evangelho do Dia")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

struct PerguntaView: View {
    var body: some View {
        VStack {
            Text("Perguntas")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

struct ConfiguracaoView: View {
    var body: some View {
        VStack {
            Text("Configurações")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

// Preview
struct Tela01_Previews: PreviewProvider {
    static var previews: some View {
        Tela01()
    }
}
