// TODO: Remove "selection" while clicking on cells in Profile Table View
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileTableView: UITableView!
    
    private let numberOfSections = 2
    private let numberOfRowsInSectionProfile = 1
    private let numberOfRowsInSectionRepositories = 2
    private let repositoriesViewController = RepositoriesViewController(nibName: "RepositoriesViewController", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.register(UINib(nibName: String(describing: ProfileCell.self), bundle: Bundle.main),
                                  forCellReuseIdentifier: String(describing: ProfileCell.self))
        
        profileTableView.register(UINib(nibName: String(describing: RepositoryCell.self), bundle: Bundle.main),
                                  forCellReuseIdentifier: String(describing: RepositoryCell.self))
        
        profileTableView.backgroundColor = .systemGray5
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.tableFooterView = UIView()
        
        // TODO: Make sure to have a "Log Out" button only on "Main Screen", on other screens should be regula "Back" button
        let logoutButton = UIBarButtonItem(
            title: "Log Out", style: .plain,
            target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
    }
    
    @objc private func logout() {
        SceneDelegate.shared.rootViewController.navigateToLoginScreenAnimated()
    }
}

private extension ProfileViewController {
    private func profileCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: ProfileCell.self), for: indexPath) as? ProfileCell else { return UITableViewCell() }
        cell.fillContent()
        return cell
    }
    
    private func repositoryCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self), for: indexPath) as? RepositoryCell else { return UITableViewCell() }
        indexPath.row == 0 ? cell.fillRepositories() : cell.fillStarred()
        return cell
    }
}

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
