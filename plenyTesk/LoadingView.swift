//
//  LoadingView.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 23/09/2023.
//


import SwiftUI

enum LoadingState {
    case idle
    case loading
    case failed(String)
    case loaded
}

fileprivate let loadingText = "Loading"

struct LoadingView<Content>: View where Content: View {
    var noDataAction: () -> Void
    
    @Binding var state: LoadingState
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {
                
                switch state {
                case .idle:
                    self.content().disabled(false)
                case .loading:
                    self.content()
                        .disabled(true)
                        .blur(radius: 3 )
                    
                    VStack {
                        Text("Loading ...")
                        if #available(iOS 14.0, *) {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .black))
                        } else {
                            LoadingIndicator( style: .large)
                        }
                    }
                    .frame(width: geometry.size.width / 3.0, height: geometry.size.height / 6.0)
                    .background(Color.gray.opacity(0.4))
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .vCenter().hCenter()
                    .opacity(1)
                    
                case .failed(let error):
                      self.content()
                        .disabled(true)
                        .blur(radius: 3 )
                         
                             VStack {
                                 Text(error).padding([.top , .bottom])
//                                     .scaledFont(name: .regular , size: 20 , color: Color.theme.mainHeaderBalck)
                                     .hCenter()
                                 Button(action: {
                                     noDataAction()
                                 }) {
                                     Text("Retry")
                                         .padding(.all).hCenter()
                                         .frame(width :  geometry.size.width * 0.3)
//                                         .scaledFont(name: .medium, size: 20 , color: .white)
                                         .background(Color.blue)
                                         .cornerRadius(15)
                                 }.padding(.bottom)
                                 
                             } .frame(width : geometry.size.width * 0.7 )
                         .padding([.leading , .trailing] , 40)
                         .background(Color.secondary.colorInvert())
                         .foregroundColor(Color.primary)
                         .cornerRadius(20)
                         .opacity(1)
                                        
                case .loaded :
                    self.content().disabled(false)
                }
                  
            }
        }
    }
}


struct LoadingIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<LoadingIndicator>) -> LoadingIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ view: LoadingIndicator.UIViewType, context: UIViewRepresentableContext<LoadingIndicator>) {
            view.startAnimating()
    }
}
