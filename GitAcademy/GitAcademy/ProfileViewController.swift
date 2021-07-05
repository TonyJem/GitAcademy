import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileTableView: UITableView!
    
    private let numberOfSections = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.register(UINib(nibName: String(describing: ProfileCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: ProfileCell.self))
        
        profileTableView.register(UINib(nibName: String(describing: RepositoryCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RepositoryCell.self))
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.tableFooterView = UIView()
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Profile"
        case 1:
            return "Repositories"
        default:
            return nil
        }
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

extension ProfileViewController: UITableViewDelegate {
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
