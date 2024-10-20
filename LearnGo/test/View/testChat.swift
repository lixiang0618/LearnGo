//
//  testChat.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/9/26.
//

//import SwiftUI
//
//struct TestChatView: View {
//    @State private var message: String = ""
//    @State private var messages: [Message] = []
//    @State private var isLoading: Bool = false  // 接受消息时显示进度指示器
//    @State private var scrollViewProxy: ScrollViewProxy? = nil
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                ZStack {
//                    // 暖色调渐变背景
//                    LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.5), Color.yellow.opacity(0.3)]),
//                                   startPoint: .topLeading,
//                                   endPoint: .bottomTrailing)
//                        .ignoresSafeArea()
//
//                    VStack {
//                        ScrollViewReader { proxy in
//                            ScrollView {
//                                VStack(spacing: 10) {
//                                    ForEach(messages) { msg in
//                                        HStack {
//                                            if msg.isUser {
//                                                Spacer()
//                                                Text(msg.content)
//                                                    .padding()
//                                                    .background(Color.orange)
//                                                    .cornerRadius(15)
//                                                    .foregroundColor(.white)
//                                                    .frame(maxWidth: .infinity, alignment: .trailing)
//                                                    .transition(.move(edge: .trailing).combined(with: .opacity))
//                                            } else {
//                                                Text(try! AttributedString(markdown: msg.content))
//                                                    .padding()
//                                                    .background(Color.red.opacity(0.2))
//                                                    .cornerRadius(15)
//                                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                                    .transition(.move(edge: .leading).combined(with: .opacity))
//                                                Spacer()
//                                            }
//                                        }
//                                        .padding(.horizontal)
//                                        .id(msg.id)
//                                    }
//                                    // 显示进度指示器等待动画
//                                    if isLoading {
//                                        ProgressView("等待中...")
//                                            .padding()
//                                            .transition(.opacity)
//                                    }
//                                }
//                                .onAppear {
//                                    scrollViewProxy = proxy
//                                    loadMessages() // 加载历史消息
//                                }
//                            }
//                            .onChange(of: messages) { _ in
//                                withAnimation {
//                                    scrollViewProxy?.scrollTo(messages.last?.id, anchor: .bottom)
//                                }
//                            }
//                        }
//
//                        // 输入框和发送按钮
//                        HStack {
//                            TextField("输入消息", text: $message, onCommit: sendMessage)
//                                .textFieldStyle(PlainTextFieldStyle())
//                                .padding()
//                                .background(Color.red.opacity(0.1))  // 红色调背景
//                                .cornerRadius(15)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .stroke(Color.orange, lineWidth: 2)  // 暖色调边框
//                                )
//                                .padding(.horizontal)
//
//                            Button(action: {
//                                sendMessage()
//                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                            }) {
//                                Image(systemName: "paperplane.fill")
//                                    .font(.system(size: 24))
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .background(Color.orange)
//                                    .clipShape(Circle())
//                            }
//                            .padding()
//                            .transition(.scale) // 发送消息时的丝滑弹出动画
//                        }
//                        .padding(.bottom)
//                    }
//                }
//                .navigationTitle("聊天")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        // 顶部的通知栏
//                        HStack {
//                            Image(systemName: "bell.fill")
//                            Text("通知栏")
//                        }
//                    }
//                }
//            }
//            .tabItem {
//                Label("聊天", systemImage: "message.fill")
//            }
//        }
//        .tabViewStyle(PageTabViewStyle())
//        .navigationViewStyle(StackNavigationViewStyle())
//        .tabView {
//            ChatView()
//                .tabItem {
//                    Label("聊天", systemImage: "message.fill")
//                }
//
//            // “我的”页面
//            ProfileView()
//                .tabItem {
//                    Label("我的", systemImage: "person.fill")
//                }
//        }
//    }
//
//    func sendMessage() {
//        let userMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !userMessage.isEmpty else { return }
//
//        messages.append(Message(content: "我: \(userMessage)", isUser: true))
//        message = ""  // 清空输入框
//        saveMessages() // 保存消息到历史记录
//
//        isLoading = true  // 开启等待动画
//
//        // 调用API
//        guard let url = URL(string: "https://api.fastgpt.in/api/v1/chat/completions") else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let body: [String: Any] = [
//            "messages": [["content": userMessage, "role": "user"]]
//        ]
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: body)
//        } catch {
//            print("Error: Unable to encode JSON")
//            return
//        }
//
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer YOUR_TOKEN_HERE", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let data = data else {
//                print("Error: No data received")
//                return
//            }
//
//            do {
//                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//                DispatchQueue.main.async {
//                    if let content = apiResponse.choices.first?.message.content {
//                        messages.append(Message(content: content, isUser: false))
//                        saveMessages() // 保存消息到历史记录
//                        isLoading = false // 停止等待动画
//                        withAnimation {
//                            scrollViewProxy?.scrollTo(messages.last?.id, anchor: .bottom)
//                        }
//                    }
//                }
//            } catch {
//                print("Error: Unable to decode JSON response")
//            }
//        }.resume()
//    }
//
//    // 加载历史消息
//    private func loadMessages() {
//        if let data = UserDefaults.standard.data(forKey: "messages"),
//           let decodedMessages = try? JSONDecoder().decode([Message].self, from: data) {
//            messages = decodedMessages
//        }
//    }
//
//    // 保存消息到 UserDefaults
//    private func saveMessages() {
//        if let encodedMessages = try? JSONEncoder().encode(messages) {
//            UserDefaults.standard.set(encodedMessages, forKey: "messages")
//        }
//    }
//}
//
//// 消息模型
//struct Message: Identifiable, Equatable, Codable {
//    let id = UUID()
//    let content: String
//    let isUser: Bool
//}
//
//// “我的”视图
//struct ProfileView: View {
//    var body: some View {
//        VStack {
//            Text("这是我的页面")
//                .font(.largeTitle)
//                .padding()
//            Spacer()
//        }
//    }
//}
//
//// 你的 APIResponse 结构体
//struct APIResponse: Codable {
//    struct Choice: Codable {
//        struct Message: Codable {
//            let content: String
//        }
//        let message: Message
//    }
//    let choices: [Choice]
//}
//
//struct Chat_View_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}

