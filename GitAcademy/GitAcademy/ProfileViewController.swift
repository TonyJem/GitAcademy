// TODO: Remove "cell selection" while clicking on cells in Profile Table View
// TODO: Learn and Refactor to move functionality to ViewModel
import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileTableView: UITableView!
    
    // TODO: May possible to set User via init while creating ProfileViewController ?
    var user: User?
    var isMainScreen = false
    
    private let numberOfSections = 2
    private let numberOfRowsInSectionProfile = 1
    private let numberOfRowsInSectionRepositories = 2
    private let repositoriesViewController = RepositoriesViewController(nibName: "RepositoriesViewController", bundle: nil)
    
    // TODO: Setup Laoding indicator while fetchnig starred repos
    var starredCountIsLoaded = false {
        didSet {
            if starredCountIsLoaded {
                print("🟢🟢🟢🟢 starredCount did Update to: \(starredCount)")
            }
        }
    }
    
    var starredCount = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchStarred()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.register(UINib(nibName: String(describing: ProfileCell.self), bundle: Bundle.main),
                                  forCellReuseIdentifier: String(describing: ProfileCell.self))
        profileTableView.register(UINib(nibName: String(describing: RepositoryCell.self), bundle: Bundle.main),
                                  forCellReuseIdentifier: String(describing: RepositoryCell.self))
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableFooterView = UIView()
        profileTableView.backgroundColor = .systemGray5
        
        if isMainScreen {
            let logoutButton = UIBarButtonItem(
                title: "Log Out", style: .plain,
                target: self, action: #selector(logout))
            navigationItem.setLeftBarButton(logoutButton, animated: true)
        }
    }
    
    @objc private func logout() {
        SceneDelegate.shared.rootViewController.navigateToLoginScreenAnimated()
    }
}

// MARK: - Private methods
private extension ProfileViewController {
    func profileCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: ProfileCell.self), for: indexPath) as? ProfileCell,
              let user = user else {
            return UITableViewCell()
        }
        cell.fillContent(for: user)
        return cell
    }
    
    func repositoryCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self), for: indexPath) as? RepositoryCell,
              let user = user else {
            return UITableViewCell()
        }
        indexPath.row == 0 ? cell.fillRepositories(with: user.publicReposCount) : cell.fillStarred(with: starredCount)
        return cell
    }
    
    func fetchStarred() {
        Core.apiManager.fetchStarred { result in
            switch result {
            case .success(let starred):
                print("🟢🟢🟢 Fetch Starred success !")
                Core.accountManager.profile?.starredRepositories = starred
                self.starredCount = starred.count
                self.starredCountIsLoaded = true
                
                let index = IndexPath(row: 1, section: 1)
                self.profileTableView.reloadRows(at: [index], with: .automatic)
                
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
}

// MARK: - TableView Data Source
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return numberOfRowsInSectionProfile
        case 1:
            return numberOfRowsInSectionRepositories
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return profileCell(for: indexPath)
        case 1:
            return repositoryCell(for: indexPath)
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - TableView Delegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        switch indexPath.row {
        case 0:
            print("🟢 Did select Repo row")
            navigationController?.pushViewController(repositoriesViewController, animated: true)
        case 1:
            print("🟢 Did select Starred row")
        default:
            break
        }
    }
}
