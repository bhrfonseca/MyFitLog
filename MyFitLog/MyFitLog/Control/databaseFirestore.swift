import Foundation
import FirebaseFirestore

class DatabaseFirestore: ObservableObject {
    @Published var activities: [Activity] = []
    private let db = Firestore.firestore()

    func saveActivity(activity: Activity, completion: @escaping (Bool) -> Void) {
        let activityDTO = ActivityDTO(activity: activity)
        let data = activityDTO.toDictionary()
        
        db.collection("activities").addDocument(data: data) { error in
            if let error = error {
                print("Erro ao salvar atividade: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Atividade salva com sucesso!")
                self.fetchActivities() 
                completion(true)
            }
        }
    }

    func fetchActivities() {
        db.collection("activities")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Erro ao carregar atividades: \(error.localizedDescription)")
                    return
                }
                
                self.activities = snapshot?.documents.compactMap { document in
                    let data = document.data()
                    let type = ActivityType(rawValue: data["type"] as? String ?? "running") ?? .running
                    let duration = data["duration"] as? String ?? ""
                    let calories = data["calories"] as? String ?? ""
                    let distance = data["distance"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    
                    let activity = Activity(type: type, duration: duration, calories: calories, date: date, distance: distance)
                    activity.id = document.documentID
                    return activity
                } ?? []
            }
    }

    func updateActivity(activity: Activity) {
        let documentId = activity.id
        let activityDTO = ActivityDTO(activity: activity)
        let updatedData = activityDTO.toDictionary() // Usando o DTO para converter em dicionário
        
        db.collection("activities").document(documentId).updateData(updatedData) { error in
            if let error = error {
                print("Erro ao atualizar atividade: \(error.localizedDescription)")
            } else {
                print("Atividade atualizada com sucesso!")
                self.fetchActivities() // Atualiza a lista após edição
            }
        }
    }

    func deleteActivity(activity: Activity) {
        let documentId = activity.id
        
        db.collection("activities").document(documentId).delete { error in
            if let error = error {
                print("Erro ao excluir atividade: \(error.localizedDescription)")
            } else {
                print("Atividade excluída com sucesso!")
                self.fetchActivities() // Atualiza a lista após exclusão
            }
        }
    }
    
}
