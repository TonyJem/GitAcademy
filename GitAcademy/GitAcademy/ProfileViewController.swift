import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileTableView: UITableView!
    
    private let numberOfSections = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.register(UINib(nibName: String(describing: ProfileCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: ProfileCell.self))
        
        profileTableView.register(UINib(nibName: String(describing: RepositoryCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RepositoryCell.self))
        
        profileTableView.backgroundColor = .systemGray5
        profileTableView.dataSource = self
        profileTableView.tableFooterView = UIView()
        
        title = "Main Screen"
        // TODO: Make sure to have a "Log Out" button only on "Main Screen", on other screens should be regula "Back" button
        let logoutButton = UIBarButtonItem(
            title: "Log Out", style: .plain,
            target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
    }
    
    @objc private func logout() {
        // TODO: Clear the user session (example only, not for the production)
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        // TODO: Navigate to login screen
        SceneDelegate.shared.rootViewController.switchToLogout()
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            // TODO: Magic number
            return 1
        case 1:
            // TODO: Magic number
            return 2
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

private extension ProfileViewController {
    // TODO: Refactor to have one method for different cells
    private func profileCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: ProfileCell.self), for: indexPath) as? ProfileCell else { return UITableViewCell() }
        cell.fillContent()
        return cell
    }
    
    // TODO: Refactor to have one method for different cells
    private func repositoryCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self), for: indexPath) as? RepositoryCell else { return UITableViewCell() }
        indexPath.row == 0 ? cell.fillRepositories() : cell.fillStarred()
        return cell
    }
}
