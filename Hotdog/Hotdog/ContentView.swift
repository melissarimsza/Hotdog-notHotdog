//
//  ContentView.swift
//  Hotdog
//
//  Created by Melissa Rimsza on 3/28/22.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    //declaring State and ObservedObject objects
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @ObservedObject var classifier: ImageClassifier
    @State var counter:Int = 0
    
    var body: some View {
        ZStack{
            //upper confetti cannon
            ConfettiCannon(counter: $counter, num: 25, confettis: [.text("🌭"), .text("🧡")], colors: [.yellow, .orange], confettiSize: 25.0, rainHeight: 600.0, fadesOut: true, opacity: 1.0, openingAngle: Angle.degrees(60), closingAngle: Angle.degrees(120), radius: 400.0, repetitions: 0, repetitionInterval: 1.0)

            VStack{
                //title
                Text("Hotdog?")
                    .font(.title)
                    .bold()
                    .foregroundColor(.orange)
                    .onTapGesture {
                        counter+=1
                    }
                //border rectangle
                Rectangle()
                    .strokeBorder()
                    .foregroundColor(.orange)
                    .overlay(
                        Group {
                            if uiImage != nil {
                                Image(uiImage: uiImage!)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    )
                
                Group {
                    //if the image is present, show the classification
                    if let imageClass = classifier.imageClass {
                        HStack{
                            Text(imageClass)
                                .font(.system(size: 50))
                                .bold()
                                .foregroundColor(.orange)
                        }
                    //otherwise show an empty string
                    } else {
                        HStack{
                            Text(" ")
                                .font(.system(size: 50))
                                .bold()
                                .foregroundColor(.orange)
                        }
                    }
                }
                
                //lower confetti cannon
                ConfettiCannon(counter: $counter, num: 25, confettis: [.text("🌭"), .text("🧡")], colors: [.yellow, .orange], confettiSize: 25.0, rainHeight: 600.0, fadesOut: true, opacity: 1.0, openingAngle: Angle.degrees(60), closingAngle: Angle.degrees(120), radius: 400.0, repetitions: 0, repetitionInterval: 1.0)
                
                Spacer()
                
                HStack{
                    //button to choose photo from camera roll
                    Image(systemName: "photo")
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .photoLibrary
                        }
                        .foregroundColor(.orange)
                    //button to take photo
                    Image(systemName: "camera")
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .camera
                        }
                        .foregroundColor(.orange)
                }
                .font(.title)
                .foregroundColor(.orange)
            }
            .sheet(isPresented: $isPresenting){
                ImagePicker(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                    .onDisappear{
                        if uiImage != nil {
                            classifier.detect(uiImage: uiImage!)
                        }
                        if classifier.imageClass == "🌭" {
                            counter+=1
                        }
                    }
            }
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(classifier: ImageClassifier())
    }
}
