import Foundation

// Identifiable requires ID for storage, Codable generates to code to serialize and save
struct Item: Identifiable, Codable {
    let id = UUID()
    var todo: String
}
