import SwiftUI
import WidgetHelpers
import WidgetKit

public struct ArtWidgetView: View {
  public var entry: Entry

  public init(entry: Entry) {
    self.entry = entry
  }

  public var body: some View {
    Image(uiImage: entry.image())
      .resizable()
      .aspectRatio(contentMode: .fill)
  }
}

struct ArtWidgetViewPreviews: PreviewProvider {
  static var previews: some View {
    WidgetPreview {
      ArtWidgetView(entry: Entry(date: Date(), url: imageUrl))
    }
  }
}
