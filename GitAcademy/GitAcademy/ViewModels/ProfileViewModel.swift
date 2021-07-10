import UIKit

class ProfileViewModel: NSObject {
    
    private var starredCount: Int?
    
    private var destinationVC = UIViewController()
    
    func getStarredCount(for currentVC: UIViewController) -> Int {
        destinationVC = currentVC
        print("📣  !")
        
        if let destVC = destinationVC as? ProfileViewController {
            destVC.starredCount = 88
            destVC.starredCountIsLoaded = true
        }
        return 88
    }
    
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
                self.starredCount = nil
            }
        }
    }
}
