import UIKit

class RepositoriesViewController: UIViewController {
    @IBOutlet private weak var repositoriesTableView: UITableView!
    
    var repositories: [Repository]?
    
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
            case .success(let repos):
                print("🟢🟢 Fetch Repositories success !")
                print("🟢🟢 Repositories count: \(repos.count)")
                
                print("🟢🟢 1st Repo Owner's Username: \(repos[0].owner.username)")
                print("🟢🟢 1st Repo Owner's AvatarURL: \(repos[0].owner.avatarURL)")
                print("🟢🟢 1st Repo Name: \(String(describing: repos[0].name))")
                print("🟢🟢 1st Repo Description: \(String(describing: repos[0].description))")
                print("🟢🟢 1st Repo Stars: \(repos[0].stargazersCount)")
                print("🟢🟢 1st Repo Language: \(String(describing: repos[0].language))")
                
                Core.accountManager.profile?.repositories = repos
                
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
}

// MARK: - TableView DataSource
extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryDetailsCell.self), for: indexPath) as? RepositoryDetailsCell else { return UITableViewCell() }
        return cell
    }
}

// MARK: - TableView Delegate
extension RepositoriesViewController: UITableViewDelegate {
}
