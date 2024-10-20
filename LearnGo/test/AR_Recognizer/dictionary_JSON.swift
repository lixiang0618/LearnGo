//
//  dictionary_JSON.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/19.
//

import Foundation

// 定义词条结构体
struct CCEdictEntry: Codable {
    let traditional: String
    let simplified: String
    let pinyin: String
    let definitions: [String]
}

// 解析 CC-CEDICT 文件
func parseCCEDICT(filePath: String) -> [CCEdictEntry]? {
    guard let content = try? String(contentsOfFile: filePath, encoding: .utf8) else {
        print("无法读取文件内容")
        return nil
    }
    
    var entries: [CCEdictEntry] = []
    
    let lines = content.split(separator: "\n")
    for line in lines {
        // 忽略注释和元数据行
        if line.starts(with: "#") {
            continue
        }
        
        // 分割词条的内容
        let parts = line.split(separator: " ", maxSplits: 2, omittingEmptySubsequences: true)
        guard parts.count >= 3 else {
            continue
        }
        
        let traditional = String(parts[0]) // 繁体
        let simplified = String(parts[1])  // 简体
        let rest = String(parts[2])
        
        // 提取拼音和释义
        guard let pinyinStart = rest.firstIndex(of: "["), let pinyinEnd = rest.firstIndex(of: "]") else {
            continue
        }
        
        let pinyin = String(rest[pinyinStart...pinyinEnd].dropFirst().dropLast())
        let definitions = rest[pinyinEnd...].dropFirst().split(separator: "/").map { String($0) }
        
        // 构造词典项
        let entry = CCEdictEntry(traditional: traditional, simplified: simplified, pinyin: pinyin, definitions: definitions)
        entries.append(entry)
    }
    
    return entries
}

// 将词条转换为 JSON 格式并保存
func saveToJSON(entries: [CCEdictEntry], outputPath: String) {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    
    do {
        let jsonData = try jsonEncoder.encode(entries)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            try jsonString.write(toFile: outputPath, atomically: true, encoding: .utf8)
            print("转换完成，已保存为 \(outputPath) 文件")
        }
    } catch {
        print("JSON 转换失败：\(error)")
    }
}

// 示例使用
//let inputFilePath = "/path/to/your/cedict_ts.u8" // 替换为实际文件路径
//let outputFilePath = "/path/to/output/cc_cedict.json" // 输出文件路径
//
//if let entries = parseCCEDICT(filePath: inputFilePath) {
//    saveToJSON(entries: entries, outputPath: outputFilePath)
//} else {
//    print("无法解析文件内容")
//}
