//
//  LoginPage.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/14.
//

import SwiftUI

struct LoginPage: View {
    @State private var showSignup: Bool = false
    var body: some View {
        NavigationStack{
            Login(showSignup: $showSignup)
                .navigationDestination(isPresented: $showSignup) {
                    SignUp(showSignup: $showSignup)
                }
        }
        .overlay {
            if #available(iOS 17, *){
                CircleView()
                    .animation(.smooth(duration: 0.45, extraBounce: 0), value: showSignup)
            } else {
                CircleView()
                    .animation(.easeInOut(duration: 0.3),value: showSignup)
            }
            
        }
    }
    
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.yellow, .orange, .red], startPoint: .top, endPoint: .bottom))
            .frame(width: 200, height: 200)
            .offset(x: showSignup ? 90 : -90, y: -90)
            .blur(radius: 15)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
    }
    
}







#Preview {
    LoginPage()
}
