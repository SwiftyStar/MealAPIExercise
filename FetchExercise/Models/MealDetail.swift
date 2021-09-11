//
//  

import Foundation

struct MealDetails: Decodable {
    let meals: [MealDetail]
}

final class MealDetail: NSObject, Decodable {
    let id: String?
    let name: String?
    let instructions: String?
    let imageURLString: String?
    let youtubeURLString: String?
    let sourceURLString: String?
    @objc let ingredientName1: String?
    @objc let ingredientName2: String?
    @objc let ingredientName3: String?
    @objc let ingredientName4: String?
    @objc let ingredientName5: String?
    @objc let ingredientName6: String?
    @objc let ingredientName7: String?
    @objc let ingredientName8: String?
    @objc let ingredientName9: String?
    @objc let ingredientName10: String?
    @objc let ingredientName11: String?
    @objc let ingredientName12: String?
    @objc let ingredientName13: String?
    @objc let ingredientName14: String?
    @objc let ingredientName15: String?
    @objc let ingredientName16: String?
    @objc let ingredientName17: String?
    @objc let ingredientName18: String?
    @objc let ingredientName19: String?
    @objc let ingredientName20: String?
    @objc let ingredientMeasure1: String?
    @objc let ingredientMeasure2: String?
    @objc let ingredientMeasure3: String?
    @objc let ingredientMeasure4: String?
    @objc let ingredientMeasure5: String?
    @objc let ingredientMeasure6: String?
    @objc let ingredientMeasure7: String?
    @objc let ingredientMeasure8: String?
    @objc let ingredientMeasure9: String?
    @objc let ingredientMeasure10: String?
    @objc let ingredientMeasure11: String?
    @objc let ingredientMeasure12: String?
    @objc let ingredientMeasure13: String?
    @objc let ingredientMeasure14: String?
    @objc let ingredientMeasure15: String?
    @objc let ingredientMeasure16: String?
    @objc let ingredientMeasure17: String?
    @objc let ingredientMeasure18: String?
    @objc let ingredientMeasure19: String?
    @objc let ingredientMeasure20: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case imageURLString = "strMealThumb"
        case youtubeURLString = "strYoutube"
        case sourceURLString = "strSource"
        case ingredientName1 = "strIngredient1"
        case ingredientName2 = "strIngredient2"
        case ingredientName3 = "strIngredient3"
        case ingredientName4 = "strIngredient4"
        case ingredientName5 = "strIngredient5"
        case ingredientName6 = "strIngredient6"
        case ingredientName7 = "strIngredient7"
        case ingredientName8 = "strIngredient8"
        case ingredientName9 = "strIngredient9"
        case ingredientName10 = "strIngredient10"
        case ingredientName11 = "strIngredient11"
        case ingredientName12 = "strIngredient12"
        case ingredientName13 = "strIngredient13"
        case ingredientName14 = "strIngredient14"
        case ingredientName15 = "strIngredient15"
        case ingredientName16 = "strIngredient16"
        case ingredientName17 = "strIngredient17"
        case ingredientName18 = "strIngredient18"
        case ingredientName19 = "strIngredient19"
        case ingredientName20 = "strIngredient20"
        case ingredientMeasure1 = "strMeasure1"
        case ingredientMeasure2 = "strMeasure2"
        case ingredientMeasure3 = "strMeasure3"
        case ingredientMeasure4 = "strMeasure4"
        case ingredientMeasure5 = "strMeasure5"
        case ingredientMeasure6 = "strMeasure6"
        case ingredientMeasure7 = "strMeasure7"
        case ingredientMeasure8 = "strMeasure8"
        case ingredientMeasure9 = "strMeasure9"
        case ingredientMeasure10 = "strMeasure10"
        case ingredientMeasure11 = "strMeasure11"
        case ingredientMeasure12 = "strMeasure12"
        case ingredientMeasure13 = "strMeasure13"
        case ingredientMeasure14 = "strMeasure14"
        case ingredientMeasure15 = "strMeasure15"
        case ingredientMeasure16 = "strMeasure16"
        case ingredientMeasure17 = "strMeasure17"
        case ingredientMeasure18 = "strMeasure18"
        case ingredientMeasure19 = "strMeasure19"
        case ingredientMeasure20 = "strMeasure20"
    }
}
