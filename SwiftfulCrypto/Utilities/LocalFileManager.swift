//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 14/02/2022.
//

import SwiftUI

class LocalFileManager {
  static let instance = LocalFileManager()
  private init() { }

  func saveImage(image: UIImage, name: String, folder: String) {
    createFolderIfNeeded(folderName: folder)

    guard
      let data = image.pngData(),
      let url = getURLForImage(imageName: name, folderName: folder)
    else { return }

    do {
      try data.write(to: url)
    } catch {
      print("Error saving image ", name, ": ", error.localizedDescription)
    }
  }

  func getImage(imageName: String, folderName: String) -> UIImage? {
    guard
      let url = getURLForImage(imageName: imageName, folderName: folderName),
      FileManager.default.fileExists(atPath: url.path)
    else {
      return nil
    }
    return UIImage(contentsOfFile: url.path)
  }

  private func createFolderIfNeeded(folderName: String) {
    guard let url = getURLForFolder(folderName: folderName) else { return }

    if !FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
      } catch {
        print("Error creating directory ", folderName, ": ", error.localizedDescription)
      }
    }
  }

  private func getURLForFolder(folderName: String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
      return nil
    }
    return url.appendingPathComponent(folderName)
  }

  private func getURLForImage(imageName: String, folderName: String) -> URL? {
    guard let url = getURLForFolder(folderName: folderName) else {
      return nil
    }
    return url.appendingPathComponent(imageName + ".png")
  }
}
