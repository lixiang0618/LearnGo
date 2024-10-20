//
//  NavigationHeroAnimation_Content.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/17.
//

import SwiftUI

struct HeroAnimation_Content: View {
    @State private var selectedProfile: Profile?
    @State private var pushView: Bool = false
    @State private var hideView: (Bool, Bool) = (false, false)
    var body: some View {
        NavigationStack {
            Home(selectedProfile: $selectedProfile, pushView: $pushView)
                .navigationTitle("Profile")
                .navigationDestination(isPresented: $pushView) {
                    if let selectedProfile {
                        DetailView(
                            selectedProfile: $selectedProfile,
                            pushView: $pushView,
                            hideView: $hideView
                        )
                    }
                }
        }
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
                if let selectedProfile, let anchor = value[selectedProfile.id], !hideView.0 {
                    let rect = geometry[anchor]
                    ImageView(profile: selectedProfile, size: rect.size)
                        .offset(x: rect.minX, y: rect.minY)
                        .animation(.snappy(duration: 0.35,extraBounce: 0), value: rect)
                }
            })
        })
    }
}
#Preview {
    HeroAnimation_Content()
}
