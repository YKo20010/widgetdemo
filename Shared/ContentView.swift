//
//  ContentView.swift
//  Shared
//
//  Created by Artesia Ko on 11/28/20.
//

import SwiftUI

struct Snowman {
    var id: String
    var number: Int
}

struct ContentView: View {
    @State var snowman: Int = Global.getSnowman()
    
    let snowmen: [Snowman] = [
        Snowman(id: "One", number: 1),
        Snowman(id: "Two", number: 2),
        Snowman(id: "Three", number: 3),
        Snowman(id: "Four", number: 4),
        Snowman(id: "Five", number: 5),
        Snowman(id: "Six", number: 6),
        Snowman(id: "Seven", number: 7),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Snowman \(snowman)")
                .foregroundColor(Color.white)
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .leading, endPoint: .trailing))
                .font(.largeTitle)
            HStack(alignment: .center, spacing: 10) {
                ForEach(snowmen, id: \.id) { s in
                    Button("\(s.number)") {
                        Global.setSnowman(i: s.number)
                        snowman = s.number
                    }
                }
            }
            Image("snowman\(snowman)")
                .resizable()
                .scaledToFit()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

