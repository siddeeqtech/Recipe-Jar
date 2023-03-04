//
//  ingredientsPopoverView.swift
//  Steps Screen Recipe Jar
//
//  Created by othman shahrouri on 2/7/23.
//

import SwiftUI

//Enabling Popover for iOS
extension View{
    @ViewBuilder
    func iOSPopover<Content: View>(isPresented: Binding<Bool>,arrowDirection:UIPopoverArrowDirection,@ViewBuilder content: @escaping ()->Content) -> some View {
        self.background {
            PopOverController (isPresented: isPresented, arrowDirection:
                                arrowDirection, content: content ())
            
        }
    }
}

// Popover Helper
struct PopOverController<Content: View>: UIViewControllerRepresentable{
    
    @Binding var isPresented: Bool
    var arrowDirection: UIPopoverArrowDirection
    var content: Content
    
    func makeCoordinator () -> Coordinator {
        return Coordinator(parent: self)
    }
 
  
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented{
            // - Presenting Popover
            // let con = Representable(content: content)
            let controller = CustomHostingView (rootView: content)
            controller.view.backgroundColor = .clear
            controller.modalPresentationStyle = .popover
            controller.popoverPresentationController?.permittedArrowDirections =
            arrowDirection
            //connecting delegate
            controller.presentationController?.delegate = context.coordinator
            // - We Need to Attach the Source View So that it will show Arrow At Correct Position
            controller.popoverPresentationController?.sourceView = uiViewController.view
            uiViewController.present(controller,animated: true)
        }
    }
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController ()
        //        controller.view.backgroundColor = .clear
        //        controller.view.invalidateIntrinsicContentSize()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.setContentHuggingPriority(.required, for: .horizontal) // << here !!
        controller.view.setContentHuggingPriority(.required, for: .vertical)
        
        return controller
        
    }
    
    // - Forcing it to show Popover using PresentationDelegate
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate{
        var parent: PopOverController
        init (parent: PopOverController) {
            self.parent = parent
        }
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle{
            return .none
        }
        // - Observing The status of the Popover
        // - When it's dismissed updating the isPresented State
        func presentationControllerWillDismiss(_ presentationController:
                                               UIPresentationController) {
            parent.isPresented = false
        }
    }
    
}

// - Custom Hosting Controller for Wrapping to it's SwiftUI View Size
class CustomHostingView<Content: View>: UIHostingController<Content>{
    private var heightConstraint: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = view.intrinsicContentSize
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.invalidateIntrinsicContentSize()
    }
    
}
