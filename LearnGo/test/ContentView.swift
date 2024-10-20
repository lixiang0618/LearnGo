//
//  ContentView.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var message = ""
    @State private var messages: [String] = []

    var body: some View {
        VStack {
            List(messages, id: \.self) { msg in
                Text(msg)
            }

            HStack {
                TextField("请输入消息", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("发送") {
                    sendMessage()
                }
                .padding()
            }
            .padding()
        }
    }

    func sendMessage() {
        let userMessage = message
        messages.append("我: \(userMessage)")

        // 调用API
        guard let url = URL(string: "https://api.fastgpt.in/api/v1/chat/completions") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // 设置请求体
        let body: [String: Any] = [
            "messages": [["content": userMessage, "role": "user"]]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Error: Unable to encode JSON")
            return
        }

        // 设置请求头
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer fastgpt-isJBrqjGOTcyRWFWyKt99kZPfDfzum503Xp9nCRpY3WA0sS8MsBvxq", forHTTPHeaderField: "Authorization")

        // 发送请求
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: No data received")
                return
            }

            // 打印响应的原始数据
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }

            // 尝试解码响应
            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    if let content = apiResponse.choices.first?.message.content {
                        messages.append("助手: \(content)")
                    }
                }
            } catch {
                print("Error: Unable to decode JSON response")
            }
        }.resume()
    }
}

// 定义 APIResponse 结构体
//struct APIResponse: Decodable {
//    struct Choice: Decodable {
//        struct Message: Decodable {
//            let content: String
//        }
//        let message: Message
//    }
//    let choices: [Choice]
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

