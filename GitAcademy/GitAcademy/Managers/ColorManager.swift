import Foundation

struct ColorManager {
    private let colorsFile = "colors"
    
    lazy var colors: [String: AnyObject]? = {
        return loadColorsDictionary(filename: colorsFile)
    }()
}

// MARK: - Private methods
private extension ColorManager {
    func loadColorsDictionary(filename fileName: String) -> [String: AnyObject]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    return dictionary
                }
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        return nil
    }
}
