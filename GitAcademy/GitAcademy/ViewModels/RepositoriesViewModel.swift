import Foundation

class RepositoriesViewModel: NSObject {
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
                self.fetchContibutors(for: repos[0])
                
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
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
