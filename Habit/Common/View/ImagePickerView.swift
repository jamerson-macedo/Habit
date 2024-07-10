//
//  ImagePicker.swift
//  Habit
//
//  Created by Jamerson Macedo on 10/07/24.
//

import Foundation
import UIKit
import SwiftUI
struct ImagePickerView :UIViewControllerRepresentable {
    @Binding var isPresented : Bool // aqui esta o sholdpresentecamera
    @Binding var image : Image?
    @Binding var imageData : Data?
    var sourceType : UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        if !UIImagePickerController.isSourceTypeAvailable(sourceType){ // se a camera não estiver disponivel
            pickerController.sourceType = .photoLibrary
            
        }else {
            pickerController.sourceType = sourceType
        }
        
        pickerController.delegate = context.coordinator // manda para a classe uiimagepicler controle
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        // define uma classe para controlar os eventos de inputs
        return ImagePickerViewCoordinator(image: $image, imageData: $imageData, isPresented: $isPresented)
    }
    
}

class ImagePickerViewCoordinator : NSObject, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    @Binding var isPresented : Bool
    @Binding var image : Image?
    @Binding var imageData : Data?
    init(image : Binding<Image?> ,imageData : Binding<Data?>, isPresented: Binding<Bool>) {
        self._image = image
        self._imageData = imageData // binarios para mandar para o servidor
        self._isPresented = isPresented // o _por causa do binding
       
      
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.image = Image(uiImage: image)
            self.imageData = image.jpegData(compressionQuality: 0.5) // comprimindo
            
        }
        self.isPresented = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false // aqui notifica a ui de que a variavel é falsa agora
    }
    
    
}
