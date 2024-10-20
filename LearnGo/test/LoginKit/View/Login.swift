//
//  Login.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/14.
//

import SwiftUI
var LogginEmail: String = "未知邮箱"

struct Login: View {
    @Binding var showSignup: Bool
    @State private var emailId: String = ""
    @State private var password: String = ""
    @State private var showForgotPasswordView: Bool = false
    @State private var showResetView: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("登陆")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("登陆才可解锁全部功能哦😯")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                CustomTF(sfIcon: "at", hint: "Email Address", value: $emailId)
                
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
                Button("忘记密码? "){
                    showForgotPasswordView.toggle()
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.orange)
                .hSpacing(.trailing)
                
                GradientButton(title: "GO", icon: "arrow.right") {
                    performLogin(email: emailId, password: password) {
                        // 获取根视图控制器并跳转，带动画
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = windowScene.windows.first {
                            let nextView = UIHostingController(rootView: MainView()) // 替换为目标视图
                            // 更改过渡效果为更丝滑的动画
                                        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseInOut], animations: {
                                            window.rootViewController = nextView
                                            window.makeKeyAndVisible()
                            }, completion: nil)
                        }
                    }
                }
                .disableWithOpacity(emailId.isEmpty || password.isEmpty)
                .hSpacing(.trailing)
//                .disableWithOpacity(emailId.isEmpty || password.isEmpty)
                
            }
            .padding(.top, 20)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            HStack(spacing: 6){
                Text("还没有账号?")
                    .foregroundStyle(.gray)
                
                Button("点击注册"){
                    showSignup.toggle()
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
        .sheet(isPresented: $showForgotPasswordView, content: {
            if #available(iOS 16.4, *) {
                ForgetPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                ForgetPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])

            }
        })
    }
}






private func performLogin(email: String, password: String, onSuccess: @escaping () -> Void) {
    let users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [String: String]()
    
    let alertController: UIAlertController
    
    if let savedPassword = users[email], savedPassword == password {
        LogginEmail = email
        alertController = UIAlertController(title: "登陆成功😁", message: "你好，欢迎光临～", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "我来了", style: .default) { _ in
            // 点击“OK”后执行跳转
            onSuccess()
        })
    } else {
        alertController = UIAlertController(title: "Login Status", message: "Login failed, please check your email and password", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
    }
    
    // 显示弹窗
    if let topController = UIApplication.shared.windows.first?.rootViewController {
        topController.present(alertController, animated: true, completion: nil)
    }
}



//func performLogin(email: String, password: String, onSuccess: @escaping () -> Void) {
//    let users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [String: String]()
//    
//    let alertController: UIAlertController
//    
//    if let savedPassword = users[email], savedPassword == password {
//        alertController = UIAlertController(title: "Login Status", message: "Login successful", preferredStyle: .alert)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            onSuccess() // 在弹窗显示0.5秒后执行跳转
//        }
//    } else {
//        alertController = UIAlertController(title: "Login Status", message: "Login failed, please check your email and password", preferredStyle: .alert)
//    }
//    
//    alertController.addAction(UIAlertAction(title: "OK", style: .default))
//    
//    // 显示弹窗
//    if let topController = UIApplication.shared.windows.first?.rootViewController {
//        topController.present(alertController, animated: true, completion: nil)
//    }
//}








#Preview{
    LoginPage()
}
//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        Login()
//    }
//}
