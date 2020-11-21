//
//  ContentView.swift
//  QRSwift
//
//  Created by Aji_sahputra on 22/11/20.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRView: View {
  
  @State private var name="Name"
  @State private var emailaddress = "email@example.com"
  
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  var body: some View {
    NavigationView{
      VStack{
        Text("QR Code Generator")
          .font(.largeTitle)
          .bold()
        TextField("Name", text:$name)
          .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
          .textContentType(.name)
          .multilineTextAlignment(.center)
          .font(.title)
          .padding(.horizontal)
        TextField("Email Address", text:$emailaddress)
          .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
          .textContentType(.emailAddress)
          .multilineTextAlignment(.center)
          .font(.headline)
          
          .padding([.horizontal, .bottom])
          .autocapitalization(.none)
        
        Spacer()
        
        Image(uiImage: generateQRCode(from: "\(name)\n\(emailaddress)"))
          .resizable()
          .interpolation(.none)
          .scaledToFit()
          .frame(width: 200, height: 200)
        
        Spacer()
      }
    }
  }
  
  func generateQRCode(from string: String) -> UIImage {
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")
    
    if let outputImage = filter.outputImage {
      if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgImage)
      }
    }
    
    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
}

struct ContentView: View {
    var body: some View {
      QRView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
