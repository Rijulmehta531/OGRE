//
//  PDFDetailView.swift
//  ogre
//
//  Created by Brian Johnson on 11/26/23.
//

import SwiftUI
import PDFKit

struct PDFDetailView: View {
    let pdf: PDFFile
    @State private var isPDFKitViewPresented = false

    var body: some View {
        VStack {
            Text("PDF Name: \(pdf.name)")
                .padding()
            Text("PDF URL: \(pdf.fileURL.path)")
                .padding()

            NavigationLink(destination: PDFKitView(document: unwrapPDFDocument()),
                           isActive: $isPDFKitViewPresented) {
                EmptyView()
            }
            .hidden()

            Button("Open PDF") {
                isPDFKitViewPresented = true
            }
            .padding()
        }
        .navigationBarTitle("PDF Detail")
    }

    private func unwrapPDFDocument() -> PDFDocument {
        guard let pdfDocument = PDFDocument(url: pdf.fileURL) else {
            // Handle the case where creating the PDFDocument fails
            print("Failed to create PDFDocument")
            // Return a default PDFDocument or handle this case as needed
            return PDFDocument()
        }
        return pdfDocument
    }
}



