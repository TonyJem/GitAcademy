// TODO: Find out if it is necessary to wathc out when Token is expiring and refresh it before;
// TODO: Prevent fetching pictures if it is already was loaded, may be is possible to use some kind of frameworks to chash it;
// TODO: Remove testAvatar image from assets while not needed;

import Foundation

struct Core {
    static var accountManager = AccountManager()
}
