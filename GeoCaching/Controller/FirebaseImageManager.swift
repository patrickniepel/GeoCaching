//
//  FirebaseImageManager.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

struct FirebaseImageManager {
    var imageStorage: StorageReference!
    private var imageDownloadTask: StorageDownloadTask?
    var database: Database {
        didSet {
            initializeDatabase()
        }
    }
    
    init(database: Database) {
        self.database = database
        initializeDatabase()
    }
    
    private mutating func initializeDatabase() {
        imageStorage = Storage.storage().reference().child(database.dbName)
    }
    
    
    // MARK: - Upload
    
    func upload(image: UIImage, withImageName imageName: String, completion: @escaping (Error?) -> ()) {
        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
            let fileName = "\(imageName).jpg"
            let imageRef = imageStorage.child(fileName)
            
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                completion(error)
            }
        }
    }
    
    
    // MARK: - Download
    
    mutating func download(imageWithName imageName: String, completion: @escaping (UIImage?) -> ()) {
        let fileName = "\(imageName).jpg"
        let imageRef = imageStorage.child(fileName)
        imageDownloadTask = imageRef.getData(maxSize: 10485760) { (data, error) in
            if error == nil {
                if let imageData = data, let image = UIImage(data: imageData) {
                    completion(image)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func cancelImageDownload() {
        imageDownloadTask?.cancel()
    }
    
    
    // MARK: - Datenstruktur
    
    enum Database {
        case quest
        case game
        
        var dbName: String {
            switch self {
            case .quest: return "quests"
            case .game: return "games"
            }
        }
    }
}
