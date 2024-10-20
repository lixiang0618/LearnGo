//
//  Signup.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/14.
//

import SwiftUI

struct SignUp: View {
    @Binding var showSignup: Bool
    @State private var emailId: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            
            Button(action: {
                showSignup = false
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            
            Text("注册")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top,25)
            
            Text("填入下方信息即可完成注册哦😯")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                CustomTF(sfIcon: "at", hint: "Email Address", value: $emailId)
                
                CustomTF(sfIcon: "person", hint: "Full Name", value: $fullName)
                    .padding(.top, 5)
                
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
//                Button("Forget Password? "){
//                    
//                }
//                .font(.callout)
//                .fontWeight(.heavy)
//                .tint(.orange)
//                .hSpacing(.trailing)
                
                GradientButton(title: "Finish", icon: "arrow.right") {
                    performSignup(email: emailId, fullName: fullName, password: password) {
                        // 获取根视图控制器并跳转，带更流畅的过渡效果
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = windowScene.windows.first {
                            let nextView = UIHostingController(rootView: LoginPage()) // 替换为目标视图

                            // 更改过渡效果为更丝滑的动画
                            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve, .curveEaseInOut], animations: {
                                window.rootViewController = nextView
                                window.makeKeyAndVisible()
                            }, completion: nil)
                        }
                    }
                }
                .hSpacing(.trailing)
                .disableWithOpacity(emailId.isEmpty || password.isEmpty || fullName.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            HStack(spacing: 6){
                Text("已经注册过账号了?")
                    .foregroundStyle(.gray)
                
                Button("点击登录"){
                    showSignup = false
                }
                .fontWeight(.bold)
                .tint(.orange)
            }
            .font(.callout)
            .hSpacing()

        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
}


private func performSignup(email: String, fullName: String, password: String, onSuccess: @escaping () -> Void) {
    var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [String: String]()
    var fullnames = UserDefaults.standard.dictionary(forKey: "fullnames") as? [String: String] ?? [String: String]()
    
    let alertController: UIAlertController
    
    if users[email] != nil {
        alertController = UIAlertController(title: "注册失败😟", message: "这个邮箱已经注册过账号咯～", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "好的", style: .default))
    } else {
        users[email] = password
        UserDefaults.standard.set(users, forKey: "users")
        
        fullnames[email] = fullName
        UserDefaults.standard.set(fullnames, forKey: "fullnames")
        
        alertController = UIAlertController(title: "注册成功😁", message: "要牢记你的登陆邮箱和密码哦～", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "好的", style: .default) { _ in
            // 点击“OK”后执行跳转
            onSuccess()
        })
    }
    
    // 显示弹窗
    if let topController = UIApplication.shared.windows.first?.rootViewController {
        topController.present(alertController, animated: true, completion: nil)
    }
}




//func performSignup(email: String, fullName: String, password: String, onSuccess: @escaping () -> Void) {
//    var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [String: String]()
//    
//    let alertController: UIAlertController
//    
//    if users[email] != nil {
//        alertController = UIAlertController(title: "Sign Up Status", message: "Sign up failed, this email is already registered", preferredStyle: .alert)
//    } else {
//        users[email] = password
//        UserDefaults.standard.set(users, forKey: "users")
//        alertController = UIAlertController(title: "Sign Up Status", message: "Sign up successful", preferredStyle: .alert)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            onSuccess() // 在弹窗显示0.5秒后执行跳转
//        }
//    }
//    
//    alertController.addAction(UIAlertAction(title: "OK", style: .default))
//    
//    // 显示弹窗
//    if let topController = UIApplication.shared.windows.first?.rootViewController {
//        topController.present(alertController, animated: true, completion: nil)
//    }
//}



#Preview {
    LoginPage()
}
