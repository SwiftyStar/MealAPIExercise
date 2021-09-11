//
//  

import UIKit

final class MealCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MealCell"
    static let nameLabelFont: UIFont = .preferredFont(forTextStyle: .body)
    static let nameLabelTopPadding: CGFloat = 12
    
    private let viewModel = MealCollectionViewCellViewModel()
    
    private var imageHeight: CGFloat {
        self.contentView.frame.width
    }
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loadingView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Self.nameLabelFont
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.mealImageView)
        self.mealImageView.translatesAutoresizingMaskIntoConstraints = false
        self.mealImageView
            .topAnchor
            .constraint(equalTo: self.contentView.topAnchor)
            .isActive = true
        self.mealImageView
            .leadingAnchor
            .constraint(equalTo: self.contentView.leadingAnchor)
            .isActive = true
        self.mealImageView
            .trailingAnchor
            .constraint(equalTo: self.contentView.trailingAnchor)
            .isActive = true
        self.mealImageView
            .heightAnchor
            .constraint(equalToConstant: self.imageHeight)
            .isActive = true
        
        self.contentView.addSubview(self.loadingView)
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.loadingView
            .leadingAnchor
            .constraint(equalTo: self.mealImageView.leadingAnchor)
            .isActive = true
        self.loadingView
            .topAnchor
            .constraint(equalTo: self.mealImageView.topAnchor)
            .isActive = true
        self.loadingView
            .trailingAnchor
            .constraint(equalTo: self.mealImageView.trailingAnchor)
            .isActive = true
        self.loadingView
            .bottomAnchor
            .constraint(equalTo: self.mealImageView.bottomAnchor)
            .isActive = true
        
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel
            .topAnchor
            .constraint(equalTo: self.mealImageView.bottomAnchor, constant: Self.nameLabelTopPadding)
            .isActive = true
        self.nameLabel
            .leadingAnchor
            .constraint(equalTo: self.contentView.leadingAnchor)
            .isActive = true
        self.nameLabel
            .trailingAnchor
            .constraint(equalTo: self.contentView.trailingAnchor)
            .isActive = true
        self.nameLabel
            .bottomAnchor
            .constraint(equalTo: self.contentView.bottomAnchor)
            .isActive = true
    }
    
    func configure(with meal: Meal?) {
        self.nameLabel.text = self.viewModel.getName(for: meal)
        
        self.viewModel.cancelDownload()
        self.mealImageView.image = nil
        self.loadingView.startAnimating()
        self.loadingView.isHidden = false
        self.viewModel.downloadImage(for: meal) { [weak self] image in
            self?.loadingView.stopAnimating()
            self?.loadingView.isHidden = true
            self?.mealImageView.image = image // ?? defaultImage, or display some other view when nil
        }
    }
}
