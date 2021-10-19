//
//  PrimaryButton.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/18/21.
//

import SwiftUI

struct PrimaryButton: View {
    
    let title: String
    let type: ButtonType
    let enabled: Bool
    let action: () -> Void
    
    enum ButtonType {
        case primary
        case secondary
        
        func color() -> Color {
            switch self {
            case .primary:
                return .blue
            case .secondary:
                return .orange
            }
        }
    }
    
    init(title: String, type: ButtonType? = nil, enabled: Bool, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.enabled = enabled
        self.type = type ?? .primary
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white.opacity(self.enabled ? 1 : 0.3))
                .fontWeight(.bold)
                .font(.body)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .shadow(radius: 2)
                .background(ContainerRelativeShape()
                                .fill(type.color().opacity(self.enabled ? 1 : 0.3)))
                .textCase(.uppercase)
        }
        .clipShape(Capsule())
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PrimaryButton(title: "Save", enabled: true, action: {})
                .padding()
                .previewLayout(.sizeThatFits)
            
            PrimaryButton(title: "Save", enabled: false, action: {})
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
