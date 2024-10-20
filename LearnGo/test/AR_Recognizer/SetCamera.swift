//
//  SetCamera.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/20.
//

import SwiftUI


struct SetCamera: View {
    @State private var recognizedObject: String?
    @State private var isCameraActive: Bool = false
    
    var body: some View {
        VStack {
            CameraView(recognizedObject: $recognizedObject, isCameraActive: $isCameraActive)
                .frame(height: 400)
            
            if let objectName = recognizedObject {
                Text("Recognized Object: \(objectName)")
                    .font(.headline)
                    .padding()
            } else {
                Text("No object recognized yet.")
                    .font(.headline)
                    .padding()
            }
            
            Button(action: {
                isCameraActive.toggle()
            }) {
                Text(isCameraActive ? "Stop Camera" : "Start Camera")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}


#Preview {
    SetCamera()
}
