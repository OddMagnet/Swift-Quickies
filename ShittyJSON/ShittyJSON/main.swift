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

@dynamicMemberLookup
struct JSON: RandomAccessCollection {
    var value: Any?
    var startIndex: Int { array.startIndex }
    var endIndex: Int { array.endIndex }

    init(string: String) throws {
        let data = Data(string.utf8)
        value = try JSONSerialization.jsonObject(with: data)
    }

    init(value: Any?) {
        self.value = value
    }

    // MARK: - Value accessors
    // Optional and non-optional, so the programmer can decide which one to use
    var optionalBool: Bool? { value as? Bool }
    var optionalDouble: Double? { value as? Double }
    var optionalInt: Int? { value as? Int }
    var optionalString: String? { value as? String }
    var optionalDate: Date? { value as? Date }
    var optionalArray: [JSON]? {
        // return Arrays of the JSON type, so it's content can be accessed just as easily as top-level content
        let converted = value as? [Any]
        return converted?.map { JSON(value: $0) }
    }
    var optionalDictionary: [String: JSON]? {
        // same trick as for optional arrays
        let converted = value as? [String: Any]
        return converted?.mapValues { JSON(value: $0) }
    }

    var bool: Bool { optionalBool ?? false }
    var double: Double { optionalDouble ?? 0.0 }
    var int: Int { optionalInt ?? 0 }
    var string: String { optionalString ?? "" }
    var data: Date { optionalDate ?? Date() }
    var array: [JSON] { optionalArray ?? [] }
    var dictionary: [String: JSON] { optionalDictionary ?? [:] }

    // MARK: - Query accessors
    subscript(index: Int) -> JSON { optionalArray?[index] ?? JSON(value: nil) }
    subscript(dynamicMember key: String) -> JSON { optionalDictionary?[key] ?? JSON(value: nil) }
}

let object = try JSON(string: json)
for item in object {
    print(item.title.string)
    print(item.address.city.string)
    if let latitude = item.address.gps.lat.optionalDouble {
        print("Latitude is \(latitude)")
    }
}
