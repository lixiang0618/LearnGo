


import SwiftUI
import PDFKit

// 单例类：PDFReader，用于选择 PDF 文件并提取其内容
class PDFReader: NSObject, UIDocumentPickerDelegate {
    static let shared = PDFReader()

    private var completionHandler: ((String) -> Void)?

    private override init() {
        super.init()
    }

    // 外部可以调用该方法来选择 PDF 文件，并传入一个回调闭包来接收提取的文本内容
    func selectAndExtractPDFFile(completion: @escaping (String) -> Void) {
        self.completionHandler = completion
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
        documentPicker.delegate = self
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
    }

    // 提取 PDF 文件中的文本
    private func extractText(from url: URL) {
        if let pdfDocument = PDFDocument(url: url) {
            var fullText = ""
            for pageIndex in 0..<pdfDocument.pageCount {
                if let page = pdfDocument.page(at: pageIndex), let pageText = page.string {
                    fullText += pageText
                }
            }
            DispatchQueue.main.async {
                // 调用传入的回调闭包，将提取的文本传递出去
                self.completionHandler?(fullText)
            }
        }
    }

    // UIDocumentPickerDelegate 方法：处理文档选择后的操作
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        extractText(from: url)
    }
}

















//import SwiftUI
//import PDFKit
//
//// 单例类：PDFReader，用于选择 PDF 文件并提取其内容
//class PDFReader: NSObject, ObservableObject, UIDocumentPickerDelegate {
//    static let shared = PDFReader()
//    @Published var extractedText: String = ""
//
//    private override init() {
//        super.init()
//    }
//
//    // 外部可以调用该方法来选择 PDF 文件
//    func selectAndPrintPDFFile() {
//        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
//        documentPicker.delegate = self
//        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
//    }
//
//    // 提取 PDF 文件中的文本
//    private func extractText(from url: URL) {
//        if let pdfDocument = PDFDocument(url: url) {
//            var fullText = ""
//            for pageIndex in 0..<pdfDocument.pageCount {
//                if let page = pdfDocument.page(at: pageIndex), let pageText = page.string {
//                    fullText += pageText
//                }
//            }
//            DispatchQueue.main.async {
//                self.extractedText = fullText
//                self.printExtractedText()
//            }
//        }
//    }
//
//    // 打印提取的 PDF 文本内容
//    private func printExtractedText() {
//        print(extractedText)
//    }
//
//    // UIDocumentPickerDelegate 方法：处理文档选择后的操作
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard let url = urls.first else { return }
//        extractText(from: url)
//    }
//}
//
//// PDFReaderView：一个简单的 SwiftUI 视图，用于展示 PDFReader 的功能
//struct PDFReaderView: View {
//    var body: some View {
//        VStack {
//            Button("选择并打印 PDF 文件") {
//                PDFReader.shared.selectAndPrintPDFFile()
//            }
//            .padding()
//        }
//    }
//}
//
//struct PDFReaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFReaderView()
//    }
//}










//import SwiftUI
//import PDFKit
//
//struct PDFTextExtractorView: View {
//    @State private var extractedText = ""
//    @State private var showDocumentPicker = false
//
//    var body: some View {
//        VStack {
//            Button("选择 PDF 文件") {
//                showDocumentPicker = true
//            }
//            .padding()
//
//            ScrollView {
//                Text(extractedText)
//                    .padding()
//            }
//        }
//        .sheet(isPresented: $showDocumentPicker) {
//            DocumentPicker(extractedText: $extractedText)
//        }
//    }
//}
//
//struct DocumentPicker: UIViewControllerRepresentable {
//    @Binding var extractedText: String
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
//        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
//        documentPicker.delegate = context.coordinator
//        return documentPicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
//        // No updates needed
//    }
//
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        var parent: DocumentPicker
//
//        init(_ parent: DocumentPicker) {
//            self.parent = parent
//        }
//
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            guard let url = urls.first else { return }
//            extractText(from: url)
//        }
//
//        private func extractText(from url: URL) {
//            if let pdfDocument = PDFDocument(url: url) {
//                var fullText = ""
//                for pageIndex in 0..<pdfDocument.pageCount {
//                    if let page = pdfDocument.page(at: pageIndex), let pageText = page.string {
//                        fullText += pageText
//                    }
//                }
//                DispatchQueue.main.async {
//                    self.parent.extractedText = fullText
//                }
//            }
//        }
//    }
//}
//
//struct PDFTextExtractorView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFTextExtractorView()
//    }
//}
