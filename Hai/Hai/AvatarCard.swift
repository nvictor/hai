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
            return Color.gray
        case .absent:
            return Color(red: 0.87, green: 0.19, blue: 0.39) // Cerise
        case .excused:
            return Color.orange
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
