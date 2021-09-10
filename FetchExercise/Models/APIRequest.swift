//
//  

import Foundation

protocol APIRequest {
    var baseURL: URL { get }
    var path: String { get }
}

enum MealAPI: APIRequest {
    case categories
    case mealList(category: String)
    case mealDetails(id: Int)
    
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com")!
    }
    
    var path: String {
        switch self {
        case .categories:
            return "api/json/v1/1/categories.php"
        case .mealList(let category):
            return "api/json/v1/1/filter.php?c=\(category)"
        case .mealDetails(let id):
            return "api/json/v1/1/lookup.php?i=\(id)"
        }
    }
}
