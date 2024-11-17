import SwiftUI

struct createActivityView: View {
    
    @StateObject var activity = Activity()
    @EnvironmentObject var databaseFirestore: DatabaseFirestore
    
    @State private var resetFieldsFlag = false
    @State private var isSaved = false
    
    var body: some View {
        
        VStack {
            Text("Cadastrar Atividade")
                .font(.largeTitle)
                .bold()
                .padding()
            
            // Seletor de tipo de atividade
            Picker("Tipo de Atividade", selection: $activity.type) {
                ForEach(ActivityType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: activity.type) { _ in resetFieldsFlag.toggle() }
            
            VStack(spacing: -12) {
              
                TextField("Data (dd/MM/yyyy)", text: $activity.date)
                    .keyboardType(.numbersAndPunctuation)
                    .onChange(of: activity.date) { newValue in
                        // Aplica a máscara de data sempre que o valor for alterado
                        activity.date = DataFormatter.formatDate(newValue)
                    }
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

               
                TextField("Duração (minutos)", text: $activity.duration)
                    .keyboardType(.numberPad)
                    .onChange(of: activity.duration) { newValue in
                        activity.duration = DataFormatter.formatDuration(newValue)
                    }
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if activity.type == .running {
                    TextField("Distância (km)", text: Binding(
                        get: { activity.distance },
                        set: { activity.distance = DataFormatter.formatDistance($0) }
                    ))
                    .keyboardType(.decimalPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                TextField("Calorias", text: $activity.calories)
                    .keyboardType(.numberPad)
                    .onChange(of: activity.calories) { newValue in
                        activity.calories = DataFormatter.formatCalories(newValue)
                    }
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Button(action: {
                databaseFirestore.saveActivity(activity: activity) { success in
                    if success {
                        // Exibir mensagem de sucesso
                        isSaved = true
                        // Limpar os campos
                        resetFields()
                    }
                }

            }) {
                Text("Salvar Atividade")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .onChange(of: resetFieldsFlag) { _ in
            resetFields()
        }
        .alert(isPresented: $isSaved) {
            Alert(
                title: Text("Sucesso"),
                message: Text("Atividade salva com sucesso!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    // Função para resetar os campos
    func resetFields() {
        activity.duration = ""
        activity.distance = ""
        activity.calories = ""
        activity.date = ""
    }
}

struct createActivityView_Previews: PreviewProvider {
    static var previews: some View {
        createActivityView().environmentObject(DatabaseFirestore())  
    }
}
