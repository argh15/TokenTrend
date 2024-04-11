//
//  LocalFileManager.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/10/24.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init () { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // creates a folder, 1st run of application or deletion of folder
        createFolderIfNeeded(folderName: folderName)
        
        // gets path for image
        guard
            let imageData = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        // saves image to path
        do {
            try imageData.write(to: url)
        } catch let error {
            print("Error saving the image for Image: \(imageName), \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path())
        else { return nil }
        
        return UIImage(contentsOfFile: url.path())
        
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating the directory for folder: \(folderName), \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        return url.appending(path: folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        
        guard let url = getURLForFolder(folderName: folderName)
        else { return nil }
        return url.appending(path: imageName + ".png")
    }
}
