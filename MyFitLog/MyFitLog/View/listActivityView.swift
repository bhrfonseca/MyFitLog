import SwiftUI

struct listActivityView: View {
    
    @ObservedObject var firestoreManager = DatabaseFirestore()

    var body: some View {
        VStack {
            if firestoreManager.activities.isEmpty {
                Text("Nenhuma atividade registrada.")
                    .foregroundColor(.gray)
                    .font(.title2)
                    .padding(.top, 50)
            } else {
                List(firestoreManager.activities, id: \.id) { activity in
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Tipo: \(activity.type.rawValue)")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.blue)
                            Spacer()
                            Text("Data: \(activity.date)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("Duração: \(activity.duration) min")
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("Calorias: \(activity.calories) kcal")
                                .font(.body)
                                .foregroundColor(.primary)
                        }

                        if activity.type == .running {
                            Text("Distância: \(activity.distance) km")
                                .font(.body)
                                .foregroundColor(.primary)
                        }

                        Divider()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: 4)
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
            }
        }
        .padding(.horizontal)
        .onAppear {
            firestoreManager.fetchActivities()
        }
        .navigationTitle("Consultar Atividades")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Consultar Atividades")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
            }
        }
        .background(Color("backgroundGray").edgesIgnoringSafeArea(.all))
    }
}

struct ListActivityView_Previews: PreviewProvider {
    static var previews: some View {
        listActivityView()
    }
}
