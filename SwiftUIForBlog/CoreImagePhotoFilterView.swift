//
//  CoreImagePhotoFilterView.swift
//  SwiftUIForBlog
//
//  Created by 김민택 on 3/17/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import CoreTransferable
import PhotosUI
import SwiftUI

struct CoreImagePhotoFilterView: View {

    enum PhotoFilter: String, CaseIterable, Identifiable {
        var id: Self { self }

        case none = "필터 없음"
        case bokehBlur = "보케 블러"
        case bloom = "블룸"
        case colorInvert = "색 반전"
        case falseColor = "가색상"
        case sepia = "세피아 톤"
        case convolution7X7 = "컨볼루션 7X7"
        case gaborGradients = "가버 그레디언트"
        case kaleidoscope = "만화경"
    }

    @State private var selectedItem = [PhotosPickerItem]()
    @State private var selectedImageData: Data? = nil
    @State private var showingImage: Image?
    @State private var photoFilter: PhotoFilter = .none

    let context = CIContext()

    var body: some View {
        ZStack {
            VStack {
                showingImage?
                    .resizable()
                    .scaledToFit()
            }
            VStack {
                HStack {
                    Menu(photoFilter.rawValue) {
                        ForEach(PhotoFilter.allCases) { filter in
                            Button(action: {
                                photoFilter = filter
                            }, label: {
                                Text(filter.rawValue)
                            })
                        }
                    }
                    .menuStyle(ButtonMenuStyle())
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .toolbar(content: {
            PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, matching: .images) {
                Image(systemName: "photo.badge.plus")
            }
            Image(systemName: "square.and.arrow.up")
        })
        .onChange(of: selectedItem) { item in
            Task {
                if let data = try? await item[0].loadTransferable(type: Data.self) {
                    selectedImageData = data
                }

                if photoFilter != .none {
                    photoFilter = .none
                } else {
                    if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                        showingImage = Image(uiImage: uiImage)
                    }
                }
            }
        }
        .onChange(of: photoFilter) { filter in
            Task {
                switch filter {
                case .none:
                    if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                        showingImage = Image(uiImage: uiImage)
                    }
                case .bokehBlur:
                    if let selectedImageData, let ciImage = CIImage(data: selectedImageData) {
                        showingImage = bokehBlur(ciImage, radius: 20, ringSize: 0.1, ringAmount: 0.5, softness: 1)
                    }
                case .bloom:
                    if let selectedImageData, let ciImage = CIImage(data: selectedImageData) {
                        showingImage = bloomFilter(ciImage, intensity: 1, radius: 10)
                    }
                case .colorInvert:
                    if let selectedImageData, let ciImage = CIImage(data: selectedImageData) {
                        showingImage = colorInvert(ciImage)
                    }
                case .falseColor:
                    if let selectedImageData, let ciImage = CIImage(data: selectedImageData) {
                        showingImage = falseColor(ciImage)
                    }
                case .sepia:
                    if let selectedImageData, let ciImage = CIImage(data: selectedImageData) {
                        showingImage = sepiaFilter(ciImage, intensity: 0.9)
                    }
                case .convolution7X7:
                    if let selectedImageData, let ciImage = CIImage(data: selectedImageData) {
                        showingImage = convolution7X7(ciImage)
                    }
                case .gaborGradients:
                    if let selectedImageData, let ciImage = CIImage(data: selectedImageData) {
                        showingImage = gaborGradients(ciImage)
                    }
                case .kaleidoscope:
                    if let selectedImageData, let ciImage = CIImage(data: selectedImageData) {
                        showingImage = kaleidoscope(ciImage, count: 6, angle: 0)
                    }
                }
            }
        }
    }
}

extension CoreImagePhotoFilterView {

    func filteredImage(_ image: CIImage) -> Image? {
        guard let cgImage = context.createCGImage(image, from: image.extent) else { return nil }
        let uiImage = UIImage(cgImage: cgImage)

        return Image(uiImage: uiImage)
    }

    func bokehBlur(_ image: CIImage, radius: Float, ringSize: Float, ringAmount: Float, softness: Float) -> Image? {
        let filter = CIFilter.bokehBlur()

        filter.radius = radius
        filter.ringSize = ringSize
        filter.ringAmount = ringAmount
        filter.softness = softness
        filter.inputImage = image

        return filteredImage(filter.outputImage ?? image)
    }

    func bloomFilter(_ image: CIImage, intensity: Float, radius: Float) -> Image? {
        let filter = CIFilter.bloom()

        filter.intensity = intensity
        filter.radius = radius
        filter.inputImage = image

        return filteredImage(filter.outputImage ?? image)
    }

    func colorInvert(_ image: CIImage) -> Image? {
        let filter = CIFilter.colorInvert()

        filter.inputImage = image

        return filteredImage(filter.outputImage ?? image)
    }

    func falseColor(_ image: CIImage) -> Image? {
        let filter = CIFilter.falseColor()

        filter.color0 = CIColor(red: 1, green: 1, blue: 0)
        filter.color1 = CIColor(red: 0, green: 0, blue: 1)
        filter.inputImage = image

        return filteredImage(filter.outputImage ?? image)
    }

    func sepiaFilter(_ image: CIImage, intensity: Float) -> Image? {
        let filter = CIFilter.sepiaTone()

        filter.intensity = intensity
        filter.inputImage = image

        return filteredImage(filter.outputImage ?? image)
    }

    func convolution7X7(_ image: CIImage) -> Image? {
        let filter = CIFilter.convolution7X7()
        let weights: [CGFloat] = [0, 0, -1, -1, -1, 0, 0,
                                  0, -1, -3, -3, -3, -1, 0,
                                  -1, -3, 0, 7, 0, -3, -1,
                                  -1, -3, 7, 25, 7, -3, -1,
                                  -1, -3, 0, 7, 0, -3, -1,
                                  0, -1, -3, -3, -3, -1, 0,
                                  0, 0, -1, -1, -1, 0, 0]
        let kernel = CIVector(values: weights, count: 49)
        filter.weights = kernel
        filter.bias = 0.0
        filter.inputImage = image

        return filteredImage(filter.outputImage ?? image)
    }

    func gaborGradients(_ image: CIImage) -> Image? {
        let filter = CIFilter.gaborGradients()

        filter.inputImage = image

        return filteredImage(filter.outputImage ?? image)
    }

    func kaleidoscope(_ image: CIImage, count: Int, angle: Float) -> Image? {
        let filter = CIFilter.kaleidoscope()

        filter.count = count
        filter.center = CGPoint(x: 150, y: 150)
        filter.angle = angle
        filter.inputImage = image

        return filteredImage(filter.outputImage ?? image)
    }

}

#Preview {
    NavigationStack {
        CoreImagePhotoFilterView()
    }
}
