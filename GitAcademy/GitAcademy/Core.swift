// TODO: Find out if it is necessary to wathc out when Token is expiring and refresh it before;
// TODO: Prevent fetching pictures if it is already was loaded, may be is possible to use some kind of frameworks to chash it;
// TODO: Make all related to API and Networking separated in API folder
// TODO: Put "normal" colors to each screen element
// TODO: Prevent jumping from Login to GithubWeb and back to Loginscreen while authentificatin via GitHub

import Foundation

struct Core {
    static var accountManager = AccountManager()
}
