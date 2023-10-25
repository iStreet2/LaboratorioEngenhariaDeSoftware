//
//  CheckBoxStyle.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .frame(width: 24, height: 24)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
