import Foundation

class RepositoriesViewModel: NSObject {

    func fetchContibutors(for repo: Repository) {
        Core.apiManager.fetchContributors(for: repo, { result in
            switch result {
            case .success(let contributors):
                print("🟣 Fetch Contributors success !")
                print("🟣 Contributors count: \(contributors.count)")
                print("🟣 1st contibutor description: \(contributors[0].username)")
                
            case .failure(let error):
                print("🔴 \(error)")
            }
        })
    }
}
