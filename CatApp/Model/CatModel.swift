import Foundation

struct CatModel: Codable {
    let breeds: [Breed]
    let id: String
    let url: String
    let width: Int
    var height: Int
    let categories: [Category]?
}
