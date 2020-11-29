//
//  ContentView.swift
//  Shared
//
//  Created by Artesia Ko on 11/28/20.
//

import SwiftUI

struct ContentView: View {
    @State var snowman: Int = Global.getSnowman()
    var body: some View {
        Text("\(snowman)")
            .padding()
        VStack(alignment: .center, spacing: nil, content: {
            Button("1") {
                Global.setSnowman(i: 1)
                snowman = 1
            }
            Button("2") {
                Global.setSnowman(i: 2)
                snowman = 2
            }
            Button("3") {
                Global.setSnowman(i: 3)
                snowman = 3
            }
            Button("4") {
                Global.setSnowman(i: 4)
                snowman = 4
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

