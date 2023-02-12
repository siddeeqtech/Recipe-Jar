//
//  ScannerView.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 11/3/22.
//
import VisionKit
import SwiftUI

struct ScannerView:UIViewControllerRepresentable {
    
   final class Coordinator:NSObject,VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
        
         init(completion: @escaping ([String]?) -> Void) {
            self.completionHandler = completion
        }
       
       
       func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
           completionHandler(nil)
       }
       
       
       func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
           completionHandler(nil)
       }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }
    
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = VNDocumentCameraViewController
    
    private let completionHandler: ([String]?) -> Void
    
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler = completion
    }
}
