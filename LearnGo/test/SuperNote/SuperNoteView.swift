//
//  SwiftUIView.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/16.
//

import SwiftUI
import MarkdownUI
import UIKit
import Photos

struct SuperNote: View {
    @State private var keyword = "" // 用户输入的关键字
    @State private var fileText = "" // 上传的 PDF 文件内容
    @State private var note = "" // 生成的笔记内容
    @State private var buttonColor = Color.blue.opacity(0.8) // 默认按钮颜色
    @State private var isLoading = false // 控制动画显示
    @State private var showAlert_noNote: Bool = false
    
    @State private var showAlertType: AlertType?
    enum AlertType: Identifiable {
        case noNote
        case isLoading

        var id: Int {
            // 为每种弹窗类型提供唯一的标识符
            switch self {
            case .noNote: return 1
            case .isLoading: return 2
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.1), .blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
//                    Spacer()
                    TextField("请输入关键字", text: $keyword)
                        .padding()
                        .frame(height: 100)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    
                    HStack {
                        Button(action: {
                            if !fileText.isEmpty {
                                let alert = UIAlertController(title: "确认清除", message: "您确定要清除已上传的文件吗？", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                                alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { _ in
                                    // 用户确认清除时，将 fileText 置空并恢复按钮颜色
                                    fileText = ""
                                    buttonColor = Color.orange
                                }))
                                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                            } else {
                                PDFReader.shared.selectAndExtractPDFFile { text in
                                    fileText = text
                                    print("PDF内容提取结果：\(fileText)")
                                    buttonColor = Color.green // 文件上传成功后按钮变为绿色
                                    showUploadSuccessAlert() // 弹窗提示上传成功
                                }
                            }
                        }) {
                            Image(systemName: "doc.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding()
                                .background(buttonColor)
                                .clipShape(Circle())
                        }
                        .padding(25)
                        .transition(.scale)
                        .padding(.bottom)
                        
                        Button(action: {
                            generateNote()
                        }) {
                            Text("生成笔记")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(note.isEmpty ? LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .padding(.bottom, 20)
//                                .frame(height: 80)
                        }
                        .padding()
                    }
//                    Spacer()
                    
                    
                    
                    
                    Text("超级笔记")
                        .font(.headline)
                        .padding(.top)
                    
                    ScrollView {
                        Text(note.isEmpty ? "点击生成笔记才可以看到笔记哦😯" : note)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .frame(maxHeight: 300)
                    
                    HStack {
                        Button(action: {
                            if !note.isEmpty {
                                let note_Markdown = Markdown(note)
                                exportMarkdownAsImage(noteMarkdown: note_Markdown)
                            }
                            
                            
                            if note.isEmpty {
                                // tanchuang
                                showAlert_noNote = true
                                showAlertType = .noNote
                                
                            }
                            
                        }) {
                            Text("导出为图片")
                                .font(.headline)
                                .foregroundColor(note.isEmpty ? .white.opacity(0.6) : .white)

                                .padding()
                                .background(!note.isEmpty ? LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .padding(.bottom, 20)
                                .frame(width: 140)
                        }
                        .padding()


                        
                        Button(action: {
                            exportToNotes(note: note)// 调用导出到备忘录的函数
                        }) {
                            Text("导出到备忘录")
                                .font(.headline)
                                .foregroundColor(note.isEmpty ? .white.opacity(0.6) : .white)
                                .padding()
                                .background(!note.isEmpty ? LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .padding(.bottom, 20)
                                .frame(width: 140)
                        }
                    }
                    .padding()
                    Spacer()
                    
                    if !note.isEmpty {
                        let note_Markdown = Markdown(note)
                    }
                    

//                    if !note.isEmpty {
//                        let note_Markdown = Markdown(note)
//                        Text("生成的笔记：")
//                            .font(.headline)
//                            .padding(.top)
//                        
//                        ScrollView {
//                            Text(note)
//                                .padding()
//                                .background(Color.gray.opacity(0.1))
//                                .cornerRadius(10)
//                                .padding(.horizontal)
//                        }
//                        .frame(maxHeight: 300)
//                        
//                        HStack {
//                            Button(action: {
//                                exportMarkdownAsImage(noteMarkdown: note_Markdown) // 调用导出函数
//                            }) {
//                                Text("导出为图片")
//                                    .padding()
//                                    .background(Color.green)
//                                    .cornerRadius(10)
//                                    .foregroundColor(.white)
//                            }
//                            
//                            
//                            Button(action: {
//                                exportToNotes(note: note)// 调用导出到备忘录的函数
//                            }) {
//                                Text("导出到备忘录")
//                                    .padding()
//                                    .background(Color.green)
//                                    .cornerRadius(10)
//                                    .foregroundColor(.white)
//                            }
//                        }
//                        Spacer()
//                        
//                        
//                        
//                        
//                    }
                    
                    
                }
                .padding()
            }
            .navigationTitle("SuperNote") // 确保 navigationTitle 在 NavigationView 内部设置

            .alert(item: $showAlertType) { alertType in
                switch alertType {
                case .noNote :
                    return Alert(
                               title: Text("注意⚠️"),
                               message: Text("你好像还没有笔记哦～"),
                               dismissButton: .default(Text("马上去生成"))
//                               primaryButton: .default(Text("马上生成")
//                                .fontWeight(.bold)),
//                               secondaryButton: .cancel()
                           )
                    
                case .isLoading:
                    return  Alert(
                        title: Text("生成笔记中..."),
                        message: Text("请稍候，正在生成笔记。"),
                        dismissButton: .default(Text("确定"), action: {
                            isLoading = false // 点击确定按钮时关闭弹窗
                            showAlertType = nil
                        })
                    )
                }
                
            }
            .onChange(of: note) {newNote in
                if !newNote.isEmpty {
                    showAlertType = nil
                }
            }
            
            
            
        }
        
//        if isLoading {
//            VStack {
//                Text("生成笔记中...")
//                    .font(.headline)
//                    .padding()
//                
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
//                    .padding()
//                
//                Button("取消") {
//                    isLoading = false // 点击取消按钮时关闭弹窗
//                }
//                .padding(.top, 10)
//            }
//            .frame(width: 200, height: 150)
//            .background(Color.white)
//            .cornerRadius(10)
//            .shadow(radius: 10)
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.blue, lineWidth: 2)
//            )
//            .transition(.scale)
//        }

        
        
    }
    
