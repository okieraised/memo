//
//  Note.swift
//  memo Watch App
//
//  Created by Tri Pham on 2/18/23.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
