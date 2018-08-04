//
//  URL.swift
//  WKWebViewBugs
//
//  Created by Kyusaku Mihara on 2018/08/04.
//  Copyright © 2018 epohsoft. All rights reserved.
//

import Foundation

extension URL {
    static var indexHTMLFileURL: URL {
        return URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!, isDirectory: false)
    }
}
