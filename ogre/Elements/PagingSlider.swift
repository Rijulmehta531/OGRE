//
//  PagingSlider.swift
//  OGRE Prototype
//
//  Created by Brian Johnson on 10/13/23.
//

import SwiftUI
struct Item: Identifiable {
    private(set) var id: UUID = .init()
    var buttonEmoji: String
    var title: String
    var selectedTitle: String
    var subTitle: String
    var isTapped: Bool
}
struct PagingSlider<Content: View, TitleContent: View, Item: RandomAccessCollection>: View where Item: MutableCollection, Item.Element: Identifiable{
    var pagingControlSpacing: CGFloat = 20
    var spacing: CGFloat = 10
    var titleScrollSpeed: CGFloat = 0.6
    var showPagingControl: Bool = true
    
    @Binding var data: Item
    @ViewBuilder var content: (Binding<Item.Element>) -> Content
    @ViewBuilder var titleContent: (Binding<Item.Element>) -> TitleContent
    @State private var activeID: UUID?
    
    var body: some View {
        VStack(spacing: pagingControlSpacing){
            ScrollView(.horizontal) {
                HStack(spacing: spacing) {
                    ForEach($data) { item in
                        VStack(spacing: 0) {
                            titleContent(item)
                                .frame(maxWidth: .infinity)
                                .visualEffect { content, geometryProxy in
                                    content
                                        .offset(x: scrollOffset(geometryProxy))
                                    
                                }
                            content(item)
                        }
                        .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeID)
            if showPagingControl {
                PagingControl(numberOfPages: data.count, activePage: activePage) { value in
                    if let index = value as? Item.Index, data.indices.contains(index) {
                        if let id = data[index].id as? UUID {
                            withAnimation(.snappy(duration: 0.35, extraBounce: 0)) {
                                activeID = id
                            }
                        }
                    }
                }
            }
        }
    }
    
    var activePage: Int {
        if let index = data.firstIndex(where: { $0.id as? UUID == activeID}) as? Int {
            return index
        }
        return 0
    }
    
        func scrollOffset(_ proxy: GeometryProxy) -> CGFloat{
            let minX = proxy.bounds(of: .scrollView)?.minX ?? 0
            
            return -minX * min(titleScrollSpeed,1.0)
        }
    }
    struct PagingControl: UIViewRepresentable {
        var numberOfPages: Int
        var activePage: Int
        var onPageChange: (Int) -> ()
        func makeCoordinator() -> Coordinator {
            return Coordinator(onPageChange: onPageChange)
        }
        func makeUIView(context: Context) -> some UIPageControl {
            let view = UIPageControl()
            view.currentPage = activePage
            view.numberOfPages = numberOfPages
            view.backgroundStyle = .prominent
            view.currentPageIndicatorTintColor = UIColor(Color.primary)
            view.pageIndicatorTintColor = UIColor.placeholderText
            view.addTarget(context.coordinator, action: #selector(Coordinator.onPageUpdate(control:)), for: .valueChanged)
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
            uiView.numberOfPages = numberOfPages
            uiView.currentPage = activePage
        }
        class Coordinator: NSObject {
            var onPageChange: (Int) -> ()
            init(onPageChange: @escaping (Int) -> Void) {
                self.onPageChange = onPageChange
            }
            @objc
            func onPageUpdate(control: UIPageControl) {
                onPageChange(control.currentPage)
            }
        }
    }
    
    #Preview {
        MainMenuView()
    }

