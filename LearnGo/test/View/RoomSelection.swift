//
//  RoomSelection.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/9/26.
//

//import Foundation
//import SwiftUI
//
//// 选择聊天室视图
//struct RoomSelectionView: View {
//    @Binding var selectedRoom: String
//    @Environment(\.presentationMode) var presentationMode
//    @State private var navigateToChatRoom: String? // 用于控制导航
//
//    var body: some View {
//        NavigationView {
//            List {
//                Button(action: { selectRoom("聊天室 1") }) { Text("聊天室 1") }
//                Button(action: { selectRoom("聊天室 2") }) { Text("聊天室 2") }
//                Button(action: { selectRoom("聊天室 3") }) { Text("聊天室 3") }
//            }
//            .navigationTitle("选择聊天室")
//            .background(
//                NavigationLink(
//                    destination: chatRoomView(for: selectedRoom),
//                    tag: "聊天室 1", // 将按钮和视图绑定
//                    selection: $navigateToChatRoom
//                ) { EmptyView() }
//            )
//            .background(
//                NavigationLink(
//                    destination: chatRoomView(for: selectedRoom),
//                    tag: "聊天室 2",
//                    selection: $navigateToChatRoom
//                ) { EmptyView() }
//            )
//            .background(
//                NavigationLink(
//                    destination: chatRoomView(for: selectedRoom),
//                    tag: "聊天室 3",
//                    selection: $navigateToChatRoom
//                ) { EmptyView() }
//            )
//        }
//    }
//
//    private func selectRoom(_ room: String) {
//        selectedRoom = room
//        navigateToChatRoom = room // 设置导航目标
//        presentationMode.wrappedValue.dismiss()
//    }
//
//    // 根据选择的聊天室返回相应的聊天视图
//    private func chatRoomView(for room: String) -> some View {
//        switch room {
//        case "聊天室 1":
//            return AnyView(ChatView()) // 替换为你的聊天视图
//        case "聊天室 2":
//            return AnyView(ProfileView())
//        case "聊天室 3":
//            return AnyView(ChatView())
//        default:
//            return AnyView(Text("未知聊天室"))
//        }
//    }
//}
//
////
////struct ChatView_select_Previews: PreviewProvider {
////    static var previews: some View {
////        RoomSelectionView(selectedRoom: selectedRoom)
////    }
////}
