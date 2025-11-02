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
    
    private var color: Color {
        switch attendee.state {
        case .notCalled:
            return Color.gray.opacity(0.2)
        case .present:
            return Color.blue.opacity(0.5)
        case .absent:
            return Color.red.opacity(0.5)
        case .excused:
            return Color.yellow.opacity(0.5)
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(attendee.avatar)
                .font(.custom("Fontaku", size: 50))
                .fontWeight(.regular)
            Text(attendee.name)
                .font(.custom("Fontaku", size: 16))
                .fontWeight(.medium)
        }
        .frame(width: 120, height: 120)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
        )
        .onTapGesture {
            action()
        }
    }
}
