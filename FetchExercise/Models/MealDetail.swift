//
//  

import Foundation

struct MealDetails: Codable {
    let meals: [MealDetail]
}

final class MealDetail: NSObject, Codable {
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
    
    init(id: String?,
         name: String?,
         instructions: String?,
         imageURLString: String?,
         youtubeURLString: String?,
         sourceURLString: String?,
         ingredientName1: String?,
         ingredientName2: String?,
         ingredientName3: String?,
         ingredientName4: String?,
         ingredientName5: String?,
         ingredientName6: String?,
         ingredientName7: String?,
         ingredientName8: String?,
         ingredientName9: String?,
         ingredientName10: String?,
         ingredientName11: String?,
         ingredientName12: String?,
         ingredientName13: String?,
         ingredientName14: String?,
         ingredientName15: String?,
         ingredientName16: String?,
         ingredientName17: String?,
         ingredientName18: String?,
         ingredientName19: String?,
         ingredientName20: String?,
         ingredientMeasure1: String?,
         ingredientMeasure2: String?,
         ingredientMeasure3: String?,
         ingredientMeasure4: String?,
         ingredientMeasure5: String?,
         ingredientMeasure6: String?,
         ingredientMeasure7: String?,
         ingredientMeasure8: String?,
         ingredientMeasure9: String?,
         ingredientMeasure10: String?,
         ingredientMeasure11: String?,
         ingredientMeasure12: String?,
         ingredientMeasure13: String?,
         ingredientMeasure14: String?,
         ingredientMeasure15: String?,
         ingredientMeasure16: String?,
         ingredientMeasure17: String?,
         ingredientMeasure18: String?,
         ingredientMeasure19: String?,
         ingredientMeasure20: String?) {
        self.id = id
        self.name = name
        self.imageURLString = imageURLString
        self.sourceURLString = sourceURLString
        self.youtubeURLString = youtubeURLString
        self.instructions = instructions
        self.ingredientName1 = ingredientName1
        self.ingredientName2 = ingredientName2
        self.ingredientName3 = ingredientName3
        self.ingredientName4 = ingredientName4
        self.ingredientName5 = ingredientName5
        self.ingredientName6 = ingredientName6
        self.ingredientName7 = ingredientName7
        self.ingredientName8 = ingredientName8
        self.ingredientName9 = ingredientName9
        self.ingredientName10 = ingredientName10
        self.ingredientName11 = ingredientName11
        self.ingredientName12 = ingredientName12
        self.ingredientName13 = ingredientName13
        self.ingredientName14 = ingredientName14
        self.ingredientName15 = ingredientName15
        self.ingredientName16 = ingredientName16
        self.ingredientName17 = ingredientName17
        self.ingredientName18 = ingredientName18
        self.ingredientName19 = ingredientName19
        self.ingredientName20 = ingredientName20
        self.ingredientMeasure1 = ingredientMeasure1
        self.ingredientMeasure2 = ingredientMeasure2
        self.ingredientMeasure3 = ingredientMeasure3
        self.ingredientMeasure4 = ingredientMeasure4
        self.ingredientMeasure5 = ingredientMeasure5
        self.ingredientMeasure6 = ingredientMeasure6
        self.ingredientMeasure7 = ingredientMeasure7
        self.ingredientMeasure8 = ingredientMeasure8
        self.ingredientMeasure9 = ingredientMeasure9
        self.ingredientMeasure10 = ingredientMeasure10
        self.ingredientMeasure11 = ingredientMeasure11
        self.ingredientMeasure12 = ingredientMeasure12
        self.ingredientMeasure13 = ingredientMeasure13
        self.ingredientMeasure14 = ingredientMeasure14
        self.ingredientMeasure15 = ingredientMeasure15
        self.ingredientMeasure16 = ingredientMeasure16
        self.ingredientMeasure17 = ingredientMeasure17
        self.ingredientMeasure18 = ingredientMeasure18
        self.ingredientMeasure19 = ingredientMeasure19
        self.ingredientMeasure20 = ingredientMeasure20
    }
}
