//
//  FileTag.swift
//  findertag
//
//  Created by Hori,Masaki on 2018/06/07.
//

import Foundation

struct FileTag {
    
    let url: URL
    
    let tags: [String]
    
    let children: [FileTag]
}

func prityPrint(_ fileTags: [FileTag]) {
    
    fileTags.forEach {
        prityPrint($0)
    }
    fileTags
        .filter { !($0.children.isEmpty) }
        .forEach {
            print("\n  List in", $0.url.lastPathComponent)
            prityPrint($0.children)
    }
}

func prityPrint(_ fileTag: FileTag) {
    
    print(fileTag.url.lastPathComponent, ":\t", fileTag.tags.joined(separator: ", "), separator: "")
}
