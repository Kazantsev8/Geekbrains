//
//  PhotoManager.swift
//  SocialApp
//
//  Created by Иван Казанцев on 19.03.2021.
//

import UIKit
import Alamofire

class PhotoService {
    private var memoryCache = [String: UIImage]()
    private let cacheLifeTime: TimeInterval = 60 * 60 * 24 * 7
    
    private let isolationQ = DispatchQueue(label: "isolation.q", qos: .default)
    
    private static let pathName: String = {
        let pathName = "Images"
        
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory,
                                                      in: .userDomainMask)
        .first else { return pathName }
        let url = cacheDir.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url,
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
        }
        
        return pathName
    }()
    
    private func getFilePath(at urlString: String) -> String? {
        
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory,
                                                      in: .userDomainMask).first,
              let fileName = urlString.split(separator: "/").last
        else { return nil }
        
        return cacheDir.appendingPathComponent(PhotoService.pathName + "/" + fileName).path
        
    }
    
    private func saveImageToFilesystemCache(urlString: String,
                                            image: UIImage) {
        guard let fileName = getFilePath(at: urlString) else { return }
        let data = image.pngData()
        FileManager.default.createFile(atPath: fileName,
                                       contents: data,
                                       attributes: nil)
    }
    
    private func getImageFromFilesystemCache(urlString: String) -> UIImage? {
        guard let fileName = getFilePath(at: urlString),
              let fileInfo = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = fileInfo[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        isolationQ.async {
            self.memoryCache[urlString] = image
        }
        return image
    }
    
    private func removeImageFromFilesystemCache(urlString: String) {
        guard let fileName = getFilePath(at: urlString),
              let url = URL(string: fileName)
        else { return }
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error)
        }
    }
    
    private func loadPhoto(urlString: String,
                           completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(urlString)
                 .responseData(queue: .global()) { [weak self] response in
                    guard let self = self,
                          let data = response.data,
                          let image = UIImage(data: data)
                    else {
                        completion(nil)
                        return
                    }
                    self.isolationQ.async {
                        self.memoryCache[urlString] = image
                    }
                    self.saveImageToFilesystemCache(urlString: urlString,
                                                    image: image)
                    completion(image)
            }
    }
    
    public func getPhoto(urlString: String,
                         completion: @escaping (UIImage?) -> Void) {
        if let image = memoryCache[urlString] {
            completion(image)
        } else if let image = getImageFromFilesystemCache(urlString: urlString) {
            completion(image)
        } else {
            loadPhoto(urlString: urlString, completion: completion)
        }
    }
}
