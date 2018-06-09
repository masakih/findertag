//
//  FinderTag.swift
//  findertag
//
//  Created by Hori,Masaki on 2018/06/04.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import Foundation

class FinderTag {
    
    private var fileURL: URL
    
    init?(fileURL: URL) {
        
        guard fileURL.isFileURL else {
            
            print("fileURL is not file URL.")
            return nil
        }
        
        self.fileURL = fileURL
    }
}

extension FinderTag {
    
    func view(recurcive: Bool) -> FileTag {
        
        if recurcive {
            
            return fileTag(for: fileURL)
        }
        
        return FileTag(url: fileURL,
                       tags: fileURL.tags,
                       children: [])
    }
    
    private func fileTag(for url: URL) -> FileTag {
        
        guard let files = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil) else {
            
            return FileTag(url: url,
                           tags: url.tags,
                           children: [])
        }
        
        return FileTag(url: url,
                       tags: url.tags,
                       children: files.map(fileTag(for:)))
    }
    
    func append(tag: String) {
        
        fileURL.tags = fileURL.tags + [tag]
    }
    
    func remove(tag: String) {
        
        fileURL.tags = fileURL.tags.filter { $0 != tag }
    }
    
    func delete() {
        
        fileURL.tags = []
    }
}

extension FinderTag {
    
    var labelNumber: Int? {
        
        get {
            
            return fileURL.labelNumber
        }
        
        set {
            
            fileURL.labelNumber = newValue
        }
    }
}
