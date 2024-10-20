//
//  computerInternet.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/9/28.
//

import SwiftUI
import PDFKit

struct computerInternetView: View {
    @State private var message: String = ""
    @State private var messages: [Message] = []
    @State private var isLoading: Bool = false
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    @State private var showingRoomSelection = false  // 控制弹窗显示
    @State private var selectedRoom: String = "聊天室 1" // 当前选择的聊天室
    @State private var selectedFileURL: URL? = nil // 存储选定的文件URL
    @State private var fileText: String = ""
    private var documentPickerDelegate: DocumentPickerDelegate?
    @State private var buttonColor = Color.orange // 默认按钮颜色
//    @StateObject private var speechRecognizer = SpeechRecognizer()
//    var animationNamespace: Namespace.ID
//    var selectedRoom: String

    var body: some View {
//        TabView {
            NavigationView {
                VStack {
                    ZStack {
                        // 暖色调渐变背景
                        LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.5), Color.yellow.opacity(0.3)]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                            .ignoresSafeArea()

                        VStack {
                            ScrollViewReader { proxy in
                                ScrollView {
                                    VStack(spacing: 10) {
                                        ForEach(messages) { msg in
                                            HStack {
                                                if msg.isUser {
                                                    Spacer()
                                                    Text(msg.content)
                                                        .padding()
                                                        .background(Color.orange)
                                                        .cornerRadius(15)
                                                        .foregroundColor(.white)
                                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                                        .transition(.move(edge: .trailing).combined(with: .opacity))
                                                } else {
                                                    Text(try! AttributedString(markdown: msg.content))
                                                        .padding()
                                                        .background(Color.red.opacity(0.2))
                                                        .cornerRadius(15)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .transition(.move(edge: .leading).combined(with: .opacity))
                                                    
                                                    Spacer()
                                                }
                                            }
                                            .padding(.horizontal)
                                            .id(msg.id)
                                        }
                                        if isLoading {
                                            ProgressView("等待中...")
                                                .padding()
                                                .transition(.opacity)
                                        }
                                    }
                                    .onAppear {
                                        scrollViewProxy = proxy
                                        loadMessages(for: "jiwang") // 加载历史消息
                                    }
                                }
                                .onChange(of: messages) { _ in
                                    withAnimation {
                                        scrollViewProxy?.scrollTo(messages.last?.id, anchor: .bottom)
                                    }
                                }
                            }

                            HStack {
                                
                                
                                
                                
                                
                                
//
//                                Button(action: {
//                                                speechRecognizer.startRecording()
//                                            }) {
//                                                Text("Start Voice Recognition")
//                                            }
//
//                                            Button(action: {
//                                                speechRecognizer.stopRecording()
//                                                message = speechRecognizer.recognizedText // 将识别到的文本赋值给 message
//                                            }) {
//                                                Text("Stop Voice Recognition")
//                                            }
                                
                                
                                
                                
                                SpeechRecognitionButton(recognizedText: $message)
                                    .padding(15)
                                
                                
                                
                                
                                
                                
                                Button(action: {
                                    if !fileText.isEmpty {
                                        // 如果已经上传文件，再次点击时弹出确认清除的提示
                                        let alert = UIAlertController(title: "确认清除", message: "您确定要清除已上传的文件吗？", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                                        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { _ in
                                            // 用户确认清除时，将 fileText 置空并恢复按钮颜色
                                            fileText = ""
                                            buttonColor = Color.orange
                                        }))
                                        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                                    } else {
                                        // 没有上传文件时，执行文件选择和处理
                                        PDFReader.shared.selectAndExtractPDFFile { text in
                                            fileText = text
                                            print("我的PDF识别结果为：\(fileText)")

                                            // 文件上传成功后将按钮颜色变为绿色
                                            buttonColor = Color.green
                                            
                                            // 弹窗提示上传成功
                                            let successAlert = UIAlertController(title: "上传成功", message: "PDF 文件已成功识别并上传", preferredStyle: .alert)
                                            successAlert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                                            UIApplication.shared.windows.first?.rootViewController?.present(successAlert, animated: true, completion: nil)
                                        }
                                    }
                                }) {
                                    Image(systemName: "doc.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(buttonColor) // 动态更改按钮颜色
                                        .clipShape(Circle())
                                }
                                .padding(0)
                                .transition(.scale)
                                
                                
                                
                                TextField("输入你的问题...", text: $message, onCommit: { sendMessage(fileText: fileText, fileUrl: selectedFileURL) })
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .disableAutocorrection(true)
                                    .padding()
                                    .background(Color.red.opacity(0.1))  // 红色调背景
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.orange, lineWidth: 2)  // 暖色调边框
                                    )
                                    .padding(.horizontal)
                                
                                

                                Button(action: {
                                    sendMessage(fileText: fileText, fileUrl: selectedFileURL)
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }) {
                                    Image(systemName: "paperplane.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                                }
                                .padding(15)
                                .transition(.scale) // 发送消息时的丝滑弹出动画
                            }
                            .padding(.bottom)
                        }
                    }
//                    .toolbar{
//                        ToolbarItem(placement: .principal) {
//                            Text(selectedRoom)
//                                .font(.largeTitle)
//                                .foregroundColor(.black)
//                        }
//                    }
                    
                    .navigationTitle("计算机网络课程助手") // 直接显示聊天室名称，不再通过选项
//                    .navigationTitle("")
//                    .matchedGeometryEffect(id: "chatroom1", in: animationNamespace, isSource: true)
                    .navigationBarTitleDisplayMode(.inline) // 设置为内联模式
                    
//                    .toolbar {
//                        ToolbarItem(placement: .principal) {
//                            Text("博弈论课程助手") // 自定义标题
//                                .font(.title2) // 自定义字体大小
////                                .foregroundColor(.orange) // 自定义字体颜色
//                                .bold() // 加粗
//                        }
//                    }
                    
                }
            }
