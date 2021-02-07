//
//  LockscreenButton.swift
//  Lockscreen
//
//  Created by Michael Brünen on 07.02.21.
//

import SwiftUI

struct LockscreenButton: View {
    let image: String

    var body: some View {
        Image(systemName: image)
            .foregroundColor(.white)
            .font(.title3)
            .frame(width: 50, height: 50)
            .background(Color.black.opacity(0.4))
            .clipShape(Circle())
    }
}

struct LockscreenButton_Previews: PreviewProvider {
    static var previews: some View {
        LockscreenButton(image: "camera.fill")
    }
}
