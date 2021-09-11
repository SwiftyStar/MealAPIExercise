//
//  

import UIKit

final class MealCollectionViewController: BaseViewController {
    private let viewModel: MealCollectionViewModel
    private let spacing: CGFloat = 16
    private let itemsPerRow = 2
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MealCollectionViewCell.self, forCellWithReuseIdentifier: MealCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    init(category: Category) {
        self.viewModel = MealCollectionViewModel(category: category)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.loadContent()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.getName()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView
            .leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
            .isActive = true
        self.collectionView
            .trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
            .isActive = true
        self.collectionView
            .topAnchor
            .constraint(equalTo: self.view.topAnchor)
            .isActive = true
        self.collectionView
            .bottomAnchor
            .constraint(equalTo: self.view.bottomAnchor)
            .isActive = true
    }
    
    private func loadContent() {
        self.showActivityIndicator()
        self.viewModel.getContent { [weak self] error in
            self?.hideActivityIndicator()
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension MealCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.reuseIdentifier, for: indexPath) as! MealCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let mealCell = cell as? MealCollectionViewCell else { return }
        
        let meal = self.viewModel.getMeal(for: indexPath)
        mealCell.configure(with: meal)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.viewModel.getItemSize(for: self.spacing, itemsPerRow: self.itemsPerRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: self.spacing, left: self.spacing, bottom: self.spacing, right: self.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        self.spacing
    }
}
