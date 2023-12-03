//
//  WebView.swift
//  ogre
//
//  Created by Aaron Grizzle on 11/12/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.isInspectable = true
        webView.contentMode = .scaleToFill

        let scriptSource = """
            var katexHtmlElements = document.querySelectorAll('.katex-html');
            katexHtmlElements.forEach(function(el) {
                el.parentNode.removeChild(el);
            });
            var headerText = document.querySelectorAll('h2');
            headerText.forEach(function(el) {
                el.parentNode.removeChild(el);
            });
            """

        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        webView.configuration.userContentController.addUserScript(script)

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        let cssString = """
            <style>
                body {
                    font-size: 300%;
                    font-family: sans-serif;
                }
                img{
                    height: 400px;
                    width: 400px;
                    }
            </style>
            """
        
        let fullHTML = cssString + htmlString
        if let data = fullHTML.data(using: .utf8) {
            uiView.load(data, mimeType: "text/html", characterEncodingName: "utf-8", baseURL: Bundle.main.bundleURL)
        }
    }
}
