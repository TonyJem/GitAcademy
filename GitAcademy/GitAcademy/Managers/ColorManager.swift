import UIKit

struct ColorManager {
    private let colorsFile = "colors"
    
    lazy var colors: [String: String]? = {
        
        var dictionary = loadColorsDictionary(filename: colorsFile)
        print("🟩 Colors dictionary lazyVar: \(String(describing: dictionary))")
        print("🟩 Swift color from lazyVar: \(String(dictionary!["Swift"]!))")
        return dictionary
    }()
    
    mutating func selectColor(for language: String) -> UIColor {
        
        guard let colors = colors,
              let color = colors[language] else {
            return hexStringToUIColor(hex: "#ffac45")
        }
        print("🔶 Selected language's color String is: \(color)" )
        return hexStringToUIColor(hex: "#ffac45")
    }
}

// MARK: - Private methods
private extension ColorManager {
    func loadColorsDictionary(filename fileName: String) -> [String: String]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: String] {
                    return dictionary
                }
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        return nil
    }
    
    func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        guard cString.count != 6 else {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
