ifeq (.private,$(wildcard .private))
	PRIVATE = 1
endif

open:
	open caaaption.xcworkspace

clean:
	rm -rf ./.swiftpm
	rm -rf ./.build

bootstrap: secrets

build: build-caaaption

PLATFORM_IOS = iOS Simulator,name=iPhone 13 Pro,OS=16.2

build-caaaption:
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Staging project)" \
		-sdk iphonesimulator
	@xcodebuild build \
		-workspace caaaption.xcworkspace \
		-scheme "App (Production project)" \
		-sdk iphonesimulator

secrets:
ifdef PRIVATE
	@echo "// This is generated by \`make secrets`. Don't edit. \nlet API_KEY = \"$(POAP_API_KEY)\"" > caaaption/Sources/POAPClient/Secrets.swift
else
	@cp caaaption/Sources/POAPClient/Secrets.swift.example caaaption/Sources/POAPClient/Secrets.swift
endif

dgraph:
	@swift build -c release --package-path ./BuildTools/DependenciesGraph --product dgraph
	./BuildTools/DependenciesGraph/.build/release/dgraph ./caaaption

format:
	@swift build -c release --package-path ./BuildTools/SwiftFormatTool --product swiftformat
	./BuildTools/SwiftFormatTool/.build/release/swiftformat ./

install-template:
	@swift build -c release --package-path ./BuildTools/XCTemplateInstallerTool --product XCTemplateInstaller
	./BuildTools/XCTemplateInstallerTool/.build/release/XCTemplateInstaller --xctemplate-path XCTemplates/TCA.xctemplate

apollo-cli-install:
	@swift package --package-path ./caaaption --allow-writing-to-package-directory apollo-cli-install

apollo-generate:
	./caaaption/apollo-ios-cli generate