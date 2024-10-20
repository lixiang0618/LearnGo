////
////  progress.swift
////  test
////
////  Created by CCNU-SK-35 on 2024/10/17.
////
//
//import SwiftUI
//
//struct progress: View {
//    var body: some View {
//            ZStack {
//                // 半透明背景遮罩，覆盖整个屏幕
//                Color.black.opacity(0.4)
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack {
//                    Text("生成笔记中...")
//                        .font(.headline)
//                        .padding()
//                    
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
//                        .padding()
//                    
//                    Button("取消") {
//                        isLoading = false // 点击取消按钮时关闭弹窗
//                    }
//                    .padding(.top, 10)
//                }
//                .frame(width: 200, height: 150)
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(radius: 10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.blue, lineWidth: 2)
//                )
//                .transition(.scale)
//            }
//        }
//    }
//}
//
//#Preview {
//    progress()
//}
