import SwiftUI
import UIKit

struct AR_View: View {
    @State private var objectName_NetV2: String? = "请选择图片并识别"
    @State private var objectName_YoloV3: String? = "请选择图片并识别"
    @State private var simplified: String = "选择图片"
    @State private var traditonal: String = "选择图片"
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    @Environment(\.colorScheme) var colorScheme


    
    // 创建 Translator 实例
    private let translator = Translator(jsonFileName: "cedict_entries") // 确保不包含 .json 后缀
    
    private let speechSynthesizer = SpeechSynthesizer()

    var body: some View {
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .brown.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {

                    VStack(alignment: .leading, spacing: 10) {
                        
                        HStack {
                            Spacer()
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.gray, lineWidth: 5) // 设置边框的颜色和宽度
                                            .padding(-10) // 控制边框相对于 Image 的偏移
                                    )
                                    .padding()
                            }
                            Spacer()
                        }
                        
                        
                        
                        modelResultView(modelName: "MNetV2", result: objectName_NetV2)
                        modelResultView(modelName: "YoloV3", result: objectName_YoloV3)
                        // 添加翻译结果展示
                        if let detectedName = objectName_NetV2 {
                            let (traditional, simplified) = translator.translate(from: detectedName)
                            
                            HStack {
                                VStack {
                                    // 显示简体中文标签
                                    Text("简体中文")
                                        .font(.headline) // 设置字体
    //                                    .foregroundColor(.blue) // 设置字体颜色
                                        .padding(.top, 1) // 顶部间距
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                        
                                        // 显示简体中文翻译
                                    Text(simplified)
                                        .font(.body) // 设置较小的字体
    //                                    .foregroundColor(.black) // 设置字体颜色
                                        .padding() // 增加内边距
                                        .background(Color.gray.opacity(0.3)) // 添加背景色
                                        .cornerRadius(80) // 圆角
                                        .shadow(color: .gray, radius: 2, x: 0, y: 2) // 添加阴影
                                        .frame(width: 120)
                                    
                                    
                                }
                                .padding()
                                
                                VStack {
                                    // 显示繁体中文标签
                                     Text("繁体中文")
                                         .font(.headline) // 设置字体
    //                                     .foregroundColor(.red) // 设置字体颜色
                                         .padding(.top, 1) // 顶部间距
                                         .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                     
                                     // 显示繁体中文翻译
                                     Text(traditional)
                                         .font(.body) // 设置较小的字体
                                         .foregroundColor(colorScheme == .dark ? Color.white : .black) // 设置字体颜色
                                         .padding() // 增加内边距
                                         .background(Color.gray.opacity(0.3)) // 添加背景色
                                         .cornerRadius(80) // 圆角
                                         .shadow(color: .gray, radius: 2, x: 0, y: 2) // 添加阴影
                                         .frame(width: 120)
                                    
                                }
                                
                                
                            }
                            
    //
    //                        Text("简体中文: \(simplified)")
    //                            .padding(.top,1)
    //                        Text("繁体中文: \(traditional)")
    //                            .padding(.top,2)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
//                    .background(Color(UIColor.placeholderText))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding()
                    
                    Spacer()
                    
    //                Button(action: {
    //                    showImagePicker = true
    //                }) {
    //                    Text("选择图片")
    //                        .font(.headline)
    //                        .foregroundColor(.white)
    //                        .padding()
    //                        .background(Color.blue)
    //                        .cornerRadius(10)
    //                }
    //                .sheet(isPresented: $showImagePicker) {
    //                    ImagePicker(image: $selectedImage)
    //                }

                    if let image = selectedImage {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    showImagePicker = true
                                }) {
                                    Text("重新选择")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                        .padding(.bottom, 20)
                                }
                                .sheet(isPresented: $showImagePicker) {
                                    ImagePicker(image: $selectedImage)
                                }
                                Spacer()
                                
                                Button(action: {
                                    recognizeImage(image)
                                }) {
                                    Text("识别图片")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.9), Color.red.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                        .padding(.bottom, 20)
                                }
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            
    //                        Image(uiImage: image)
    //                            .resizable()
    //                            .scaledToFit()
    //                            .frame(height: 150)
    //                            .background(
    //                                RoundedRectangle(cornerRadius: 15)
    //                                    .stroke(Color.gray, lineWidth: 5) // 设置边框的颜色和宽度
    //                                    .padding(-10) // 控制边框相对于 Image 的偏移
    //                            )
    //                            .padding()

                        }

                    }
                    else {
                        Button(action: {
                            showImagePicker = true
                        }) {
                            // Before
                            Text("选择图片")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.9), Color.red.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .padding(.bottom, 20)
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $selectedImage)
                        }
                    }
                    
                    Spacer()
                    
                    
                    
                }
                .padding()
            }
//            .navigationTitle("SuperScan")
        }
    }
        

    private func modelResultView(modelName: String, result: String?) -> some View {
        VStack(alignment: .leading) {
            
            Text("\(modelName) 模型识别")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 1)
                .frame(width:250,alignment: .center)

            
            Text(result ?? "未识别到物体")
                .padding()
                .fontWeight(.bold)
                .background(colorScheme == .light ? Color.white : .black)
                .foregroundColor(.primary)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .frame(width: 250,height: 60,alignment: .center)
        }
        .padding()
    }

    private func recognizeImage(_ image: UIImage) {
        let recognizer = ObjectRecognizer()
        
        // MobileNetV2
        recognizer.recognize_NetV2(image: image) { name in
            DispatchQueue.main.async {
                objectName_NetV2 = name
            }
        }
        
        // YoloV3
        recognizer.recognize_YoloV3(image: image) { names in
            DispatchQueue.main.async {
                // 如果识别结果为空，显示“未识别到物体”
                if let detectedObjects = names, !detectedObjects.isEmpty {
                    objectName_YoloV3 = detectedObjects.joined(separator: ", ")
                } else {
                    objectName_YoloV3 = "未识别到物体"
                }
            }
        }
    }
}

struct AR_View_Previews: PreviewProvider {
    static var previews: some View {
        AR_View()
//        MainView()
    }
}
