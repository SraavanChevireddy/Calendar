//
//  BottomSheetView.swift
//  MESForGlobal
//
//  Created by Apple on 16/12/21.
//
// Refernce link
//https://www.youtube.com/watch?v=rQKT7tn4uag


import SwiftUI

extension View{
    
    func halfSheet<T:View>(showSheet:Binding<Bool>, @ViewBuilder halfSheet: @escaping()->T, onEnd: (()->())? = nil )-> some View{
        return self
            .background(
                HalfSheetHelper(sheetView: halfSheet(), showSheet: showSheet, onEnd: onEnd)
            )
    }
}

struct HalfSheetHelper<T: View>: UIViewControllerRepresentable{
    
    var sheetView : T
    let controller = UIViewController()
    @Binding var showSheet: Bool
    var onEnd: (()->())? = nil
    

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showSheet{
            let sheetController = CustomHOstingController(rootView: sheetView)
            uiViewController.present(sheetController, animated: true)
            DispatchQueue.main.async {
                self.showSheet.toggle()
            }
        }
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate{
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper){
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            (parent.onEnd ?? {})()
        }
    }
}


// Class Custom hosting controller
class CustomHOstingController<Content: View>: UIHostingController<Content>{
    
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
            presentationController.preferredCornerRadius = 15
        }
        
    }
}

