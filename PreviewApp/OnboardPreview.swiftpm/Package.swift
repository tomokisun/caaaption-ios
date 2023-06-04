// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "OnboardPreview",
    platforms: [
        .iOS("16.0"),
    ],
    products: [
        .iOSApplication(
            name: "OnboardPreview",
            targets: ["OnboardPreviewModule"],
            bundleIdentifier: "com.caaaption.OnboardPreview",
            teamIdentifier: "AV9FQ3YF56",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .sandwich),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone,
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad])),
            ]
        ),
    ],
    dependencies: [
        .package(name: "caaaption", path: "../../caaaption"),
    ],
    targets: [
        .executableTarget(
            name: "OnboardPreviewModule",
            dependencies: [
                .productItem(
                    name: "OnboardFeature",
                    package: "caaaption"
                ),
            ],
            path: "."
        ),
    ]
)
