//
//  ImageHelper.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/22/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation
import UIKit
/*
extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}
*/

class ImageHelper {
    
    func convertURLToImage(fromStruct: VolumeRepresentation.VolumeInfo.ImageLinks) -> UIImage {
        let urls = transformStructIntoURLs(from: fromStruct)
        let targetImageURL = validateImageURLLarge(from: urls)
        var image = UIImage()
        
        do {
            let data = try Data(contentsOf: targetImageURL)
            image = UIImage(data: data)!
        } catch {
                NSLog("Error converting URL into imagedata: \(error)")
        }
        /*
        // DispatchQueue.main.async {
            URLSession.shared.dataTask(with: targetImageURL) { (data, _, error) in
                if let error = error {
                    NSLog("Error retrieving image data from URL: \(error)")
                }
                
                if let data = data {
                    let tempImage = UIImage(data: data) // else { return }
                    image = tempImage!
                }
                }.resume()
 
 */
            return image
        // }
    }
    
    func transformStructIntoURLs(from strux: VolumeRepresentation.VolumeInfo.ImageLinks) -> [URL?] {
        var array: [URL?] = []
        if strux.smallThumbnail != nil {
            array.append(strux.smallThumbnail)
        }
        if strux.thumbnail != nil {
            array.append(strux.thumbnail)
        }
        if strux.small != nil {
            array.append(strux.small)
        }
        if strux.medium != nil {
            array.append(strux.medium)
        }
        if strux.large != nil {
            array.append(strux.large)
        }
        if strux.extraLarge != nil {
            array.append(strux.extraLarge)
        }
        return array
    }
    
    func validateImageURLLarge(from urls: [URL?]) -> (URL) {
        var validURLs = [URL]()
        for url in urls {
            if url != nil {
                validURLs.append(url!)
            }
        }
        return validURLs.last!
    }
}
