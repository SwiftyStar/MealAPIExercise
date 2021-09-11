//
//  

import Foundation

struct Categories: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
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
