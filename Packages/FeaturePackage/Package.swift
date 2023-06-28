// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
  name: "FeaturePackage",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.54.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.2.2"),
    .package(url: "https://github.com/onevcat/Kingfisher", from: "7.8.1"),
    .package(path: "../WidgetPackage"),
    .package(path: "../ClientPackage"),
    .package(path: "../GraphQLPackage"),
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
  .library(name: "LinkFeature", targets: ["LinkFeature"]),
])
package.targets.append(contentsOf: [
  .target(name: "AppFeature", dependencies: [
    "WidgetTabFeature",
    "OnboardFeature",
  ]),
  .target(name: "WidgetSearchFeature", dependencies: [
    "AnalyticsReducer",
    "BalanceWidgetFeature",
    "VoteWidgetFeature",
    "POAPWidgetFeature",
    "GasPriceWidgetFeature",
  ]),
  .target(name: "AccountFeature", dependencies: [
    "LinkFeature",
    "ContributorFeature",
  ]),
  .target(name: "ContributorFeature", dependencies: [
    "SwiftUIHelpers",
    "PlaceholderAsyncImage",
    .product(name: "GitHubClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "BalanceWidgetFeature", dependencies: [
    "SwiftUIHelpers",
    .product(name: "WidgetClient", package: "ClientPackage"),
    .product(name: "BalanceWidget", package: "WidgetPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "VoteWidgetFeature", dependencies: [
    "SwiftUIHelpers",
    .product(name: "VoteWidget", package: "WidgetPackage"),
    .product(name: "WidgetClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "OnboardFeature", dependencies: [
    "SwiftUIHelpers",
    .product(name: "AuthClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "POAPWidgetFeature", dependencies: [
    "SwiftUIHelpers",
    .product(name: "Kingfisher", package: "Kingfisher"),
    .product(name: "POAPWidget", package: "WidgetPackage"),
    .product(name: "POAPClient", package: "ClientPackage"),
    .product(name: "WidgetClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "GasPriceWidgetFeature", dependencies: [
    "SwiftUIHelpers",
    .product(name: "GasPriceWidget", package: "WidgetPackage"),
    .product(name: "WidgetClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "WidgetTabFeature", dependencies: [
    "WidgetSearchFeature",
    "AccountFeature",
  ]),
  .target(name: "LinkFeature", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
])

// Helpers

package.products.append(contentsOf: [
  .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
  .library(name: "AnalyticsReducer", targets: ["AnalyticsReducer"]),
])
package.targets.append(contentsOf: [
  .target(name: "SwiftUIHelpers"),
  .target(name: "AnalyticsReducer", dependencies: [
    .product(name: "AnalyticsClient", package: "ClientPackage"),
  ]),
])

// Utilities
package.products.append(contentsOf: [
  .library(name: "PlaceholderAsyncImage", targets: ["PlaceholderAsyncImage"]),
])
package.targets.append(contentsOf: [
  .target(name: "PlaceholderAsyncImage"),
])
