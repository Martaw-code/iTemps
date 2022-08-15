//
//  OutlineView.swift
//  iTemps WatchKit Extension
//
//  Created by MAC on 15/8/22.
//

import SwiftUI

struct OutlineView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.red, Color.blue.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
            .padding()
    }
}

struct OutlineView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineView()
    }
}
