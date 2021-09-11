//
//  

import UIKit
import SafariServices

final class MealDetailsViewController: BaseViewController {
    private let viewModel: MealDetailsViewModel
    private let buttonHeight: CGFloat = 42
    private let sidePadding: CGFloat = 16
    
    private let scrollView = UIScrollView()
    private let scrollingContentView = UIView()
 
    private var imageHeight: CGFloat {
        UIScreen.main.bounds.width - 2 * self.sidePadding
    }
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loadingView: UIActivityIndicatorView =  {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.isHidden = true
        return indicator
    }()
    
    private lazy var webButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemTeal
        button.setTitle(kWebsite, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.layer.cornerRadius = self.buttonHeight / 2
        button
            .heightAnchor
            .constraint(equalToConstant: self.buttonHeight)
            .isActive = true
        return button
    }()
    
    private lazy var youtubeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle(kYoutube, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.layer.cornerRadius = self.buttonHeight / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button
            .heightAnchor
            .constraint(equalToConstant: self.buttonHeight)
            .isActive = true
        
        return button
    }()
    
    private let buttonContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 32
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let ingredientsContainerView = UIView()
    private let instructionsContainerView = UIView()
    
    init(meal: Meal) {
        self.viewModel = MealDetailsViewModel(meal: meal)
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
        
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView
            .topAnchor
            .constraint(equalTo: self.view.topAnchor)
            .isActive = true
        self.scrollView
            .leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
            .isActive = true
        self.scrollView
            .trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
            .isActive = true
        self.scrollView
            .bottomAnchor
            .constraint(equalTo: self.view.bottomAnchor)
            .isActive = true
        
        self.scrollView.addSubview(self.scrollingContentView)
        self.scrollingContentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollingContentView
            .topAnchor
            .constraint(equalTo: self.scrollView.topAnchor)
            .isActive = true
        self.scrollingContentView
            .leadingAnchor
            .constraint(equalTo: self.scrollView.leadingAnchor)
            .isActive = true
        self.scrollingContentView
            .trailingAnchor
            .constraint(equalTo: self.scrollView.trailingAnchor)
            .isActive = true
        self.scrollingContentView
            .bottomAnchor
            .constraint(equalTo: self.scrollView.bottomAnchor)
            .isActive = true
        self.scrollingContentView
            .widthAnchor
            .constraint(equalToConstant: UIScreen.main.bounds.width)
            .isActive = true
        
        self.scrollingContentView.addSubview(self.mealImageView)
        self.mealImageView.translatesAutoresizingMaskIntoConstraints = false
        self.mealImageView
            .topAnchor
            .constraint(equalTo: self.scrollingContentView.topAnchor, constant: self.sidePadding)
            .isActive = true
        self.mealImageView
            .leadingAnchor
            .constraint(equalTo: self.scrollingContentView.leadingAnchor, constant: self.sidePadding)
            .isActive = true
        self.mealImageView
            .trailingAnchor
            .constraint(equalTo: self.scrollingContentView.trailingAnchor, constant: -self.sidePadding)
            .isActive = true
        self.mealImageView
            .heightAnchor
            .constraint(equalToConstant: self.imageHeight)
            .isActive = true
        
        self.scrollingContentView.addSubview(self.loadingView)
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
        
        self.scrollingContentView.addSubview(self.buttonContainerView)
        self.buttonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.buttonContainerView
            .topAnchor
            .constraint(equalTo: self.mealImageView.bottomAnchor, constant: 12)
            .isActive = true
        self.buttonContainerView
            .leadingAnchor
            .constraint(equalTo: self.scrollingContentView.leadingAnchor, constant: self.sidePadding)
            .isActive = true
        self.buttonContainerView
            .trailingAnchor
            .constraint(equalTo: self.scrollingContentView.trailingAnchor, constant: -self.sidePadding)
            .isActive = true
        
        self.scrollingContentView.addSubview(self.ingredientsContainerView)
        self.ingredientsContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientsContainerView
            .topAnchor
            .constraint(equalTo: self.buttonContainerView.bottomAnchor, constant: 12)
            .isActive = true
        self.ingredientsContainerView
            .leadingAnchor
            .constraint(equalTo: self.scrollingContentView.leadingAnchor, constant: self.sidePadding)
            .isActive = true
        self.ingredientsContainerView
            .trailingAnchor
            .constraint(equalTo: self.scrollingContentView.trailingAnchor, constant: -self.sidePadding)
            .isActive = true
        
        self.scrollingContentView.addSubview(self.instructionsContainerView)
        self.instructionsContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.instructionsContainerView
            .topAnchor
            .constraint(equalTo: self.ingredientsContainerView.bottomAnchor, constant: 12)
            .isActive = true
        self.instructionsContainerView
            .leadingAnchor
            .constraint(equalTo: self.scrollingContentView.leadingAnchor, constant: self.sidePadding)
            .isActive = true
        self.instructionsContainerView
            .trailingAnchor
            .constraint(equalTo: self.scrollingContentView.trailingAnchor, constant: -self.sidePadding)
            .isActive = true
        self.instructionsContainerView
            .bottomAnchor
            .constraint(equalTo: self.scrollingContentView.bottomAnchor, constant: -self.sidePadding)
            .isActive = true
    }
    
