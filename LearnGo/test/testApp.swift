//
//  testApp.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/9/25.
//
import SwiftUI

@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            LoginPage()
//            MainView() // 启动时显示主视图
//            PDFTextExtractorView()
//            SuperNote()
//            HeroAnimation_Content()
//            SpeechRecognitionView()
//            AR_View()
//            DrawingBoundingBoxView()
//            CameraView()
//                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//            SettingNewView()
//            SetCamera()
            
        }
    }
}














//struct MainView: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("选择聊天室")
//                    .font(.largeTitle)
//                    .padding()
//
//                List {
//                    NavigationLink(destination: ChatView()) {
//                        Text("聊天室 1")
//                            .padding()
//                            .background(Color.orange.opacity(0.2))
//                            .cornerRadius(10)
//                    }
//                    NavigationLink(destination: ProfileView()) {
//                        Text("聊天室 2")
//                            .padding()
//                            .background(Color.orange.opacity(0.2))
//                            .cornerRadius(10)
//                    }
//                    NavigationLink(destination: computerInternetView()) {
//                        Text("聊天室 3")
//                            .padding()
//                            .background(Color.orange.opacity(0.2))
//                            .cornerRadius(10)
//                    }
//                }
//                .listStyle(InsetGroupedListStyle())
//            }
////            .navigationTitle("主视图")
////            .edgesIgnoringSafeArea(.all)
//        }
//    }
//}




struct MainView: View {
    @Namespace var animationNamespace
    @State private var selectedChat: String? = nil
    @State private var gradientStart = UnitPoint(x: 0.0, y: 0.0)
    @State private var gradientEnd = UnitPoint(x: 1.0, y: 1.0)
    
    @Environment(\.colorScheme) var colorScheme


    var body: some View {
        TabView {
            NavigationView {
                
                
                
                
                
                
                
                ZStack {
                    
                    if colorScheme == .light {
                        // 渐变背景，铺满全屏
                        LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.6), Color.yellow.opacity(0.3)]), startPoint: gradientStart, endPoint: gradientEnd)
                            .blur(radius: 10.0)
                            .ignoresSafeArea()
                            .animation(Animation.linear(duration: 1.8).repeatForever(autoreverses: true), value: gradientStart)
                            .onAppear {
                                withAnimation {
                                    gradientStart = UnitPoint(x: 1.0, y: 0.5)
                                    gradientEnd = UnitPoint(x: 0.0, y: 0.5)
                                }
                            }
                    }
                    else {
                        // 渐变背景，铺满全屏
                        LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.gray.opacity(0.4)]), startPoint: gradientStart, endPoint: gradientEnd)
                            .blur(radius: 10.0)
                            .ignoresSafeArea()
                            .animation(Animation.linear(duration: 1.8).repeatForever(autoreverses: true), value: gradientStart)
                            .onAppear {
                                withAnimation {
                                    gradientStart = UnitPoint(x: 1.0, y: 0.5)
                                    gradientEnd = UnitPoint(x: 0.0, y: 0.5)
                                }
                            }
                    }


                    VStack(spacing: 40) {
                        Text("选择聊天室")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(colorScheme == .light ? .black.opacity(0.8) : .white.opacity(0.8))
//                            .foregroundColor(colorScheme == .dark ? .black.opacity(0.8) : .white.opacity(0.8))
    //                        .background(Color.orange.opacity(0.4))
                            .cornerRadius(60)

                        // 创建一个模糊的毛玻璃效果
                        VStack(spacing: 20) {
                            
                            NavigationLink(destination: HeroAnimation_Content()) {
                                Text("Assistant")
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.9), Color.red.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
//                                    .background(VisualEffectBlur(blurStyle: .systemMaterial)
//                                        .opacity(0.9)
//                                        .frame(width: 800,height:100)) // 使用毛玻璃效果
                                    .cornerRadius(15)
                                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)

                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding()
                            
                            
                            
                            
                            
                            
                            NavigationLink(destination: ChatView()) {
                                Text("博弈论课程助手")
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.9), Color.red.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
//                                    .background(VisualEffectBlur(blurStyle: .systemMaterial)
//                                        .opacity(0.9)
//                                        .frame(width: 800,height:100)) // 使用毛玻璃效果
                                    .cornerRadius(15)
                                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)

                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding()



                            NavigationLink(destination: computerInternetView()) {
                                Text("计算机网络课程助手")
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.9), Color.red.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
//                                    .background(VisualEffectBlur(blurStyle: .systemMaterial)
//                                        .opacity(0.9)
//                                        .frame(width: 800,height:100)) // 使用毛玻璃效果
                                    .cornerRadius(15)
                                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)

                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding()
                            
                            
                  
                        }
                        .padding(.top, 10) // 调整顶部间距
                    }
                    .padding() // 增加整体内边距
                }
                
                
                
                
                
                
                
                
//                HeroAnimation_Content()
                
                
                
                
                
            }
            .navigationViewStyle(StackNavigationViewStyle()) // 适配不同设备
            .tabItem {
                Label("超级助手", systemImage: "message.fill")
            }
            
            
            SuperNote()
                .tabItem {
                    Label("超级笔记", systemImage: "pencil.and.outline")
                }
            
            AR_View()
                .tabItem {
                    Label("超级识别", systemImage: "star")
                }
            

            SettingNewView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
        }
    }
}

// 视觉效果模糊视图
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}















// 示例聊天室视图
struct ChatRoom1View: View {
    var body: some View {
        Text("欢迎来到聊天室 1")
            .font(.largeTitle)
            .navigationTitle("聊天室 1")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatRoom2View: View {
    var body: some View {
        Text("欢迎来到聊天室 2")
            .font(.largeTitle)
            .navigationTitle("聊天室 2")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatRoom3View: View {
    var body: some View {
        Text("欢迎来到聊天室 3")
            .font(.largeTitle)
            .navigationTitle("聊天室 3")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
