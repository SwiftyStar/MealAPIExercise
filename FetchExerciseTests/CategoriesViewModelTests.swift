//
//  

import XCTest
@testable import FetchExercise

final class CategoriesViewModelTests: XCTestCase {
    
    func testGetContent() {
        let mockNetwork1 = MockNetworkManager(data: TestData.categoriesData, error: nil)
        let viewModel1 = CategoriesViewModel(networkManager: mockNetwork1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { error in
            XCTAssertNil(error)
            expectation1.fulfill()
        }
        
        let mockNetwork2 = MockNetworkManager(data: nil, error: URLError(.badURL))
        let viewModel2 = CategoriesViewModel(networkManager: mockNetwork2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { error in
            XCTAssert((error as! URLError) == URLError(.badURL))
            expectation2.fulfill()
        }
        
        let mockNetwork3 = MockNetworkManager(data: TestData.invalidData, error: nil)
        let viewModel3 = CategoriesViewModel(networkManager: mockNetwork3)
        let expectation3 = expectation(description: "3")
        
        viewModel3.getContent { error in
            XCTAssertNotNil(error)
            expectation3.fulfill()
        }
        
        wait(for: [expectation1, expectation2, expectation3], timeout: 10)
    }
    
    func testGetCategory() {
        let mockNetwork1 = MockNetworkManager(data: TestData.categoriesData, error: nil)
        let viewModel1 = CategoriesViewModel(networkManager: mockNetwork1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { _ in
            let first = viewModel1.getCategory(for: IndexPath(row: 0, section: 0))
            XCTAssert(first!.name == "Apple")
            
            let second = viewModel1.getCategory(for: IndexPath(row: 1, section: 0))
            XCTAssert(second!.name == "Apricot")
            
            let last = viewModel1.getCategory(for: IndexPath(row: 3, section: 0))
            XCTAssert(last!.name == "Donuts")
            
            let outOfBounds = viewModel1.getCategory(for: IndexPath(row: 50, section: 50))
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
        let mockNetwork1 = MockNetworkManager(data: TestData.categoriesData, error: nil)
        let viewModel1 = CategoriesViewModel(networkManager: mockNetwork1)
        let expectation1 = expectation(description: "1")
        
        viewModel1.getContent { _ in
            let rows = viewModel1.getNumberOfRows()
            XCTAssert(rows == 4)
            expectation1.fulfill()
        }
        
        let mockNetwork2 = MockNetworkManager(data: TestData.invalidData, error: nil)
        let viewModel2 = CategoriesViewModel(networkManager: mockNetwork2)
        let expectation2 = expectation(description: "2")
        
        viewModel2.getContent { _ in
            let rows = viewModel2.getNumberOfRows()
            XCTAssert(rows == 0)
            expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 10)
    }
    
    enum TestData {
        static let categories: Categories = {
            Categories(categories: [Category(id: "12345", name: "Apple", imageURLString: nil, description: "Apples are really good"),
                                    Category(id: "5", name: "Donuts", imageURLString: nil, description: "Mmmmm dooonuts"),
                                    Category(id: "1", name: "Banana", imageURLString: nil, description: "Bananas are yellow"),
                                    Category(id: "0.5", name: "Apricot", imageURLString: nil, description: "Can't remember the last time I had an apricot")])
        }()
        
        static var categoriesData: Data {
            try! JSONEncoder().encode(self.categories)
        }
        
        static let invalidData: Data = {
            "Not a category".data(using: .utf8)!
        }()
    }
}
