

import SwiftUI
import Speech
import AVFoundation

struct SpeechRecognitionButton: View {
    @Binding var recognizedText: String
    @State private var isRecording = false
    @State private var audioEngine = AVAudioEngine()
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var selectedLocaleIdentifier = "zh-CN" // 默认语言
    @State private var showingLanguagePicker = false // 控制弹窗的状态

    var body: some View {
        Button(action: {
            if isRecording {
                stopRecording()
            } else {
                showingLanguagePicker = true // 显示语言选择弹窗
            }
        }) {
            Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(isRecording ? .red : .blue)
        }
        .actionSheet(isPresented: $showingLanguagePicker) {
            ActionSheet(title: Text("选择语言"), buttons: [

                .default(Text("粤语")) {
                    selectedLocaleIdentifier = "zh-HK"
                    startRecording() // 选择语言后开始录制
                },
                .default(Text("英语")) {
                    selectedLocaleIdentifier = "en-US"
                    startRecording() // 选择语言后开始录制
                },
                .default(Text("普通话")) {
                    selectedLocaleIdentifier = "zh-CN"
                    startRecording() // 选择语言后开始录制
                },
                .cancel()
            ])
        }
        .onAppear {
            requestSpeechAuthorization()
        }
    }
    
    private func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    print("语音识别已授权")
                case .denied:
                    print("用户拒绝了语音识别权限")
                case .restricted:
                    print("语音识别在此设备上受到限制")
                case .notDetermined:
                    print("语音识别尚未被授权")
                @unknown default:
                    print("未知的授权状态")
                }
            }
        }
    }

    private func startRecording() {
        guard !isRecording else { return }

        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("设置音频会话失败：\(error)")
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else {
            fatalError("无法创建请求对象")
        }

        recognitionRequest.shouldReportPartialResults = true

        // 使用选择的语言创建 SFSpeechRecognizer
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: selectedLocaleIdentifier))!

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false

            if let result = result {
                self.recognizedText = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.isRecording = false
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            print("音频引擎启动失败：\(error)")
        }

        recognizedText = "正在听..."
        isRecording = true
    }

    private func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        isRecording = false
    }
}





















//import SwiftUI
//import Speech
//
//struct SpeechRecognitionButton: View {
//    @Binding var recognizedText: String
//    @State private var isRecording = false
//    @State private var audioEngine = AVAudioEngine()
//    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
//    @State private var recognitionTask: SFSpeechRecognitionTask?
//    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))!
//    
//    var body: some View {
//        Button(action: {
//            if isRecording {
//                stopRecording()
//            } else {
//                startRecording()
//            }
//        }) {
//            Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 40, height: 40)
//                .foregroundColor(isRecording ? .red : .blue)
//        }
//        .onAppear {
//            requestSpeechAuthorization()
//        }
//    }
//    
//    private func requestSpeechAuthorization() {
//        SFSpeechRecognizer.requestAuthorization { authStatus in
//            OperationQueue.main.addOperation {
//                switch authStatus {
//                case .authorized:
//                    print("语音识别已授权")
//                case .denied:
//                    print("用户拒绝了语音识别权限")
//                case .restricted:
//                    print("语音识别在此设备上受到限制")
//                case .notDetermined:
//                    print("语音识别尚未被授权")
//                @unknown default:
//                    print("未知的授权状态")
//                }
//            }
//        }
//    }
//    
//    private func startRecording() {
//        guard !isRecording else { return }
//        
//        if let recognitionTask = recognitionTask {
//            recognitionTask.cancel()
//            self.recognitionTask = nil
//        }
//        
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
//            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//        } catch {
//            print("设置音频会话失败：\(error)")
//        }
//        
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//        
//        let inputNode = audioEngine.inputNode
//        guard let recognitionRequest = recognitionRequest else {
//            fatalError("无法创建请求对象")
//        }
//        
//        recognitionRequest.shouldReportPartialResults = true
//        
//        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
//            var isFinal = false
//            
//            if let result = result {
//                self.recognizedText = result.bestTranscription.formattedString
//                isFinal = result.isFinal
//            }
//            
//            if error != nil || isFinal {
//                self.audioEngine.stop()
//                inputNode.removeTap(onBus: 0)
//                self.recognitionRequest = nil
//                self.recognitionTask = nil
//                self.isRecording = false
//            }
//        }
//        
//        let recordingFormat = inputNode.outputFormat(forBus: 0)
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
//            self.recognitionRequest?.append(buffer)
//        }
//        
//        audioEngine.prepare()
//        
//        do {
//            try audioEngine.start()
//        } catch {
//            print("音频引擎启动失败：\(error)")
//        }
//        
//        recognizedText = "正在听..."
//        isRecording = true
//    }
//    
//    private func stopRecording() {
//        audioEngine.stop()
//        recognitionRequest?.endAudio()
//        isRecording = false
//    }
//}
