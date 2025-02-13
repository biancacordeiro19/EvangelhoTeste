import SwiftUI

struct CriarConta: View {
    // Variáveis para armazenar os dados do formulário
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

                // Campo para nome
                TextField("Nome completo", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                // Campo para e-mail
                TextField("E-mail", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                // Campo para data de nascimento
                DatePicker("Data de Nascimento", selection: $birthDate, displayedComponents: .date)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                // Campo para senha
                SecureField("Senha", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                // Campo para confirmação de senha
                SecureField("Confirmar senha", text: $confirmPassword)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                // Mostrar mensagem de erro, se houver
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }

                // Botão para criar conta
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
            .navigationBarTitle("Cadastro", displayMode: .inline)
        }
    }

    // Função para validar e criar a conta
    private func createAccount() {
        // Validar campos
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

        // Validar idade (exemplo: maior de 18 anos)
        let calendar = Calendar.current
        let age = calendar.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        guard age >= 18 else {
            errorMessage = "Você deve ter pelo menos 18 anos para criar uma conta."
            return
        }

        // Processar criação da conta
        errorMessage = nil
        print("Conta criada com sucesso para \(name)!")
        print("Data de Nascimento: \(birthDate)")
        // Aqui você pode adicionar lógica para enviar os dados para um servidor ou banco de dados
    }
}

struct ontentView_Previews: PreviewProvider {
    static var previews: some View {
        CriarConta()
    }
}
