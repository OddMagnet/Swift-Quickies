//
//  LockscreenButton.swift
//  Lockscreen
//
//  Created by Michael Brünen on 07.02.21.
//

import SwiftUI

struct LockscreenButton: View {
    @State private var pressed = false
    @State private var activated = false
    let generator = UIImpactFeedbackGenerator()

    let imageActive: String
    let imageInactive: String
    let action: () -> Void

    init(image: String, action: @escaping () -> Void) {
        self.init(active: image, inactive: image, action: action)
    }

    init(active imageActive: String, inactive imageInactive: String, action: @escaping () -> Void) {
        self.imageInactive = imageInactive
        self.imageActive = imageActive
        self.action = action
    }

    var body: some View {
        Image(systemName: activated ? imageActive : imageInactive)
            // Color changes based on activation state
            .foregroundColor(
                activated
                    ? Color.black
                    : Color.white
            )
            .font(.title3)
            .frame(width: 50, height: 50)
            // Background changes based on activation and pressed state
            .background(
                activated
                    ? Color.white
                    : Color.black.opacity(
                        pressed
                            ? 0.8
                            : 0.4
                    )
            )
            .clipShape(Circle())
            // Scale changes based on pressed state
            .scaleEffect(
                pressed
                    ? 1.5
                    : 1
            )
            .animation(.spring(response: 0.5, dampingFraction: 0.7))
            .onLongPressGesture(minimumDuration: 0.4) { bool in
                pressed = bool
            } perform: {
                generator.impactOccurred()
                activated.toggle()
                pressed = false
            }
    }
}

struct LockscreenButton_Previews: PreviewProvider {
    static var previews: some View {
        LockscreenButton(image: "camera.fill", action: { print("Some action") })
    }
}
