import Foundation

class DataFormatter {
    
    static func formatDuration(_ value: String) -> String {
        let filtered = value.filter { "0123456789".contains($0) }
        return filtered
    }
    
    static func formatDistance(_ value: String) -> String {
        let filtered = value.filter { "0123456789.".contains($0) }
        let parts = filtered.split(separator: ".")
        if parts.count > 2 {
            return String(parts[0]) + "." + String(parts[1])
        }
        return filtered
    }
    
    static func formatCalories(_ value: String) -> String {
        let filtered = value.filter { "0123456789".contains($0) }
        return filtered
    }
    
    static func formatDate(_ value: String) -> String {
            var filtered = value.filter { "0123456789".contains($0) }  // Filtra apenas números
            
            if filtered.count > 2 {
                filtered.insert("/", at: filtered.index(filtered.startIndex, offsetBy: 2))  // Inserir barra após o dia
            }
            if filtered.count > 5 {
                filtered.insert("/", at: filtered.index(filtered.startIndex, offsetBy: 5))  // Inserir barra após o mês
            }
            if filtered.count > 10 {
                filtered = String(filtered.prefix(10))
            }
            return filtered
        }
}
