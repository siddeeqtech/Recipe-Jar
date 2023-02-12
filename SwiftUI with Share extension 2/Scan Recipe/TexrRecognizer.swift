////
////  TexrRecognizer.swift
////  SwiftUI with Share extension 2
////
////  Created by othman shahrouri on 11/3/22.
////
//
//import Foundation
//import VisionKit
//import Vision
//
//final class TextRecognizer {
//    
//    let cameraScan: VNDocumentCameraScan
//    init(cameraScan: VNDocumentCameraScan) {
//        self.cameraScan = cameraScan
//    }
//    
//    private let queue = DispatchQueue(label:"Scan-codes",qos: .default,attributes: [],autoreleaseFrequency: .workItem)
//    
//    
//    func recognizeText(withCompletionHandler completionHandler:@escaping ([String]) -> Void){
//        queue.async {
//            let image = (0..<self.cameraScan.pageCount).compactMap {
//                self.cameraScan.imageOfPage(at:$0).cgImage
//            }
//            
//            let imageAndRequests = image.map{ (image:$0,request:VNRecognizeTextRequest()) }
//            let textPerPage = imageAndRequests.map{image,request -> String in
//             
//                let handler = VNImageRequestHandler(cgImage: image,options: [:])
//                do{
//                    try handler.perform([request])
//                    guard let obervations = request.results as?
//                }
//                
//                
//            }
//        }
//    }
//}
