//
//  Contact.swift
//  DataFlow
//
//  Created by Michael Brünen on 14.01.21.
//

import SwiftUI

struct Contact {
    var photo: UIImage
    var fullName: String
    var nickName: String
    var email: String
    var phone: String
}

struct TestData {
    static let contact = Contact(
        photo: UIImage(systemName: "person")!,
        fullName: "Michael Brünen",
        nickName: "OddMagnet",
        email: "oddmagnetdev@gmail.com",
        phone: "0123456789"
    )
}
