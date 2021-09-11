//
//  

import UIKit

final class CategoriesViewController: BaseViewController {
    private let viewModel = CategoriesViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.loadContent()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = kCategories
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView
            .leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
            .isActive = true
        self.tableView
            .trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
            .isActive = true
        self.tableView
            .topAnchor
            .constraint(equalTo: self.view.topAnchor)
            .isActive = true
        self.tableView
            .bottomAnchor
            .constraint(equalTo: self.view.bottomAnchor)
            .isActive = true
    }
    
    private func loadContent() {
        self.showActivityIndicator()
        self.viewModel.getContent { [weak self] error in
            self?.hideActivityIndicator()
            
            if let error = error {
                print(error.localizedDescription) // Handle error
            } else {
                self?.tableView.reloadData()
            }
        }
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as! CategoryTableViewCell
        
        let category = self.viewModel.getCategory(for: indexPath)
        cell.configure(with: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        guard let category = self.viewModel.getCategory(for: indexPath) else { return }
        
        let mealCollectionController = MealCollectionViewController(category: category)
        self.navigationController?.pushViewController(mealCollectionController, animated: true)
    }
}
