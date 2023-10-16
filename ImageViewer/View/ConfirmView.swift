//
//  ConfirmView.swift
//  ImageViewer
//
//  Created by César Cubillos on 15/10/23.
//

import SwiftUI

struct ConfirmView: View {
    var text: String
    var actionButtonOk: () -> Void
    var actionButtonCancel: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            Text(text)
            Divider()
            HStack(spacing: 20){
                Button("Si", action: actionButtonOk).border(.black)
                Button("No", action: actionButtonCancel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(kMainColor)
        .opacity(0.8)
    }
}

#Preview {
    ConfirmView(text: "¿Deseas eliminar la imagen?"){
        
    } actionButtonCancel: {
        
    }
}
