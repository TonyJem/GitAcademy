import UIKit

class ProfileViewModel: NSObject {
    
    private var starredCount: Int?
    
    func getStarredCount() -> Int {
        return 0
    }
    
    func fetchStarred() {
        Core.apiManager.fetchStarred { result in
            switch result {
            case .success(let starred):
                print("🟢🟢🟢 Fetch Starred success !")
                print("🟢🟢🟢 Starred count: \(starred.count)")
                print("🟢🟢🟢 1st Starred description: \(starred[0].description)")
                Core.accountManager.profile?.starredRepositories = starred
                
                if let vc = UIApplication.shared.topMostViewController() as? ProfileViewController {
                    vc.starredCount = starred.count
                    vc.starredCountIsLoaded = true
                }
                
            case .failure(let error):
                print("🔴 \(error)")
                self.starredCount = nil
            }
        }
    }
}
