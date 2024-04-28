//
//  PickerView.swift
//  OpeninApp_Task
//
//  Created by Abhishek Jadaun on 23/04/24.
//

import SwiftUI

struct PickerButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? .white : .black)
                .padding(.vertical, 12)
                .frame(minWidth: 120)
                .background(isSelected ? Color.blue : Color.clear)
                .cornerRadius(50)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

