// TODO: Find out if it is necessary to wathc out when Token is expiring and refresh it before;
// TODO: Prevent fetching pictures if it is already was loaded, may be is possible to use some kind of frameworks to chash it;
// TODO: Remove testAvatar image from assets while not needed;
// TODO: Make all related to API and Networking separated in API folder;
// TODO: Check naming convention for Enums;
// TODO: Change to Codable while used both: Decodable and Encodable

import Foundation

struct Core {
    static var accountManager = AccountManager()
}
