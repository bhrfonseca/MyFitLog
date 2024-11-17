import SwiftUI
import FirebaseFirestore

struct manageActivityView: View {
    @ObservedObject var firestoreManager = DatabaseFirestore()
    
    @State private var showConfirmationAlert = false
    @State private var activityToDelete: Activity? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(firestoreManager.activities) { activity in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Tipo: \(activity.type.rawValue)")
                                .fontWeight(.bold)
                            Spacer()
                            Text(activity.date)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 5)

                        
                        HStack {
                            Text("Duração: \(activity.duration) min")
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("Calorias: \(activity.calories) kcal")
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding(.bottom, 3)

                        
                        if activity.type == .running {
                            Text("Distância: \(activity.distance ) km")
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .swipeActions {
                        // Ação de editar
                        Button {
                            firestoreManager.updateActivity(activity: activity)
                        } label: {
                            Label("Editar", systemImage: "pencil")
                        }
                        .tint(.blue)

                        Button {
                            activityToDelete = activity
                            showConfirmationAlert = true
                        } label: {
                            Label("Excluir", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Gerenciar Atividades")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .padding(.top, 70)
                }
            }
            .onAppear {
                firestoreManager.fetchActivities()
            }
            .listStyle(PlainListStyle())
            .alert(isPresented: $showConfirmationAlert) {
                // Alerta de confirmação antes de excluir
                Alert(
                    title: Text("Confirmar Exclusão"),
                    message: Text("Tem certeza de que deseja excluir esta atividade?"),
                    primaryButton: .destructive(Text("Excluir")) {
                        if let activityToDelete = activityToDelete {
                            firestoreManager.deleteActivity(activity: activityToDelete)
                        }
                    },
                    secondaryButton: .cancel {
                        activityToDelete = nil
                    }
                )
            }
        }
    }
}

struct ManageActivityView_Previews: PreviewProvider {
    static var previews: some View {
        manageActivityView()
    }
}

