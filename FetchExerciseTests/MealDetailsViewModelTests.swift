//
//

import XCTest
@testable import FetchExercise

final class MealDetailsViewModelTests: XCTestCase {
    
    func testGetContent() {
        let mockNetwork1 = MockNetworkManager(data: TestData.mealDetailsData, error: nil)
        let viewModel1 = MealDetailsViewModel(meal: TestData.meal, networkManager: mockNetwork1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { error in
            XCTAssertNil(error)
            expectation1.fulfill()
        }
        
        let mockNetwork2 = MockNetworkManager(data: nil, error: URLError(.badURL))
        let viewModel2 = MealDetailsViewModel(meal: TestData.meal, networkManager: mockNetwork2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { error in
            XCTAssert((error as! URLError) == URLError(.badURL))
            expectation2.fulfill()
        }
        
        let mockNetwork3 = MockNetworkManager(data: TestData.invalidData, error: nil)
        let viewModel3 = MealDetailsViewModel(meal: TestData.meal, networkManager: mockNetwork3)
        let expectation3 = expectation(description: "3")
        
        viewModel3.getContent { error in
            XCTAssertNotNil(error)
            expectation3.fulfill()
        }
        
        wait(for: [expectation1, expectation2, expectation3], timeout: 10)
    }
    
    func testGetIngredients() {
        let mockNetwork1 = MockNetworkManager(data: TestData.mealDetailsData, error: nil)
        let viewModel1 = MealDetailsViewModel(meal: TestData.meal, networkManager: mockNetwork1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { _ in
            let ingredients = viewModel1.getIngredients()
            let first = ingredients.first!
            XCTAssert(first.name == "Pickles")
            XCTAssert(first.measurement == "A lot of")

            let second = ingredients[1]
            XCTAssert(second.name == "Carrots")
            XCTAssert(second.measurement == "Twenty")
            
            let last = ingredients.last!
            XCTAssert(last.name == "Onion")
            XCTAssert(last.measurement == "16")
            
            expectation1.fulfill()
        }
        
        let mockNetwork2 = MockNetworkManager(data: TestData.invalidData, error: nil)
        let viewModel2 = MealDetailsViewModel(meal: TestData.meal, networkManager: mockNetwork2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { _ in
            let ingredients = viewModel2.getIngredients()
            XCTAssertTrue(ingredients.isEmpty)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10)
    }
    
    func testGetName() {
        let viewModel1 = MealDetailsViewModel(meal: TestData.meal)
        let name1 = viewModel1.getName()
        XCTAssert(name1 == "Great meal")
        
        let viewModel2 = MealDetailsViewModel(meal: TestData.emptyMeal)
        let name2 = viewModel2.getName()
        XCTAssert(name2 == kMeal)
    }
    
    func testGetSourceURL() {
        let network1 = MockNetworkManager(data: TestData.mealDetailsData, error: nil)
        let viewModel1 = MealDetailsViewModel(meal: TestData.meal, networkManager: network1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { _ in
            let url1 = viewModel1.getSourceURL()
            XCTAssert(url1!.absoluteString == "https://www.somerecipe.com")
            expectation1.fulfill()
        }
        
        let network2 = MockNetworkManager(data: nil, error: nil)
        let viewModel2 = MealDetailsViewModel(meal: TestData.emptyMeal, networkManager: network2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { _ in
            let url2 = viewModel2.getSourceURL()
            XCTAssertNil(url2)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10)
    }
    
    func testGetYoutubeURl() {
        let network1 = MockNetworkManager(data: TestData.mealDetailsData, error: nil)
        let viewModel1 = MealDetailsViewModel(meal: TestData.meal, networkManager: network1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { _ in
            let url1 = viewModel1.getYoutubeURL()
            XCTAssert(url1!.absoluteString == "https://www.youtube.com")
            expectation1.fulfill()
        }
        
        let network2 = MockNetworkManager(data: nil, error: nil)
        let viewModel2 = MealDetailsViewModel(meal: TestData.emptyMeal, networkManager: network2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { _ in
            let url2 = viewModel2.getYoutubeURL()
            XCTAssertNil(url2)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10)
    }
    
    func testGetInstructions() {
        let network1 = MockNetworkManager(data: TestData.mealDetailsData, error: nil)
        let viewModel1 = MealDetailsViewModel(meal: TestData.meal, networkManager: network1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { _ in
            let instructions1 = viewModel1.getInstructions()
            XCTAssert(instructions1 == "someInstructions")
            expectation1.fulfill()
        }
        
        let network2 = MockNetworkManager(data: nil, error: nil)
        let viewModel2 = MealDetailsViewModel(meal: TestData.emptyMeal, networkManager: network2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { _ in
            let instructions2 = viewModel2.getInstructions()
            XCTAssertNil(instructions2)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10)
    }
    
    enum TestData {
        static let meal = FetchExercise.Meal(id: "sdasdf", name: "Great meal", imageURLString: nil)
        static let emptyMeal = FetchExercise.Meal(id: "", name: nil, imageURLString: nil)
        
        static let mealDetails: MealDetails = {
            MealDetails(meals: [MealDetail(id: "2", name: "someName", instructions: "someInstructions", imageURLString: "https://www.google.com", youtubeURLString: "https://www.youtube.com", sourceURLString: "https://www.somerecipe.com", ingredientName1: "Pickles", ingredientName2: "Carrots", ingredientName3: "Popsicles", ingredientName4: "Grape Jelly", ingredientName5: "Peanut Butter", ingredientName6: "Onion", ingredientName7: nil, ingredientName8: nil, ingredientName9: nil, ingredientName10: nil, ingredientName11: nil, ingredientName12: nil, ingredientName13: nil, ingredientName14: nil, ingredientName15: nil, ingredientName16: nil, ingredientName17: nil, ingredientName18: nil, ingredientName19: nil, ingredientName20: nil, ingredientMeasure1: "A lot of", ingredientMeasure2: "Twenty", ingredientMeasure3: "Several", ingredientMeasure4: "2 Jars", ingredientMeasure5: "500", ingredientMeasure6: "16", ingredientMeasure7: nil, ingredientMeasure8: nil, ingredientMeasure9: nil, ingredientMeasure10: nil, ingredientMeasure11: nil, ingredientMeasure12: nil, ingredientMeasure13: nil, ingredientMeasure14: nil, ingredientMeasure15: nil, ingredientMeasure16: nil, ingredientMeasure17: nil, ingredientMeasure18: nil, ingredientMeasure19: nil, ingredientMeasure20: nil)])
        }()
        
        static var mealDetailsData: Data {
            try! JSONEncoder().encode(self.mealDetails)
        }
        
        static let invalidData: Data = {
            "Not a detail".data(using: .utf8)!
        }()
    }
}
