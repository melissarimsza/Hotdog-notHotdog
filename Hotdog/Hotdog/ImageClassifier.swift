//
//  ImageClassifier.swift
//  Hotdog
//
//  Created by Melissa Rimsza on 3/28/22.
//

import Foundation
import SwiftUI

class ImageClassifier: ObservableObject {
    @Published private var classifier = Classifier()
    
    var imageClass: String? { 
        classifier.results
    }
    
    func detect(uiImage: UIImage) {
        //check if there is an image to classify
        guard let ciImage = CIImage (image: uiImage) else {
            return
        }
        //classify the image
        classifier.detect(ciImage: ciImage)
        print(classifier.detect(ciImage: ciImage))
    }
}
