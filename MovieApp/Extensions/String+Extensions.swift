//
//  String+Extensions.swift
//  MovieApp
//
//  Created by Anup Saud on 2024-09-09.
//

import Foundation
extension String {
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