    private func loadContent() {
        self.showActivityIndicator()
        self.viewModel.getContent { [weak self] error in
            self?.hideActivityIndicator()
            
            if let error = error {
                print(error.localizedDescription) // Handle error
            } else {
                self?.configure()
            }
        }
    }
    
    private func configure() {
        self.addButtons()
        self.addIngredients()
        self.addInstructions()
        self.downloadImage()
    }
    
    private func addButtons() {
        if self.viewModel.getSourceURL() != nil {
            self.webButton.addTarget(self, action: #selector(self.websiteButtonTapped), for: .touchUpInside)
            self.buttonContainerView.addArrangedSubview(self.webButton)
        }
        
        if self.viewModel.getYoutubeURL() != nil {
            self.youtubeButton.addTarget(self, action: #selector(self.youtubeButtonTapped), for: .touchUpInside)
            self.buttonContainerView.addArrangedSubview(self.youtubeButton)
        }
    }
    
    @objc
    private func websiteButtonTapped() {
        guard let sourceURL = self.viewModel.getSourceURL() else { return }
 
        let safariController = SafariViewController(url: sourceURL)
        self.present(safariController, animated: true)
    }
    
    @objc
    private func youtubeButtonTapped() {
        guard let youtubeURL = self.viewModel.getYoutubeURL() else { return }
        
        let safariController = SafariViewController(url: youtubeURL)
        self.present(safariController, animated: true)
    }
    
    private func addIngredients() {
        let ingredients = self.viewModel.getIngredients()
        guard !ingredients.isEmpty else { return }
        
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = kIngredients
        ingredientsLabel.font = .preferredFont(forTextStyle: .title1)
        
        self.ingredientsContainerView.addSubview(ingredientsLabel)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel
            .topAnchor
            .constraint(equalTo: self.ingredientsContainerView.topAnchor)
            .isActive = true
        ingredientsLabel
            .leadingAnchor
            .constraint(equalTo: self.ingredientsContainerView.leadingAnchor)
            .isActive = true
        ingredientsLabel
            .trailingAnchor
            .constraint(equalTo: self.ingredientsContainerView.trailingAnchor)
            .isActive = true
        
        let ingredientsStackView = UIStackView()
        ingredientsStackView.axis = .vertical
        ingredientsStackView.alignment = .leading
        ingredientsStackView.spacing = 8
        
        self.ingredientsContainerView.addSubview(ingredientsStackView)
        ingredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsStackView
            .topAnchor
            .constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 12)
            .isActive = true
        ingredientsStackView
            .leadingAnchor
            .constraint(equalTo: self.ingredientsContainerView.leadingAnchor)
            .isActive = true
        ingredientsStackView
            .trailingAnchor
            .constraint(equalTo: self.ingredientsContainerView.trailingAnchor)
            .isActive = true
        ingredientsStackView
            .bottomAnchor
            .constraint(equalTo: self.ingredientsContainerView.bottomAnchor)
            .isActive = true
        
        ingredients.forEach { ingredient in
            let text = "\(kBullet) \(ingredient.measurement) \(ingredient.name)"
            let label = UILabel()
            label.font = .preferredFont(forTextStyle: .body)
            label.text = text
            ingredientsStackView.addArrangedSubview(label)
        }
    }
    
    private func addInstructions() {
        guard let instructions = self.viewModel.getInstructions() else { return }
        
        let instructionsTitleLabel = UILabel()
        instructionsTitleLabel.font = .preferredFont(forTextStyle: .title1)
        instructionsTitleLabel.text = kInstructions
        
        self.instructionsContainerView.addSubview(instructionsTitleLabel)
        instructionsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsTitleLabel
            .topAnchor
            .constraint(equalTo: self.instructionsContainerView.topAnchor)
            .isActive = true
        instructionsTitleLabel
            .leadingAnchor
            .constraint(equalTo: self.instructionsContainerView.leadingAnchor)
            .isActive = true
        instructionsTitleLabel
            .trailingAnchor
            .constraint(equalTo: self.instructionsContainerView.trailingAnchor)
            .isActive = true
        
        let instructionsLabel = UILabel()
        instructionsLabel.font = .preferredFont(forTextStyle: .body)
        instructionsLabel.text = instructions
        instructionsLabel.numberOfLines = 0
        
        self.instructionsContainerView.addSubview(instructionsLabel)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel
            .topAnchor
            .constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 12)
            .isActive = true
        instructionsLabel
            .leadingAnchor
            .constraint(equalTo: self.instructionsContainerView.leadingAnchor)
            .isActive = true
        instructionsLabel
            .trailingAnchor
            .constraint(equalTo: self.instructionsContainerView.trailingAnchor)
            .isActive = true
        instructionsLabel
            .bottomAnchor
            .constraint(equalTo: self.instructionsContainerView.bottomAnchor)
            .isActive = true
    }
    
    private func downloadImage() {
        self.loadingView.startAnimating()
        self.loadingView.isHidden = false
        self.viewModel.downloadImage { [weak self] image in
            self?.loadingView.stopAnimating()
            self?.loadingView.removeFromSuperview()
            self?.mealImageView.image = image // ?? defaultImage, or display some other view when nil
        }
    }
}
