//
//  ContentView.swift
//  ImageViewer
//
//  Created by César Cubillos on 12/10/23.
//

import SwiftUI

struct ImageSelectorView: View {
    @StateObject var imageSelectorViewModel = ImageSelectorViewModel()
    
    var body: some View {
        if imageSelectorViewModel.isLoading {
            LoaderView().onAppear {
                Task {
                    try await imageSelectorViewModel.getImages()
                }
            }
        } else {
            NavigationView {
                List {
                    ForEach(imageSelectorViewModel.imageList, id: \.id) { imageSingle in
                        NavigationLink(
                            destination: ImageDetailView(
                                imageDetail: ImageDetailViewModel(imageSingle)
                            )
                        ){
                            ImageSelectorItemView(
                                imageItem: ImageSelectorItemViewModel(imageSingle)
                            )
                        }
                    }
                }
                .navigationTitle("Photo list")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            Task {
                                try await imageSelectorViewModel.fetchImages()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise.circle")
                        }
                    }
                }
            }
        }
       
    }
}

#Preview {
    ImageSelectorView()
}
