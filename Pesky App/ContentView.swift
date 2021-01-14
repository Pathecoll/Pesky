//
//  ContentView.swift
//  Pesky App
//
//  Created by Hector Fabian Plata Santos on 14/01/21.
//

import SwiftUI

struct ContentView: View {
    @State private var favoriteColor = 0
    let progress =  0.6
    let total = 30
    
    var body: some View {
        Gauge(progress: progress, total: total)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
