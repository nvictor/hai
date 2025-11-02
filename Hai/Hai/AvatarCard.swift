//
//  AvatarCard.swift
//  Hai
//
//  Created by Victor Noagbodji on 11/1/25.
//

import SwiftUI

struct AvatarCard: View {
    let attendee: Attendee
    let action: () -> Void
    
    private var tintColor: Color? {
        switch attendee.state {
        case .notCalled:
            return nil
        case .present:
            return Color(red: 0.3, green: 0.3, blue: 0.3) // Dark Gray
        case .absent:
            return Color(red: 0.61, green: 0.13, blue: 0.27) // Dark Cerise
        case .excused:
            return Color(red: 0.7, green: 0.35, blue: 0.0) // Dark orange
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(attendee.avatar)
                .font(.custom("Fontaku", size: 50))
                .fontWeight(.regular)
                .applyIf(tintColor != nil) { view in
                    view.colorMultiply(tintColor!)
                }
            Text(attendee.name)
                .font(.custom("Fontaku", size: 16))
                .fontWeight(.medium)
                .applyIf(tintColor != nil) { view in
                    view.foregroundStyle(tintColor!)
                }
        }
        .padding()
        .onTapGesture {
            action()
        }
    }
}

extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
