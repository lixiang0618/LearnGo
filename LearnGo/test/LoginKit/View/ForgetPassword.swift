//
//  ForgetPassword.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/14.
//

import SwiftUI

struct ForgetPassword: View {
    @Binding var showResetView: Bool
    @State private var emailId: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            
            Text("找回密码")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top,25)
            
            Text("我们将会发送验证链接到您的邮箱")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                CustomTF(sfIcon: "at", hint: "Email Address", value: $emailId)
                

                
//                Button("Forget Password? "){
//
//                }
//                .font(.callout)
//                .fontWeight(.heavy)
//                .tint(.orange)
//                .hSpacing(.trailing)
                
                GradientButton(title: "Send", icon: "arrow.right" ) {
                    Task {
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        showResetView = true
                    }
                }
                .hSpacing(.trailing)
                .disableWithOpacity(emailId.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            


        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
    }
}


#Preview {
    LoginPage()
}
