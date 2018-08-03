//
//  Array-extension.swift
//  findertag
//
//  Created by Hori,Masaki on 2018/06/06.
//

import Foundation

extension Sequence where Element: Hashable {
    
    func unique() -> [Element] {
        
        var exist = Set<Element>()
        
        return filter {
            
            if exist.contains($0) {
                
                return false
            }
            
            exist.insert($0)
            
            return true
        }
    }
}
