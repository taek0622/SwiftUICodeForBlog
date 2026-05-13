//
//  ImageFormatCovertView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 7/25/24.
//

import SwiftUI
import PhotosUI

struct ImageFormatCovertView: View {

    enum OutputFormat: String, CaseIterable, Identifiable {
        var id: Self { self }

        case jpg = "JPG"
        case png = "PNG"
        case heic = "HEIC"
    }

    @State private var selectedImage = [PhotosPickerItem]()
    @State private var selectedImageData = UIImage(systemName: "photo.badge.plus")?.jpegData(compressionQuality: 0)
    @State private var selectedUIImage = UIImage(systemName: "photo.badge.plus")
    @State private var outputFormat: OutputFormat = .jpg
    @State private var outputData = UIImage(systemName: "photo.badge.plus")!.jpegData(compressionQuality: 0)!

    var body: some View {
        VStack {
            HStack {
                Text("현재 파일 확장자")
                Text("")
                Spacer()
            }
            HStack {
                Text("변환할 파일 확장자")
                Menu(outputFormat.rawValue) {
                    ForEach(OutputFormat.allCases) { format in
                        Button(action: {
                            outputFormat = format
                        }, label: {
                            Text(format.rawValue)
                        })
                    }
                }
                .menuStyle(ButtonMenuStyle())
                Spacer()
            }
            Image(uiImage: selectedUIImage!)
                .resizable()
                .scaledToFit()
        }
        .padding(16)
        .toolbar(content: {
            PhotosPicker(selection: $selectedImage, maxSelectionCount: 1) {
                Image(systemName: "photo.badge.plus")
            }

            ShareLink(item: outputData, preview: SharePreview("dddd", image: Image(systemName: "photo.badge.plus"))) {
                Image(systemName: "square.and.arrow.up")
            }
        })
        .onChange(of: selectedImage) { _, items in
            Task {
                if let data = try? await items[0].loadTransferable(type: Data.self) {
                    selectedImageData = data
                }

                if let selectedImageData {
                    selectedUIImage = UIImage(data: selectedImageData)
                }

                if let selectedUIImage {
                    switch outputFormat {
                    case .jpg:
                        outputData = selectedUIImage.jpegData(compressionQuality: 0) ?? UIImage(systemName: "photo.badge.plus")!.jpegData(compressionQuality: 0)!
                    case .png:
                        outputData = selectedUIImage.pngData() ?? UIImage(systemName: "photo.badge.plus")!.pngData()!
                    case .heic:
                        outputData = selectedUIImage.heicData() ?? UIImage(systemName: "photo.badge.plus")!.heicData()!
                    }
                }
            }
        }
        .onChange(of: outputFormat) { _, format in
            switch format {
            case .jpg:
                outputData = selectedUIImage!.jpegData(compressionQuality: 0) ?? UIImage(systemName: "photo.badge.plus")!.jpegData(compressionQuality: 0)!
            case .png:
                outputData = selectedUIImage!.pngData() ?? UIImage(systemName: "photo.badge.plus")!.pngData()!
            case .heic:
                outputData = selectedUIImage!.heicData() ?? UIImage(systemName: "photo.badge.plus")!.heicData()!
            }
        }
    }
}

#Preview {
    NavigationStack {
        ImageFormatCovertView()
    }
}
