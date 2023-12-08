//
//  UploadView.swift
//  ogre
//
//  Created by Brian Johnson on 11/26/23.
//

import SwiftUI


struct UploadView: View {
    
    @State  var isImporting: Bool = false
    //@State  var selectedPDF: URL?
    @State var fileName = ""
    @ObservedObject var viewModel: PDFFilesViewModel = PDFFilesViewModel()

    var body: some View {
            VStack {
                    Text("Selected PDF: \(fileName)")
                    Button("Upload PDF") {
                        isImporting.toggle()
                        
                    }
                    .fileImporter(isPresented: $isImporting, allowedContentTypes: [.pdf]) { (result) in
                        do {
                            let fileUrl = try result.get()
                            print(fileUrl)
                            //gets file name
                            self.fileName = fileUrl.lastPathComponent
                            viewModel.addPDFFile(name: fileName, fileURL: fileUrl)
                        } catch {
                            print("error reading docs")
                            print(error.localizedDescription)
                        }
                    }
            }
            .padding()
        }
}
#Preview {
    UploadView()
}
