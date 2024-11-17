
import SwiftUI
import Firebase

@main
struct MyFitLogApp: App {
        
    @StateObject private var databaseFirestore = DatabaseFirestore() // Instância global de DatabaseFirestore

    init() {
            FirebaseApp.configure()  // Inicializando o Firebase
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(databaseFirestore) // Injetando no ambiente
        }
    }
}
