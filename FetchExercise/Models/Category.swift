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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let imageURLString = try container.decodeIfPresent(String.self, forKey: .imageURLString)
        let description = try container.decodeIfPresent(String.self, forKey: .description)

        self.id = id
        self.name = name
        self.imageURLString = imageURLString
        self.description = description
    }
}
