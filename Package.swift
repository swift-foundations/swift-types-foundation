// swift-tools-version: 6.3.3

import PackageDescription

extension String {
    static let swiftTypesFoundation: Self = "TypesFoundation"
}

extension Target.Dependency {
    static var swiftTypesFoundation: Self { .target(name: .swiftTypesFoundation) }
}

extension Target.Dependency {
    static var standardLibraryExtensions: Self { .product(name: "Standard Library Extensions", package: "swift-standard-library-extensions") }
    static var emailAddress: Self { .product(name: "EmailAddress Standard", package: "swift-emailaddress-standard") }
    static var domain: Self { .product(name: "Domain Standard", package: "swift-domain-standard") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "Dependencies Test Support", package: "swift-dependencies") }
    static var foundationExtensions: Self { .product(name: "FoundationExtensions", package: "swift-foundation-extensions") }
    static var translating: Self { .product(name: "Translating", package: "swift-translating") }
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
    static var urlRoutingTranslating: Self { .product(name: "URLRoutingTranslating", package: "swift-url-routing-translating") }
    static var formCoding: Self {
        .product(
            name: "FormCoding",
            package: "swift-form-coding"
        )
    }
    static var tagged: Self { .product(name: "Tagged Primitives", package: "swift-tagged-primitives") }
}

let package = Package(
    name: "swift-types-foundation",
    platforms: [
        .macOS(.v26),
        .iOS(.v26)
    ],
    products: [
        .library(
            name: .swiftTypesFoundation,
            targets: [
                .swiftTypesFoundation
            ]
        )
    ],
    traits: [
        .trait(
            name: "URLRouting",
            description: "URLRouting integration for TypesFoundation"
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-standard-library-extensions.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-domain-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-emailaddress-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-foundation-extensions.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-translating.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-form-coding.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-url-routing-translating.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-dependencies.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-url-routing.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-tagged-primitives.git", branch: "main")
    ],
    targets: [
        .target(
            name: .swiftTypesFoundation,
            dependencies: [
                .standardLibraryExtensions,
                .dependencies,
                .foundationExtensions,
                .translating,
                .urlRouting,
                .urlRoutingTranslating,
                .emailAddress,
                .domain,
                .formCoding,
                .tagged
            ]
        ),
        .testTarget(
            name: .swiftTypesFoundation.tests,
            dependencies: [
                .swiftTypesFoundation,
                .dependenciesTestSupport
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

#if swift(>=6.1) && swift(<6.3)
// Workaround for SPM trait propagation bug in Swift 6.1-6.2
// Explicitly include transitive conditional dependencies that are not already declared
package.dependencies.append(contentsOf: [
    .package(url: "https://github.com/swift-ietf/swift-rfc-7578.git", branch: "main")
])
#endif

extension String { var tests: Self { self + " Tests" } }