    // 导出函数
    func exportMarkdownAsImage(noteMarkdown: Markdown) {
        let controller = UIHostingController(rootView: noteMarkdown)
        
        let targetSize = CGSize(width: 500, height: 3000) // 根据需要调整大小
        let renderer = UIGraphicsImageRenderer(size: targetSize)

        // 强制加载视图并设置布局
        controller.view.frame = CGRect(origin: .zero, size: targetSize)
        controller.view.backgroundColor = .white // 确保背景为白色
        let rootView = controller.view!

        // 将视图添加到当前的视图层级中
        UIApplication.shared.windows.first?.addSubview(rootView)
        
        // 确保在视图层级中布局
        rootView.layoutIfNeeded()

        // 显示“图片保存中”的弹窗
        let alert = UIAlertController(title: nil, message: "图片保存中...", preferredStyle: .alert)
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(alert, animated: true, completion: nil)
        }

        let image = renderer.image { context in
            rootView.layer.render(in: context.cgContext)
        }
        
        // 创建图片视图
           let imageView = UIImageView(image: image)
           imageView.contentMode = .scaleAspectFill // 确保图片填充
           imageView.frame = UIScreen.main.bounds // 设置为全屏
           imageView.clipsToBounds = true // 确保裁剪超出部分

           // 创建一个新的视图控制器来显示图片
           let imageViewController = UIViewController()
           imageViewController.view.addSubview(imageView)

        // 请求相册访问权限
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                // 保存图片到相册
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }) { success, error in
                    // 保存完成后移除视图并关闭弹窗
                    DispatchQueue.main.async {
                        rootView.removeFromSuperview()
                        alert.dismiss(animated: true) {
                            if success {
                                print("图片已成功保存到相册")
                            } else if let error = error {
                                print("保存图片时出错：\(error.localizedDescription)")
                            }
                        }
                    }
                }
            } else {
                // 无权限时移除视图并关闭弹窗
                DispatchQueue.main.async {
                    rootView.removeFromSuperview()
                    alert.dismiss(animated: true) {
                        print("没有权限访问相册")
                    }
                }
            }
        }
    }
    
    
    
    // 导出到备忘录
    // 导出到备忘录
    private func exportToNotes(note: String) {
        // 使用 UIActivityViewController 导出文本到备忘录
        let activityController = UIActivityViewController(activityItems: [note], applicationActivities: nil)

        // 需要在主线程展示
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(activityController, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    

    private func showUploadSuccessAlert() {
        let successAlert = UIAlertController(title: "上传成功", message: "PDF 文件已成功上传", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(successAlert, animated: true, completion: nil)
    }

    private func generateNote() {
        isLoading = true
        showAlertType = .isLoading
        let userMessage = "关键字：\(keyword)"
        let combinedMessage = "你现在是作为一个十分擅长撰写课堂笔记的大师。现在你讲帮助一位学生来完成他的某次课堂笔记。我将给你提供该名学生在课堂上记录的关键字部分，与本次课堂讲授的PDF文件内容。你需要按照文件内容为纲要（或者说为主要结构主要内容），以学生的关键字为补充（绝对不能遗漏关键字），来生成一篇十分精美和实用的知识点笔记，直接以Markdown格式形式给我。下面是学生的‘’‘\(userMessage)’‘’\n。这是课堂的PDF内容：‘’‘\(fileText)’‘’"

        guard !userMessage.isEmpty else {
            isLoading = false
            showAlertType = .isLoading
            return
        }

        var contentArray: [[String: Any]] = [
            ["type": "text", "text": combinedMessage]
        ]

        guard let url = URL(string: "https://api.fastgpt.in/api/v1/chat/completions") else {
            isLoading = false
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body: [String: Any] = [
            "messages": [["role": "user", "content": contentArray]]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("无法编码JSON数据")
            return
        }

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Your key on FastGPT", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("请求错误: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("未收到数据")
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    isLoading = false
                    if let content = apiResponse.choices.first?.message.content {
                        note = content // 更新生成的笔记
                        showAlertType = nil
                    }
                }
            } catch {
                print("无法解码JSON响应")
            }
        }.resume()
    }
}

#Preview {
    SuperNote()
}
