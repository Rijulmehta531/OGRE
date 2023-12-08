//
//  CommunityView.swift
//  ogre
//
//  Created by Brian Johnson on 11/26/23.
//

import SwiftUI
import UniformTypeIdentifiers
import Combine
import Foundation
import PDFKit

struct PDFFile: Codable, Identifiable {
    var id = UUID()
    var name: String
    var fileURL: URL
}

class PDFFilesViewModel: ObservableObject {
    @Published var pdfFiles: [PDFFile] = []

    func addPDFFile(name: String, fileURL: URL) {
        let newPDF = PDFFile(name: name, fileURL: fileURL)
        pdfFiles.append(newPDF)
        savePDFFiles()
    }

    func savePDFFiles() {
        do {
            let data = try JSONEncoder().encode(pdfFiles)
            UserDefaults.standard.set(data, forKey: "pdfFiles")
        } catch {
            print("Error encoding PDF files: \(error.localizedDescription)")
        }
    }

    func loadPDFFiles() {
        if let data = UserDefaults.standard.data(forKey: "pdfFiles") {
            do {
                let newPDFFiles = try JSONDecoder().decode([PDFFile].self, from: data)
                pdfFiles.append(contentsOf: newPDFFiles)
            } catch {
                print("Error decoding PDF files: \(error.localizedDescription)")
            }
        }
    }
}
struct PDFKitView: UIViewRepresentable {
    let document: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Update the view if needed
    }
}


struct CommunityView: View {
    @State var fileName = ""
    @State var openFile = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("\nCommunity Upload ")
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 16)
                .foregroundColor(.white)
                .background(.purple)
                Spacer()
            TabView {
                        UploadView()
                            .tabItem {
                                Label("Upload", systemImage: "square.and.arrow.up")
                            }

                        PDFListView()
                            .tabItem {
                                Label("PDF Files", systemImage: "doc.text.magnifyingglass")
                            }
                    }
    
        }
    }
}

#Preview {
    CommunityView()
}
