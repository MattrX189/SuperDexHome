//
//  QRCodeViewModel.swift
//  HomeScreen
//

import SwiftUI
import CoreImage.CIFilterBuiltins

@Observable
final class QRCodeViewModel {
    var profile = UserProfileData.load()

    func reloadProfile() {
        profile = UserProfileData.load()
    }

    func generateQRCode() -> UIImage? {
        let vcard = "BEGIN:VCARD\nVERSION:3.0\nFN:\(profile.name)\nTITLE:\(profile.jobRole)\nTEL:\(profile.phone)\nEMAIL:\(profile.email)\nURL:https://\(profile.github)\nEND:VCARD"
        let filter = CIFilter.qrCodeGenerator()
        guard let data = vcard.data(using: .utf8) else { return nil }
        filter.message = data
        filter.correctionLevel = "H"
        guard let ciImage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledImage = ciImage.transformed(by: transform)
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
