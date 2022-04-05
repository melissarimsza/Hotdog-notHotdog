//
//  Classifier.swift
//  Hotdog
//
//  Created by Melissa Rimsza on 3/28/22.
//

import Foundation
import CoreML
import Vision
import CoreImage

struct Classifier {
    
    private(set) var results: String?
    
    mutating func detect(ciImage: CIImage) {
        
        //instaniate the model
        guard let model = try? VNCoreMLModel(for: MobileNetV2(configuration: MLModelConfiguration()).model)
        else {
            return
        }
        
        //create the model request and handler
        let request = VNCoreMLRequest(model: model)
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        do {
            try handler.perform([request])
            
        } catch {
            print("peform throws error")
            print(error)
        }
        
        guard let results = request.results as? [VNClassificationObservation] else {
            print("VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }
        
        if let firstResult = results.first {
            //assigning the classification to results
            self.results = firstResult.identifier
            print("printing self.results: ")
            print(firstResult.identifier)
            
            //creating the display info
            if (firstResult.identifier == "hotdog, hot dog, red hot") {
                self.results = "🌭"
            }
            else {
                self.results = "❌🌭"
            }
        }
        
    }
}
