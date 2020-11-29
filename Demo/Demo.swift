//
//  Demo.swift
//  Demo
//
//  Created by Artesia Ko on 11/28/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), image: "snowman1")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), image: "snowman1")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for offset in 1 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .second, value: offset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, image: "snowman\(Int.random(in: 1..<8))")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: String
}

struct DemoEntryView : View {
    // NOTE: extract widget size
    @Environment(\.widgetFamily) var size
    @State var snowman: Int = Global.getSnowman()
    
    var entry: Provider.Entry

    var body: some View {
        switch size {
            case .systemSmall:
                ZStack(alignment: .center) {
                    Image(entry.image)
                        .resizable()
                        .scaledToFill()
                    // NOTE: takes shape of container
                    ContainerRelativeShape()
                        .fill(Color.black)
                        .opacity(0.5)
                    VStack(alignment: .center, spacing: nil) {
                        Text(entry.date, style: .time)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Text(entry.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.white)
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 1)
                        
                    }
                }
            case .systemMedium:
                Image("snowman\(snowman)")
                    .resizable()
                    .scaledToFill()
            case .systemLarge:
                Text("Large Widget")
                    .foregroundColor(Color.blue)
            default:
                Text("Default Widget")
        }
    }
}

@main
struct Demo: Widget {
    let kind: String = "Demo"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DemoEntryView(entry: entry)
        }
        .configurationDisplayName("Snowmen")
        .description("Happy holidays.")
    }
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        DemoEntryView(entry: SimpleEntry(date: Date(), image: "snowman1"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
