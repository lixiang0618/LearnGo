//
//  Profile.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/9/26.
//

import Foundation
import SwiftUI
import Setting

// “我的”视图
struct SettingNewView: View {
    @State private var changeTheme: Bool = false
    @Environment(\.colorScheme) private var scheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @State private var notificationsEnabled: Bool = true
    @State private var showAbout: Bool = false
    
    // 从 UserDefaults 中获取用户的 fullname 和 email
    @State private var fullName: String = ""

    var body: some View {
        NavigationStack {
            List {
                // 用户信息
                Section {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(.trailing, 10)
                        VStack(alignment: .leading) {
                            Text(fullName)
                                .font(.headline)
                            Text(LogginEmail)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                

                // 外观设置
                Section("外观🌙") {
                    Button("颜色模式切换") {
                        changeTheme.toggle()
                    }
                }

                // 通知设置
                Section("通知📢") {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("允许通知")
                    }
                }

                // 隐私和其他设置
                Section("隐私与安全🔒") {
                    NavigationLink("隐私政策", destination: Text("Privacy Policy Details"))
                    NavigationLink("服务条款", destination: Text("Terms of Service Details"))
                }

                // 关于信息
                Section("关于") {
                    Button("关于App") {
                        showAbout.toggle()
                    }
                }
            }
            .navigationTitle("设置")
            
        }
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $changeTheme, content: {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
        .alert(isPresented: $showAbout) {
            Alert(
                title: Text("About This App"),
                message: Text("Version 1.0\nCreated by CCNU-SK-35"),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            // 加载 fullName
            loadFullName()
        }
    }

    private func loadFullName() {
        // 从 UserDefaults 中获取全名
        let fullNames = UserDefaults.standard.dictionary(forKey: "fullnames") as? [String: String] ?? [:]
        print("Stored fullnames:", fullNames) // 调试信息，检查fullNames内容
        
        if let name = fullNames[LogginEmail] {
            fullName = name
        } else {
            fullName = "未知昵称"
        }
    }
    
    
}




#Preview {
    SettingNewView()
}










//import Foundation
//import SwiftUI
//import Setting
//// “我的”视图
//struct SettingNewView: View {
//    @State private var changeTheme: Bool = false
//    @Environment(\.colorScheme) private var scheme
//    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
//
//    var body: some View {
//        
////        SettingStack {
////            SettingPage(title: "Setting") {
////                SettingGroup {
////                    SettingText(title:"Hello and Fuck U ~ ")
////                    
//////                    SettingButton(title: "change Theme", horizontalSpacing: 10, verticalPadding: 20, horizontalPadding: 20, action: {changeTheme.toggle()})
//////                        .icon("moon")
////                    
////                    
////                    
////                    
////                }
////                SettingGroup(header: "Group Title") {
////                    SettingPage(title: "setting page"){}
////                        .previewIcon("star")
////                }
////            }
////        }
//        
//        NavigationStack {
//            List {
//                Section("Appearance") {
//                    Button("Change Theme") {
//                        changeTheme.toggle()
//                    }
////                    .padding()
//
//                    
//                }
//                
//            }
//            .navigationTitle("Settings")
//        }
//        .preferredColorScheme(userTheme.colorScheme)
//        .sheet(isPresented: $changeTheme, content: {
//            ThemeChangeView(scheme: scheme)
//                .presentationDetents([.height(410)])
//                .presentationBackground(.clear)
//        })
//        
//        
//    }
//}


//#Preview {
//    SettingNewView()
//}
