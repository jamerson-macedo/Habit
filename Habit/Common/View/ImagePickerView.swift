//
//  ImagePicker.swift
//  Habit
//
//  Created by Jamerson Macedo on 10/07/24.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
  
  @Binding var image: Image?
  @Binding var imageData: Data?
  @Binding var isPresented: Bool
  
  var sourceType: UIImagePickerController.SourceType = .photoLibrary
  
  func makeCoordinator() -> ImagePickerViewCoordinator {
    return ImagePickerViewCoordinator(image: $image, imageData: $imageData, isPresented: $isPresented)
  }
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let pickerController = UIImagePickerController()
      pickerController.allowsEditing = true
      if !UIImagePickerController.isSourceTypeAvailable(sourceType){
          pickerController.sourceType = .photoLibrary
      }else {
          pickerController.sourceType = .camera
      }
      
      
      pickerController.delegate = context.coordinator
      
      
      
    
    return pickerController
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
      
  }
  
}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  @Binding var image: Image?
  @Binding var imageData: Data?
  @Binding var isPresented: Bool
  
  init(image: Binding<Image?>, imageData: Binding<Data?>, isPresented: Binding<Bool>) {
    self._image = image
    self._imageData = imageData
    self._isPresented = isPresented
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
          let width:CGFloat = 420.0// largura que quero
          let canvas = CGSize(width: width, height: CGFloat(ceil(width / image.size.width * image.size.height))) //configurando a largura
          let imgResized = UIGraphicsImageRenderer(size: canvas, format: image.imageRendererFormat).image{_ in
              image.draw(in: CGRect(origin: .zero, size: canvas))
              
          }
          self.image = Image(uiImage: imgResized)
          self.imageData = imgResized.jpegData(compressionQuality: 0.2)
          
    }
    self.isPresented = false
      
      
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.isPresented = false
  }
  
}

