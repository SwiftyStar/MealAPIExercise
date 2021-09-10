//
//  

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CategoryCell"
    
    private let viewModel = CategoryCellViewModel()
    private let horizontalPadding: CGFloat = 16
    
    private var imageHeight: CGFloat {
        UIScreen.main.bounds.width - 2 * self.horizontalPadding
    }
    
    private let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.categoryImage)
        self.categoryImage.translatesAutoresizingMaskIntoConstraints = false
        self.categoryImage
            .topAnchor
            .constraint(equalTo: self.contentView.topAnchor, constant: 8)
            .isActive = true
        self.categoryImage
            .leadingAnchor
            .constraint(equalTo: self.contentView.leadingAnchor, constant: self.horizontalPadding)
            .isActive = true
        self.categoryImage
            .trailingAnchor
            .constraint(equalTo: self.contentView.trailingAnchor, constant: -self.horizontalPadding)
            .isActive = true
        self.categoryImage
            .heightAnchor
            .constraint(equalToConstant: self.imageHeight)
            .isActive = true
        
        self.contentView.addSubview(self.loadingView)
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.loadingView
            .leadingAnchor
            .constraint(equalTo: self.categoryImage.leadingAnchor)
            .isActive = true
        self.loadingView
            .topAnchor
            .constraint(equalTo: self.categoryImage.topAnchor)
            .isActive = true
        self.loadingView
            .trailingAnchor
            .constraint(equalTo: self.categoryImage.trailingAnchor)
            .isActive = true
        self.loadingView
            .bottomAnchor
            .constraint(equalTo: self.categoryImage.bottomAnchor)
            .isActive = true
        
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel
            .topAnchor
            .constraint(equalTo: self.categoryImage.bottomAnchor, constant: 12)
            .isActive = true
        self.nameLabel
            .leadingAnchor
            .constraint(equalTo: self.contentView.leadingAnchor, constant: self.horizontalPadding)
            .isActive = true
        self.nameLabel
            .trailingAnchor
            .constraint(equalTo: self.contentView.trailingAnchor, constant: -self.horizontalPadding)
            .isActive = true
        
        self.contentView.addSubview(self.descriptionLabel)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel
            .leadingAnchor
            .constraint(equalTo: self.nameLabel.leadingAnchor)
            .isActive = true
        self.descriptionLabel
            .trailingAnchor
            .constraint(equalTo: self.nameLabel.trailingAnchor)
            .isActive = true
        self.descriptionLabel
            .topAnchor
            .constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4)
            .isActive = true
        self.descriptionLabel
            .bottomAnchor
            .constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8)
            .isActive = true
    }
    
    func configure(with category: Category?) {
        self.nameLabel.text = self.viewModel.getName(for: category)
        self.descriptionLabel.text = self.viewModel.getDescription(for: category)
        
        self.viewModel.downloadImage(for: category) { [weak self] image in
            self?.categoryImage.image = image
            self?.loadingView.removeFromSuperview()
        }
    }
}
