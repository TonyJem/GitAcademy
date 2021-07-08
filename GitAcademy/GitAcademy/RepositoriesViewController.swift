import UIKit

class RepositoriesViewController: UIViewController {
    @IBOutlet private weak var repositoriesTableView: UITableView!
    
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

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryDetailsCell.self), for: indexPath) as? RepositoryDetailsCell else { return UITableViewCell() }
        return cell
    }
}

extension RepositoriesViewController: UITableViewDelegate {
}
