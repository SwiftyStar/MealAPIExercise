//
//

import XCTest
@testable import FetchExercise

final class CategoryCellViewModelTests: XCTestCase {
        
    func testGetName() {
        let viewModel = CategoryCellViewModel()
        
        let name1 = viewModel.getName(for: TestData.category)
        XCTAssert(name1 == "someName")
        
        let name2 = viewModel.getName(for: TestData.emptyCategory)
        XCTAssert(name2 == kCategory)
    }
    
    func testGetDescription() {
        let viewModel = CategoryCellViewModel()
        
        let description1 = viewModel.getDescription(for: TestData.category)
        XCTAssert(description1 == "someDescription")
        
        let description2 = viewModel.getDescription(for: TestData.emptyCategory)
        XCTAssert(description2 == kDescription)
    }
    
    func testDownloadImage() {
        let goodMockNetworkManager = MockNetworkManager(data: TestData.imageData, error: nil)
        let badMockNetworkManager = MockNetworkManager(data: nil, error: URLError(.cannotFindHost))
        let cancelledMockNetworkManager = MockNetworkManager(data: nil, error: URLError(.cancelled))

        let mockImageCache1 = MockImageCache()
        let viewModel1 = CategoryCellViewModel(imageCache: mockImageCache1, networkManager: goodMockNetworkManager)
        let expectation1 = expectation(description: "1")
        
        viewModel1.downloadImage(for: TestData.category) { downloadState in
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
        let viewModel2 = CategoryCellViewModel(imageCache: mockImageCache2, networkManager: goodMockNetworkManager)
        let expectation2 = expectation(description: "2")
        
        viewModel2.downloadImage(for: TestData.category) { downloadState in
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
        let viewModel3 = CategoryCellViewModel(imageCache: mockImageCache3, networkManager: badMockNetworkManager)
        let expectation3 = expectation(description: "3")
        
        viewModel3.downloadImage(for: TestData.category) { downloadState in
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
        let viewModel4 = CategoryCellViewModel(imageCache: mockImageCache4, networkManager: cancelledMockNetworkManager)
        let expectation4 = expectation(description: "4")
        
        viewModel4.downloadImage(for: TestData.category) { downloadState in
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
        static let category: FetchExercise.Category = {
            Category(id: "someID", name: "someName", imageURLString: "https://www.google.com", description: "someDescription")
        }()
        
        static let emptyCategory: FetchExercise.Category = {
            Category(id: "", name: nil, imageURLString: nil, description: nil)
        }()
        
        static let imageData: Data =  {
            UIImage(systemName: "gearshape")!.pngData()!
        }()
    }
}
