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
            let entry = SimpleEntry(date: entryDate, image: "snowman\(Int.random(in: 1..<5))")
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

struct Number {
    var title: String
    var number: Int
}

struct DemoEntryView : View {
    // NOTE: extract widget size
    @Environment(\.widgetFamily) var size
    @State var snowman: Int = Global.getSnowman()
    
    var entry: Provider.Entry
    
    let items: [String] = ["A", "B", "C"]
    let numbers: [Number] = [
        Number(title: "One", number: 1),
        Number(title: "Two", number: 2),
        Number(title: "Three", number: 3),
        Number(title: "Four", number: 4),
        Number(title: "Five", number: 5),
    ]

    var body: some View {
//        Text(entry.date, style: .time)
//        Text(entry.date, style: .date)
        switch size {
//            case .systemSmall:
//                Text("Small Widget")
//                    .foregroundColor(Color.red)
            case .systemMedium:
                VStack(alignment: .leading) {
                    Text("Medium Widget")
                        .foregroundColor(Color.green)
                    Image("snowman\(snowman)")
                        .resizable()
                        .scaledToFill()
                }
            case .systemLarge:
                Text("Large Widget")
                    .foregroundColor(Color.blue)
            default:
                VStack(alignment: .leading) {
                    Text("Hello")
                        .foregroundColor(Color.blue)
                        .background(LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .leading, endPoint: .trailing))
                    Text(entry.date, style: .time)
                        .font(.largeTitle)
                    Text(entry.date, style: .date)
                        .font(.caption)
                    HStack(alignment: .top, spacing: 10) {
                        ForEach(numbers, id: \.title) {
                            Text("\($0.number)")
                                .font(.caption2)
                        }
                    }
                    Image(entry.image)
                        .resizable()
                        .scaledToFit()
                }
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
        // NOTE: Name and description shows where you add the widget.
        .configurationDisplayName("Demo")
        .description("Happy holidays.")
        // NOTE: by default, supports all sizes. Can add this to restrict.
//        .supportedFamilies([.systemSmall])
    }
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        DemoEntryView(entry: SimpleEntry(date: Date(), image: "snowman1"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
