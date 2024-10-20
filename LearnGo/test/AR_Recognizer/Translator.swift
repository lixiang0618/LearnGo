import Foundation

struct TranslationEntry: Decodable {
    let simplified: String
    let traditional: String
    let pinyin: String
    let translation: String
}

struct Translator {
    private let translations: [String: (String, String)] // 存储英文到中文的映射
    
    init(jsonFileName: String) {
        self.translations = Translator.loadTranslations(from: jsonFileName)
    }

    private static func loadTranslations(from jsonFileName: String) -> [String: (String, String)] {
        guard let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else {
            return [:]
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let entries = try decoder.decode([TranslationEntry].self, from: data)
            // 将英文翻译作为键，简体和繁体中文作为值存储
            return entries.reduce(into: [String: (String, String)]()) { result, entry in
                result[entry.translation] = (entry.simplified, entry.traditional)
            }
        } catch {
            print("Error loading translations: \(error)")
            return [:]
        }
    }

    // 根据英文翻译查找对应的中文翻译
    func translate(from english: String) -> (String, String) {
        return translations[english, default: ("未找到简体", "未找到繁体")]
    }
    
    // 根据多个英文翻译查找对应的中文翻译
    func translateMultiple(from englishList: [String]) -> [(String, String)] {
        return englishList.map { translate(from: $0) }
    }
}
