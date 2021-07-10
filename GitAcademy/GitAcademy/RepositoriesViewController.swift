import UIKit

class RepositoriesViewController: UIViewController {
    @IBOutlet private weak var repositoriesTableView: UITableView!
    
    var repositories: [Repository] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchRepositories()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Repositories"
        repositoriesTableView.register(UINib(nibName: String(describing: RepositoryDetailsCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RepositoryDetailsCell.self))
        repositoriesTableView.backgroundColor = .systemGray5
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        repositoriesTableView.tableFooterView = UIView()
    }
}

// MARK: - Private Methods
private extension RepositoriesViewController {
    func fetchRepositories() {
        Core.apiManager.fetchRepositories { result in
            switch result {
            case .success(let repositories):
                print("🟢🟢 Fetch Repositories success !")
                
                Core.accountManager.profile?.repositories = repositories
                self.repositories = repositories
                self.repositoriesTableView.reloadData()
                
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
}

// MARK: - TableView DataSource
extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryDetailsCell.self), for: indexPath) as? RepositoryDetailsCell else { return UITableViewCell() }
        
        let repository = repositories[indexPath.row]
        cell.fillContent(for: repository)
        return cell
    }
}

// MARK: - TableView Delegate
extension RepositoriesViewController: UITableViewDelegate {
}
