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
                print("🟢🟢 Repositories count: \(repositories.count)")
                
                print("🟢🟢 1st Repo Owner's Username: \(repositories[0].owner.username)")
                print("🟢🟢 1st Repo Owner's AvatarURL: \(repositories[0].owner.avatarURL)")
                print("🟢🟢 1st Repo Name: \(String(describing: repositories[0].name))")
                print("🟢🟢 1st Repo Description: \(String(describing: repositories[0].description))")
                print("🟢🟢 1st Repo Stars: \(repositories[0].stargazersCount)")
                print("🟢🟢 1st Repo Language: \(String(describing: repositories[0].language))")
                
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
