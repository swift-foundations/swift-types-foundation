//
//  CoenttbWeb.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 21/12/2024.
//

@_exported import Standard_Library_Extensions
@_exported import CasePaths
@_exported import Dependencies
@_exported import Domain_Standard
@_exported import EmailAddress_Standard
@_exported import Foundation
@_exported import FoundationExtensions
@_exported import Tagged_Primitives
@_exported import Translating
@_exported import URLFormCoding

#if URLRouting
    @_exported import URLRouting
    @_exported import URLRoutingTranslating

    extension Tagged where RawValue == Int {
        public static func parser() -> some ParserPrinter<Substring.UTF8View, Self> {
            Digits().map(
                .convert(
                    apply: { Self(rawValue: $0) },
                    unapply: { $0.rawValue }
                )
            )
        }
    }

    extension Tagged where RawValue == UUID {
        public static func parser() -> some ParserPrinter<Substring.UTF8View, Self> {
            UUID.parser().map(
                .convert(
                    apply: { Self(rawValue: $0) },
                    unapply: { $0.rawValue }
                )
            )
        }
    }

    /// Retroactively conforms URLRequestData to the Sendable protocol.
    /// This allows URLRequestData to be safely used across actor and task boundaries.
    ///
    /// While URLRequestData's contents are generally thread-safe, we mark this as @unchecked
    /// since we cannot verify the sendability of all possible request data.
    ///
    /// - Note: This conformance has been tested in production use cases without issues.
    extension URLRequestData: @retroactive @unchecked Sendable {}

    /// Conditionally conforms AnyParserPrinter to Sendable when its generic parameters are Sendable.
    ///
    /// - Important: This is marked as @unchecked because while the generic parameters may be Sendable,
    /// AnyParserPrinter contains closures that need to be verified for thread safety independently.
    /// These closures would need to be marked with @Sendable to guarantee full thread safety.
    ///
    /// - Note: Added in response to discussion about URL routing type safety across concurrent contexts.
    extension AnyParserPrinter: @unchecked @retroactive Sendable
    where Input: Sendable, Output: Sendable {}

    /// Conditionally conforms Path to Sendable when its generic parameters are Sendable.
    ///
    /// Path represents a URL path component in the routing system. While its structure is generally
    /// thread-safe when the generic parameters are Sendable, we mark it as @unchecked since
    /// we cannot verify the thread safety of all possible path configurations.
    ///
    /// - Note: This conformance enables Path to be used safely in concurrent URL routing contexts
    /// while acknowledging that full verification requires runtime checks.
    extension Path: @unchecked @retroactive Sendable where Input: Sendable, Output: Sendable {}

    extension ParserPrinter where Input == URLRequestData {
        /// Transforms the URLRequestData with a provided transformation function
        /// - Parameter transform: Function that takes inout URLRequestData and returns modified URLRequestData
        /// - Returns: Modified BaseURLPrinter
        public func transform(
            _ transform: @escaping (inout URLRequestData) -> URLRequestData
        ) -> BaseURLPrinter<Self> {
            var requestData = URLRequestData()
            requestData = transform(&requestData)
            return self.baseRequestData(requestData)
        }
    }
#endif

#if canImport(FoundationNetworking)
    @_exported import FoundationNetworking
#endif
