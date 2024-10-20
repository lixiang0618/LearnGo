//
//  SpeechRecognitionView.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/17.
//

import SwiftUI

struct SpeechRecognitionView: View {
    @State private var recognizedText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("语音识别")
                .font(.largeTitle)
                .padding()
            
            Text(recognizedText)
                .padding()
                .frame(minHeight: 100)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            SpeechRecognitionButton(recognizedText: $recognizedText)
                .padding(10)
            
            Button("清除") {
                recognizedText = ""
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
#Preview {
    SpeechRecognitionView()
}
