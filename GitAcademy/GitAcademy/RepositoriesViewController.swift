import UIKit

class RepositoriesViewController: UIViewController {
    
    @IBOutlet private weak var repositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Repositories"
        repositoriesTableView.backgroundColor = .systemGray5
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        repositoriesTableView.tableFooterView = UIView()
    }
}

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    
}