//            .tabItem {
//                Label("聊天", systemImage: "message.fill")
//            }
//
//
//            SuperNote()
//                .tabItem {
//                    Label("超级笔记", systemImage: "pencil.and.outline")
//                }
//
//
//
//            SettingNewView()
//                .tabItem {
//                    Label("我的", systemImage: "person.fill")
//                }
//
//
//        }
        .edgesIgnoringSafeArea(.all)
//        .navigationBarHidden(true)
    }


    func sendMessage(fileText: String?, fileUrl: URL?) {
        let userMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userMessage.isEmpty else { return }

        // 将原始用户消息添加到UI界面中
        messages.append(Message(content: userMessage, isUser: true))
        message = ""  // 清空输入框
        saveMessages(for: "jiwang") // 保存消息到历史记录

        // 准备发送给API的组合消息
        let combinedMessage = "我要求你参照我提供的文件内容（内容为空时则由你自己来回答）来回答我问题。这是我的问题：‘’‘\(userMessage)’‘’。这是我的文件内容：‘’‘\(fileText ?? "")’‘’"

        var contentArray: [[String: Any]] = [
            ["type": "text", "text": combinedMessage]
        ]

        // 如果有文件 URL，将文件信息添加到消息内容中
        if let fileUrl = fileUrl {
            let fileName = fileUrl.lastPathComponent
            let fileContent: [String: Any] = [
                "type": "file_url",
                "name": fileName,
                "url": fileUrl.absoluteString
            ]
            contentArray.append(fileContent)
        }

        isLoading = true  // 开启等待动画

        guard let url = URL(string: "https://api.fastgpt.in/api/v1/chat/completions") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body: [String: Any] = [
            "messages": [["role": "user", "content": contentArray]]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Error: Unable to encode JSON")
            return
        }

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\\ Your Key on FastGPT", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: No data received")
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    if let content = apiResponse.choices.first?.message.content {
                        messages.append(Message(content: content, isUser: false))
                        saveMessages(for: "jiwang") // 保存消息到历史记录
                        isLoading = false // 停止等待动画
                        withAnimation {
                            scrollViewProxy?.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            } catch {
                print("Error: Unable to decode JSON response")
            }
        }.resume()
    }
    
    
      
    
    private func loadMessages(for roomName: String) {
        let key = "messages_\(roomName)"
        if let data = UserDefaults.standard.data(forKey: key),
           let decodedMessages = try? JSONDecoder().decode([Message].self, from: data) {
            messages = decodedMessages
        }
    }

    private func saveMessages(for roomName: String) {
        let key = "messages_\(roomName)"
        if let encodedMessages = try? JSONEncoder().encode(messages) {
            UserDefaults.standard.set(encodedMessages, forKey: key)
        }
    }
    
    
    func showDocumentPicker() {
        // 创建一个文档选择器，指定允许选择的文件类型为 PDF
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        
        // 设置选择器的代理，处理选择的文件
        documentPicker.delegate = DocumentPickerDelegate { url in
            if let url = url {
                // 使用 PDFKit 识别 PDF 文件内容
                if let pdfDocument = PDFDocument(url: url) {
                    var textContent = ""
                    
                    // 遍历每一页并提取文本
                    for pageIndex in 0..<pdfDocument.pageCount {
                        if let page = pdfDocument.page(at: pageIndex) {
                            textContent += page.string ?? ""
                        }
                    }
                    print(textContent)
                    
                    fileText = textContent

                    // 调用 sendMessage 函数，传递识别的文本内容
                    sendMessage(fileText: fileText, fileUrl: selectedFileURL)
                } else {
                    print("Error: Unable to open PDF document")
                }
            } else {
                print("Error: No file selected")
            }
        }
        
        // 展示文档选择器
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true)
    }
    
    
    
    // 提取 PDF 文件的文本内容
    func extractTextFromPDF(at url: URL) -> String {
        guard let pdfDocument = PDFDocument(url: url) else {
            print("Error: Could not open PDF document")
            return ""
        }

        var pdfText = ""
        for pageIndex in 0..<pdfDocument.pageCount {
            if let page = pdfDocument.page(at: pageIndex) {
                pdfText += page.string ?? ""
            }
        }
        print(pdfText)
        return pdfText
    }

    
    
    
    
    
    
    
    
}
struct computerInternet_View_Previews: PreviewProvider {
    static var previews: some View {
        computerInternetView()
    }
}

