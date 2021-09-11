//
//  

import Foundation

protocol APIRequest {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queries: [String: String]? { get }
}

enum MealAPI: APIRequest {
    case categories
    case mealList(categoryId: String)
    case mealDetails(mealId: String)
    
    var scheme: String {
        "https"
    }
    var host: String {
        "www.themealdb.com"
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/api/json/v1/1/categories.php"
        case .mealList:
            return "/api/json/v1/1/filter.php"
        case .mealDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var queries: [String: String]? {
        switch self {
        case .categories:
            return nil
        case .mealList(let categoryId):
            return ["c": categoryId]
        case .mealDetails(let mealId):
            return ["i": "\(mealId)"]
        }
    }
}
