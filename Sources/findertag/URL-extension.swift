//
//  URL-extension.swift
//  findertag
//
//  Created by Hori,Masaki on 2018/06/04.
//  Copyright © 2018年 Hori,Masaki. All rights reserved.
//

import Foundation

extension URL {
    
    var tags: [String] {
        
        get {
            
            let attr = try? self.resourceValues(forKeys: [.tagNamesKey])
            let finderLabel = self.labelNumber.flatMap { FinderLabel(rawValue: $0) }
            
            switch (attr?.tagNames, finderLabel) {
                
            case let (tag?, label?): return (tag + [label.localizedName]).unique()
                
            case let (tag?, _): return tag
                
            case let (_, label?): return [label.localizedName]
                
            default: return []
            }
        }
        
        set {
            
            do {
                                
                let url = self as NSURL
                try url.setResourceValue(newValue.unique() as NSArray, forKey: .tagNamesKey)
                
            } catch {
                
                print("Can not set tagNames")
            }
        }
    }
    
    var labelNumber: Int? {
        
        get {
            
            let attr = try? self.resourceValues(forKeys: [.labelNumberKey])
            
            return attr?.labelNumber
        }
        
        set {
            
            do {
                
                let url = self as NSURL
                try url.setResourceValue(newValue, forKey: .labelNumberKey)
                
            } catch {
                
                print("Can not set labelNumber")
            }
        }
    }
}
