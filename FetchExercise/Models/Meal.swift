//
//  

import Foundation

struct Meals: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let id: String?
    let name: String?
    let imageURLString: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURLString = "strMealThumb"
    }
}
