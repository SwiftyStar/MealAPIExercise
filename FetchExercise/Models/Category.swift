//
//  

import Foundation

struct Categories: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: String
    let name: String?
    let imageURLString: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case imageURLString = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
