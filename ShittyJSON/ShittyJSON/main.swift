//
//  main.swift
//  ShittyJSON
//
//  Created by Michael Brünen on 24.03.21.
//

import Foundation

let json = """
[
    {
        "name": "James Alan Hetfield",
        "company": "Blackened",
        "age": 57,
        "address": {
            "street": "2020 Union St",
            "city": "San Francisco",
            "state": "California",
            "gps": {
                "lat": 37.7978525337476,
                "lon": -122.43255554587907
            }
        }
    },
    {
        "title": "Hardwired... to Self-Destruct",
        "type": "studio",
        "year": "2016",
        "singles": 6
    },
    {
        "title": "Moth into Flame",
        "awards": 10,
        "hasVideo": true
    }
]
"""
extension Dictionary where Key == String {
    func bool(for key: String) -> Bool? {
        self[key] as? Bool
    }

    func string(for key: String) -> String? {
        self[key] as? String
    }

    func int(for key: String) -> Int? {
        self[key] as? Int
    }

    func double(for key: String) -> Double? {
        self[key] as? Double
    }
}

let data = Data(json.utf8)
if let objects = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
    for object in objects {
        if let title = object.string(for: "title") {
            print(title)
        }
    }
}
