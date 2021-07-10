import Foundation

class ProfileViewModel: NSObject {
    
    func fetchStarred() {
        Core.apiManager.fetchStarred { result in
            switch result {
            case .success(let starred):
                print("🟢🟢🟢 Fetch Starred success !")
                print("🟢🟢🟢 Starred count: \(starred.count)")
                print("🟢🟢🟢 1st Starred description: \(starred[0].description)")
                Core.accountManager.profile?.starredRepositories = starred
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
}
