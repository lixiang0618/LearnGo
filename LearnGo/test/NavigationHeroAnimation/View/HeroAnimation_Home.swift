//
//  HeroAnimation_Home.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/17.
//

import SwiftUI

struct Home: View {
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool

    var body: some View {
        List {
            ForEach(profiles) { profile in
                Button(action: {
                    selectedProfile = profile
                    pushView.toggle()
                }, label: {
                    HStack(spacing: 15) {
                        Color.clear
                            .frame(width: 60, height: 60)
                            .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                                return [profile.id: anchor]
                            })


                        
                        VStack(alignment: .leading, spacing: 2, content: {
                            Text(profile.userName)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            Text(profile.lastMsg)
                                .font(.callout)
                                .textScale(.secondary)
                                .foregroundStyle(.gray)

                        })
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Text(profile.lastActive)
                            .font(.caption)
                            .foregroundStyle(.gray)

                    }
                    .contentShape(.rect)
                })
            }
            .overlayPreferenceValue(MAnchorKey.self, { value in
                GeometryReader(content: { geometry in
                    ForEach(profiles) {profile in
                        if let anchor = value[profile.id], selectedProfile?.id != profile.id {
                            let rect = geometry[anchor]
                            ImageView(profile:profile, size: rect.size)
                                .offset(x: rect.minX, y: rect.minY)
                                .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                        }
                    }
                })
            })
        }
    }
}

struct DetailView: View {
//    var profile: Profile
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool
    @Binding var hideView: (Bool, Bool)
    @State private var isChatViewPresented = false // 控制是否展示 ChatView
//    var size: CGSize
    var body: some View {
        if let selectedProfile {
            VStack {
                GeometryReader(content: {geometry in
                    let size = geometry.size
//                    ImageView(profile: profile, size: size)
                    
                    VStack {
                        if hideView.0 {
                            ImageView(profile: selectedProfile, size: size)
                                .overlay(alignment: .top) {
                                    ZStack{
                                        Button(action: {
                                            hideView.0 = false
                                            hideView.1 = false
                                            pushView = false
                                            DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                                                self.selectedProfile = nil
                                            }
                                        }, label: {
                                            Image(systemName: "xmark")
                                                .foregroundStyle(.white)
                                                .padding(10)
                                                .background(.black, in: .circle)
                                                .contentShape(.circle)
                                        })
                                        .padding(15)
                                        .padding(.top,40)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topTrailing)
                                        
                                        Text(selectedProfile.userName)
                                            .font(.title.bold())
                                            .foregroundColor(.black)
                                            .padding(15)
                                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomLeading)
                                    }
                                    .opacity(hideView.1 ? 1 : 0)
                                    .animation(.snappy, value: hideView.1)
                                }
                                .onAppear(perform: {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        hideView.1 = true
                                    }
                                })
                            
                        } else {
                            Color.clear
                        }
                    }
                    .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                        return [selectedProfile.id: anchor]
                    })
                    
                })
                .frame(height: 400)
                .ignoresSafeArea()

                Spacer(minLength:0)
                
                
//                Button("go"){
//                    isChatViewPresented = true
//                    
//                }
//                .sheet(isPresented: $isChatViewPresented, content: {
//                    ChatView()
//                })
//                .fullScreenCover(isPresented: $isChatViewPresented){
//                    ChatView()
//                }
                
                
//                 添加导航按钮
//                NavigationLink(destination: ChatView()) {
//                    Text("进入聊天")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
//                        .cornerRadius(15)
//                        .shadow(radius: 5)
//                        .padding(.bottom, 20)
//                        .scaleEffect(hideView.1 ? 1 : 0.9)
//                        .animation(.easeInOut(duration: 0.5), value: hideView.1)
//                }
                
                
                
                
            }
            .toolbar(hideView.0 ? .hidden : .visible, for: .navigationBar)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    hideView.0 = true
                }
            })
        }
    }
}


struct ImageView: View {
    var profile: Profile
    var size: CGSize
    var body: some View {
        Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .overlay(content: {
                LinearGradient(colors: [
                    .clear,
                    .clear,
                    .clear,
                    .white.opacity(0.1),
                    .white.opacity(0.5),
                    .white.opacity(0.9),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .opacity(size.width > 60 ? 1 : 0)
            })
            .clipShape(.rect(cornerRadius: size.width > 60 ? 0 : 30))
    }
}


#Preview {
    HeroAnimation_Content()
}
