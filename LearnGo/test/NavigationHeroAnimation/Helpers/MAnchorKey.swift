//
//  MAnchorKey.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/17.
//

import SwiftUI

struct MAnchorKey: PreferenceKey {

    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String: Anchor<CGRect>], nextValue: () -> [String: Anchor<CGRect>]){
        value.merge(nextValue()){ $1 }
    }

    var body: some View {
        Text("")
    }
}
