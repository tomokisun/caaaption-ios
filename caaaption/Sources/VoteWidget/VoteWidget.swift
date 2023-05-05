import SwiftUI
import WidgetKit
import WidgetProtocol

public enum VoteWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind = Constant.kind
    public init() {}
    
    public var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        VoteWidget.WidgetView(entry: entry)
      }
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }
  
  public enum Constant: WidgetConstant {
    public static var displayName = "Balance Widget"
    public static var description = "Displays wallet balance."
    public static var kind = "BalanceWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemSmall,
      .systemMedium
    ]
  }
  
  public struct Input: Codable {
    public let address: String
    
    public init(address: String) {
      self.address = address
    }
  }
  
  public struct Entry: TimelineEntry, Equatable {
    public let date: Date
    
    public init(
      date: Date
    ) {
      self.date = date
    }
  }
  
  public struct Provider: TimelineProvider {
    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date())
    }
    
    public func getSnapshot(
      in context: Context,
      completion: @escaping (Entry) -> Void
    ) {
      let entry = Entry(date: Date())
      completion(entry)
    }
    
    public func getTimeline(
      in context: Context,
      completion: @escaping (Timeline<Entry>) -> Void
    ) {
      getSnapshot(in: context) { entry in
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
      }
    }
  }
  
  public struct WidgetView: View {
    let entry: Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    public init(entry: Entry) {
      self.entry = entry
    }
    
    public var body: some View {
      HStack(spacing: 24) {
        CircleGraf(scores: [10, 20])
          .scaleEffect(0.35)
        
        if widgetFamily != .systemSmall {
          VStack(alignment: .leading, spacing: 8) {
            Text("For - Approve change")
              .foregroundColor(.blue)
            Text("Against - Do not approve change")
              .foregroundColor(.blue.opacity(0.3))
          }
          .font(.caption)
          .lineLimit(1)
        }
      }
      .frame(maxWidth: .infinity)
      .padding()
    }
    
    var updatedAt: some View {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm"
      let dateString = dateFormatter.string(from: entry.date)
      return Text("Updated at \(dateString)")
    }
  }
}


#if DEBUG
  import WidgetHelpers

  struct WidgetViewPreviews: PreviewProvider {
    static var previews: some View {
      WidgetPreview([.systemSmall, .systemMedium]) {
        VoteWidget.WidgetView(
          entry: VoteWidget.Entry(
            date: Date()
          )
        )
      }
    }
  }
#endif