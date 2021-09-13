//
//

import XCTest
@testable import FetchExercise

final class MealCollectionViewModelTests: XCTestCase {
    
    func testGetContent() {
        let mockNetwork1 = MockNetworkManager(data: TestData.mealsData, error: nil)
        let viewModel1 = MealCollectionViewModel(category: TestData.category, networkManager: mockNetwork1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { error in
            XCTAssertNil(error)
            expectation1.fulfill()
        }
        
        let mockNetwork2 = MockNetworkManager(data: nil, error: URLError(.badURL))
        let viewModel2 = MealCollectionViewModel(category: TestData.category, networkManager: mockNetwork2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { error in
            XCTAssert((error as! URLError) == URLError(.badURL))
            expectation2.fulfill()
        }
        
        let mockNetwork3 = MockNetworkManager(data: TestData.invalidData, error: nil)
        let viewModel3 = MealCollectionViewModel(category: TestData.category, networkManager: mockNetwork3)
        let expectation3 = expectation(description: "3")
        
        viewModel3.getContent { error in
            XCTAssertNotNil(error)
            expectation3.fulfill()
        }
        
        wait(for: [expectation1, expectation2, expectation3], timeout: 10)
    }
    
    func testGetMeal() {
        let mockNetwork1 = MockNetworkManager(data: TestData.mealsData, error: nil)
        let viewModel1 = MealCollectionViewModel(category: TestData.category, networkManager: mockNetwork1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { _ in
            let first = viewModel1.getMeal(for: IndexPath(row: 0, section: 0))
            XCTAssert(first!.name == "Big Mac w large fries")
            
            let second = viewModel1.getMeal(for: IndexPath(row: 1, section: 0))
            XCTAssert(second!.name == "Cantaloupe")
            
            let last = viewModel1.getMeal(for: IndexPath(row: 3, section: 0))
            XCTAssert(last!.name == "Ostrich")
            
            let outOfBounds = viewModel1.getMeal(for: IndexPath(row: 50, section: 50))
            XCTAssertNil(outOfBounds)
            
            expectation1.fulfill()
        }
        
        let mockNetwork2 = MockNetworkManager(data: TestData.invalidData, error: nil)
        let viewModel2 = CategoriesViewModel(networkManager: mockNetwork2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { _ in
            let outOfBounds = viewModel2.getCategory(for: IndexPath(row: 0, section: 0))
            XCTAssertNil(outOfBounds)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10)
    }
    
    func testGetNumberOfRows() {
        let mockNetwork1 = MockNetworkManager(data: TestData.mealsData, error: nil)
        let viewModel1 = MealCollectionViewModel(category: TestData.category, networkManager: mockNetwork1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { _ in
            let rows = viewModel1.getNumberOfItems()
            XCTAssert(rows == 4)
            expectation1.fulfill()
        }
        
        let mockNetwork2 = MockNetworkManager(data: TestData.invalidData, error: nil)
        let viewModel2 = MealCollectionViewModel(category: TestData.category, networkManager: mockNetwork2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { _ in
            let rows = viewModel2.getNumberOfItems()
            XCTAssert(rows == 0)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10)
    }
    
    func testGetName() {
        let viewModel1 = MealCollectionViewModel(category: TestData.category)
        let name1 = viewModel1.getName()
        XCTAssert(name1 == "Random")
        
        let viewModel2 = MealCollectionViewModel(category: TestData.emptyCategory)
        let name2 = viewModel2.getName()
        XCTAssert(name2 == kCategory)
    }
    
    func testGetItemSize() {
        let viewModel = MealCollectionViewModel(category: TestData.category)
        
        let itemSize1 = viewModel.getItemSize(spacing: 10, itemsPerRow: 5)
        let expectedWidth1 = (UIScreen.main.bounds.width - CGFloat(20) - CGFloat(40)) / 5
        let expectedHeight1 = expectedWidth1 + MealCollectionViewCell.nameLabelFont.lineHeight + MealCollectionViewCell.nameLabelTopPadding
        let expectedSize1 = CGSize(width: expectedWidth1, height: expectedHeight1)
        XCTAssert(itemSize1 == expectedSize1)
        
        let itemSize2 = viewModel.getItemSize(spacing: 0, itemsPerRow: 3)
        let expectedWidth2 = UIScreen.main.bounds.width / 3
        let expectedHeight2 = expectedWidth2 + MealCollectionViewCell.nameLabelFont.lineHeight + MealCollectionViewCell.nameLabelTopPadding
        let expectedSize2 = CGSize(width: expectedWidth2, height: expectedHeight2)
        XCTAssert(itemSize2 == expectedSize2)
    }
    
    func getItemSize(spacing: CGFloat, itemsPerRow: Int) -> CGSize {
        let cgItemsPerRow = CGFloat(itemsPerRow)
        let interItemSpacing = spacing * (cgItemsPerRow - 1)
        let horizontalSpacing = spacing * 2
        let totalSpacing = horizontalSpacing + interItemSpacing
        
        let availableWidth = UIScreen.main.bounds.width - totalSpacing
        let width = availableWidth / cgItemsPerRow
        let height = width + MealCollectionViewCell.nameLabelFont.lineHeight + MealCollectionViewCell.nameLabelTopPadding
        
        return CGSize(width: width, height: height)
    }
    
    enum TestData {
        static let category = FetchExercise.Category(id: "sdasdf", name: "Random", imageURLString: nil, description: "Good stuff")
        static let emptyCategory = FetchExercise.Category(id: "", name: nil, imageURLString: nil, description: nil)
        
        static let meals: Meals = {
            Meals(meals: [Meal(id: "555", name: "Ostrich", imageURLString: nil),
            Meal(id: "349", name: "Cantaloupe", imageURLString: nil),
            Meal(id: "222", name: "Big Mac w large fries", imageURLString: nil),
            Meal(id: "531", name: "In N' Out", imageURLString: nil)])
        }()
        
        static var mealsData: Data {
            try! JSONEncoder().encode(self.meals)
        }
        
        static let invalidData: Data = {
            "Not a meal".data(using: .utf8)!
        }()
    }
}
