//
//  FilteredImageBuilder.swift
//  Facesnap
//
//  Created by Florian Thompson on 03/09/16.
//  Copyright © 2016 Florian Thompson. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

final class FilteredImageBuilder {
    
    private struct PhotoFilter {
        
        static let ColorClamp = "CIColorClamp"
        static let ColorControls = "CIColorControls"
        static let PhotoEffectInstant = "CIPhotoEffectInstant"
        static let PhotoEffectProcess = "CIPhotoEffectProcess"
        static let PhotoEffectNoir = "CIPhotoEffectNoir"
        static let Sepia = "CISepiaTone"
        
        static func defaultFilters() -> [CIFilter] {
            
            // Color Clamp
            let colorClamp = CIFilter(name: PhotoFilter.ColorClamp)!
            colorClamp.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2), forKey: "inputMinComponents")
            colorClamp.setValue(CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9), forKey: "inputMaxComponents")
            
            // Color Controls
            let colorControls = CIFilter(name: PhotoFilter.ColorControls)!
            colorControls.setValue(0.1, forKey: kCIInputSaturationKey)
            
            // Photo Effects
            let photoEffectInstant = CIFilter(name: PhotoFilter.PhotoEffectInstant)!
            let photoEffectProcess = CIFilter(name: PhotoFilter.PhotoEffectProcess)!
            let photoEffectNoir = CIFilter(name: PhotoFilter.PhotoEffectNoir)!
            
            // Sepia
            let sepia = CIFilter(name: PhotoFilter.Sepia)!
            sepia.setValue(0.7, forKey: kCIInputIntensityKey)
            
            
            return [colorClamp, colorControls, photoEffectInstant, photoEffectProcess, photoEffectNoir, sepia]
        }
    }
    
    private let image: UIImage
    private let context: CIContext
    
    init(image: UIImage, context: CIContext) {
        self.image = image
        self.context = context
    }
    
    func imageWithDefaultFilters() -> [CIImage] {
        return image(withFilters: PhotoFilter.defaultFilters())
    }
    
    func image(withFilters filters: [CIFilter]) -> [CIImage] {
        return filters.map { image(self.image, withFilter: $0) }
    }
    
    func image(image: UIImage, withFilter filter: CIFilter) -> CIImage {
        let inputImage = image.CIImage ?? CIImage(image: image)!.imageByApplyingOrientation(imageOrientationToTiffOrientation(image.imageOrientation))
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let outputImage = filter.outputImage!
        
        return outputImage.imageByCroppingToRect(inputImage.extent)
    }
    
    func imageOrientationToTiffOrientation(value: UIImageOrientation) -> Int32
    {
        switch (value)
        {
        case UIImageOrientation.Up:
            return 1
        case UIImageOrientation.Down:
            return 3
        case UIImageOrientation.Left:
            return 8
        case UIImageOrientation.Right:
            return 6
        case UIImageOrientation.UpMirrored:
            return 2
        case UIImageOrientation.DownMirrored:
            return 4
        case UIImageOrientation.LeftMirrored:
            return 5
        case UIImageOrientation.RightMirrored:
            return 7
        }
    }
    
}
