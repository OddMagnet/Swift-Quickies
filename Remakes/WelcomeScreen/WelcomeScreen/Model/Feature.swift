//
//  Feature.swift
//  WelcomeScreen
//
//  Created by Michael Brünen on 09.01.22.
//

import Foundation

struct Feature: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let image: String
}
