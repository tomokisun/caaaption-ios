// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
  name: "caaaption",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.54.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.1.2"),
    .package(url: "https://github.com/caaaption/design-system", branch: "main"),
  ]
)

// Features
package.products.append(contentsOf: [
  .library(name: "AppFeature", targets: ["AppFeature"]),
  .library(name: "WidgetSearchFeature", targets: ["WidgetSearchFeature"]),
  .library(name: "AccountFeature", targets: ["AccountFeature"]),
  .library(name: "ContributorFeature", targets: ["ContributorFeature"]),
  .library(name: "BalanceWidgetFeature", targets: ["BalanceWidgetFeature"]),
  .library(name: "VoteWidgetFeature", targets: ["VoteWidgetFeature"]),
  .library(name: "OnboardFeature", targets: ["OnboardFeature"]),
  .library(name: "POAPWidgetFeature", targets: ["POAPWidgetFeature"]),
  .library(name: "GasPriceWidgetFeature", targets: ["GasPriceWidgetFeature"]),
  .library(name: "WidgetTabFeature", targets: ["WidgetTabFeature"]),
])
package.targets.append(contentsOf: [
  .target(name: "AppFeature", dependencies: [
    "WidgetTabFeature",
    "OnboardFeature",
  ]),
  .target(name: "WidgetSearchFeature", dependencies: [
    "BalanceWidgetFeature",
    "VoteWidgetFeature",
    "POAPWidgetFeature",
    "GasPriceWidgetFeature",
  ]),
  .target(name: "AccountFeature", dependencies: [
    "ServerConfig",
    "ContributorFeature",
    .product(name: "Avatar", package: "design-system"),
  ]),
  .target(name: "ContributorFeature", dependencies: [
    "GitHubClient",
    "SwiftUIHelpers",
    "PlaceholderAsyncImage",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "BalanceWidgetFeature", dependencies: [
    "WidgetClient",
    "BalanceWidget",
    "SwiftUIHelpers",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "VoteWidgetFeature", dependencies: [
    "VoteWidget",
    "WidgetClient",
    "SwiftUIHelpers",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "OnboardFeature", dependencies: [
    "AuthClient",
    "ServerConfig",
    "SwiftUIHelpers",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "POAPWidgetFeature", dependencies: [
    "POAPWidget",
    "POAPClient",
    "WidgetClient",
    "SwiftUIHelpers",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "GasPriceWidgetFeature", dependencies: [
    "WidgetClient",
    "SwiftUIHelpers",
    "GasPriceWidget",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "WidgetTabFeature", dependencies: [
    "WidgetSearchFeature",
    "AccountFeature",
    .product(name: "Avatar", package: "design-system"),
  ]),
])

// GraphQL
package.products.append(contentsOf: [
  .library(name: "SnapshotModel", targets: ["SnapshotModel"]),
  .library(name: "SnapshotModelMock", targets: ["SnapshotModelMock"]),
])
package.targets.append(contentsOf: [
  .target(name: "SnapshotModel", dependencies: [
    .product(name: "ApolloAPI", package: "apollo-ios"),
  ]),
  .target(name: "SnapshotModelMock", dependencies: [
    "SnapshotModel",
    .product(name: "ApolloTestSupport", package: "apollo-ios"),
  ]),
])

// Client

package.products.append(contentsOf: [
  .library(name: "UIApplicationClient", targets: ["UIApplicationClient"]),
  .library(name: "SnapshotClient", targets: ["SnapshotClient"]),
  .library(name: "ServerConfig", targets: ["ServerConfig"]),
  .library(name: "GitHubClient", targets: ["GitHubClient"]),
  .library(name: "UserDefaultsClient", targets: ["UserDefaultsClient"]),
  .library(name: "QuickNodeClient", targets: ["QuickNodeClient"]),
  .library(name: "POAPClient", targets: ["POAPClient"]),
  .library(name: "WidgetClient", targets: ["WidgetClient"]),
  .library(name: "AuthClient", targets: ["AuthClient"]),
])
package.targets.append(contentsOf: [
  .target(name: "UIApplicationClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "SnapshotClient", dependencies: [
    "ApolloHelpers",
    "SnapshotModel",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "ServerConfig"),
  .target(name: "GitHubClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "UserDefaultsClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "QuickNodeClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "POAPClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "WidgetClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "AuthClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
])

// Helpers

package.products.append(contentsOf: [
  .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
  .library(name: "ApolloHelpers", targets: ["ApolloHelpers"]),
])
package.targets.append(contentsOf: [
  .target(name: "SwiftUIHelpers"),
  .target(name: "ApolloHelpers", dependencies: [
    .product(name: "Apollo", package: "apollo-ios"),
    .product(name: "ApolloAPI", package: "apollo-ios"),
  ]),
])

// Utilities
package.products.append(contentsOf: [
  .library(name: "PlaceholderAsyncImage", targets: ["PlaceholderAsyncImage"]),
])
package.targets.append(contentsOf: [
  .target(name: "PlaceholderAsyncImage"),
])

// Widgets

package.products.append(contentsOf: [
  .library(name: "WidgetProtocol", targets: ["WidgetProtocol"]),
  .library(name: "WidgetHelpers", targets: ["WidgetHelpers"]),
  .library(name: "WidgetModule", targets: [
    "BalanceWidget",
    "VoteWidget",
    "GasPriceWidget",
    "POAPWidget",
    "SnapshotSpaceWidget",
    "MirrorWidget",
  ]),
  .library(name: "BalanceWidget", targets: ["BalanceWidget"]),
  .library(name: "VoteWidget", targets: ["VoteWidget"]),
  .library(name: "GasPriceWidget", targets: ["GasPriceWidget"]),
  .library(name: "POAPWidget", targets: ["POAPWidget"]),
  .library(name: "SnapshotSpaceWidget", targets: ["SnapshotSpaceWidget"]),
  .library(name: "MirrorWidget", targets: ["MirrorWidget"]),
])
package.targets.append(contentsOf: [
  .target(name: "WidgetProtocol"),
  .target(name: "WidgetHelpers"),
  .target(name: "BalanceWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
    "QuickNodeClient",
    "UserDefaultsClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "VoteWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
    "UserDefaultsClient",
    "SnapshotClient",
  ]),
  .target(name: "GasPriceWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
    "UserDefaultsClient",
  ]),
  .target(name: "POAPWidget", dependencies: [
    "POAPClient",
    "WidgetHelpers",
    "WidgetProtocol",
    "UserDefaultsClient",
  ]),
  .target(name: "SnapshotSpaceWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
  ]),
  .target(name: "MirrorWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
  ]),
])