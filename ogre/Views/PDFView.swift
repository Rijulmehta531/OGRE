//
//  PDFView.swift
//  ogre
//
//  Created by Brian Johnson on 11/26/23.
//

import SwiftUI

struct PDFListView: View {
    @ObservedObject var viewModel: PDFFilesViewModel = PDFFilesViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.pdfFiles) { pdf in
                NavigationLink(destination: PDFDetailView(pdf: pdf)) {
                    Text(pdf.name)
                }
            }
            .onAppear {
                viewModel.loadPDFFiles()
                // Ensure that pdfFiles is not empty and contains the expected data
                print("Number of PDF files: \(viewModel.pdfFiles.count)")
            }
            
        }
    }

}

#Preview {
    PDFListView()
}
