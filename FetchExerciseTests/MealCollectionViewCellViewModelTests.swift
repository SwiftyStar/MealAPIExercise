//
//

import XCTest
@testable import FetchExercise

final class MealCollectionViewCellViewModelTests: XCTestCase {
        
    func testGetName() {
        let viewModel = MealCollectionViewCellViewModel()
        
        let name1 = viewModel.getName(for: TestData.meal)
        XCTAssert(name1 == "someName")
        
        let name2 = viewModel.getName(for: TestData.emptyMeal)
        XCTAssert(name2 == kMeal)
    }
    
    func testDownloadImage() {
        let goodMockNetworkManager = MockNetworkManager(data: TestData.imageData, error: nil)
        let badMockNetworkManager = MockNetworkManager(data: nil, error: URLError(.cannotFindHost))
        let cancelledMockNetworkManager = MockNetworkManager(data: nil, error: URLError(.cancelled))

        let mockImageCache1 = MockImageCache()
        let viewModel1 = MealCollectionViewCellViewModel(imageCache: mockImageCache1, networkManager: goodMockNetworkManager)
        let expectation1 = expectation(description: "1")
        
        viewModel1.downloadImage(for: TestData.meal) { downloadState in
            switch downloadState {
            case .success:
                break
            case .failure:
                XCTFail()
            case .cancelled:
                XCTFail()
            }
            
            expectation1.fulfill()
        }
        
        let mockImageCache2 = MockImageCache()
        mockImageCache2.cacheImage(UIImage(systemName: "person.fill")!, for: "")
        let viewModel2 = MealCollectionViewCellViewModel(imageCache: mockImageCache2, networkManager: goodMockNetworkManager)
        let expectation2 = expectation(description: "2")
        
        viewModel2.downloadImage(for: TestData.meal) { downloadState in
            switch downloadState {
            case .success(let image):
                XCTAssert(image == UIImage(systemName: "person.fill")!)
            case .failure:
                XCTFail()
            case .cancelled:
                XCTFail()
            }
            
            expectation2.fulfill()
        }
        
        let mockImageCache3 = MockImageCache()
        let viewModel3 = MealCollectionViewCellViewModel(imageCache: mockImageCache3, networkManager: badMockNetworkManager)
        let expectation3 = expectation(description: "3")
        
        viewModel3.downloadImage(for: TestData.meal) { downloadState in
            switch downloadState {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssert((error as! URLError).code == .cannotFindHost)
            case .cancelled:
                XCTFail()
            }
            
            expectation3.fulfill()
        }
        
        let mockImageCache4 = MockImageCache()
        let viewModel4 = MealCollectionViewCellViewModel(imageCache: mockImageCache4, networkManager: cancelledMockNetworkManager)
        let expectation4 = expectation(description: "4")
        
        viewModel4.downloadImage(for: TestData.meal) { downloadState in
            switch downloadState {
            case .success:
                XCTFail()
            case .failure:
                XCTFail()
            case .cancelled:
                break
            }
            
            expectation4.fulfill()
        }
        
        wait(for: [expectation1, expectation2, expectation3, expectation4], timeout: 10)
    }
    
    enum TestData {
        static let meal: FetchExercise.Meal = {
            Meal(id: "someID", name: "someName", imageURLString: "https://www.google.com")
        }()
        
        static let emptyMeal: FetchExercise.Meal = {
            Meal(id: "", name: nil, imageURLString: nil)
        }()
        
        static let imageData: Data =  {
            UIImage(systemName: "gearshape")!.pngData()!
        }()
    }
}
