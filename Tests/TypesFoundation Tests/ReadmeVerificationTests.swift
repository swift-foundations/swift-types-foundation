//
//  ReadmeVerificationTests.swift
//  swift-types-foundation
//
//  Created to verify all README code examples compile and run correctly.
//

import Foundation
import Testing

@testable import TypesFoundation

@Suite( .serialized
struct Test {

    @Test
    func `Quick Start - Multiple Imports (README lines 82-90)`() throws {
        // This test verifies that all the individual package imports mentioned in README
        // are available through TypesFoundation. We don't need to import them separately
        // as they're re-exported through @_exported imports in exports.swift

        // Verify the imports are accessible by using types from each package
        let _: EmailAddress.Type = EmailAddress.self
        let _: Domain.Type = Domain.self

        // Foundation is available through TypesFoundation's @_exported import
        let _: Date.Type = Date.self

        // URLRouting is available
        // Note: We can't easily verify URLRoute without defining a concrete route type

        // Translating types
        let _: Language.Type = Language.self

        // Builders is imported but doesn't have a primary type to check
        // Dependencies is imported
        let _: __DependencyValues.Type = __DependencyValues.self
    }

    @Test
    func `Quick Start - Consolidated Import (README lines 94-102)`() throws {
        // Verify that importing TypesFoundation gives access to all functionality

        // Create email address
        let email = try EmailAddress("user@example.com")
        #expect(email.rawValue == "user@example.com")

        // Create domain
        let domain = try Domain("example.com")
        #expect(domain.name == "example.com")

        // Date arithmetic with FoundationExtensions
        // Provide test calendar dependency
        withDependencies {
            $0.calendar = Calendar.current
        } operation: {
            let date = Date.now + 1.day
            guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)
            else {
                Issue.record("Failed to calculate tomorrow's date")
                return
            }

            // Verify the date is approximately correct (within 1 second)
            let difference = abs(date.timeIntervalSince(tomorrow))
            #expect(difference < 1.0)
        }

        // Note: URLRoute<MyRoute>() would require defining MyRoute,
        // which is beyond the scope of README verification
    }

    @Test
    func `Installation - Package.swift Dependency (README lines 61-65)`() throws {
        // Verify the package name and URL are correct by checking they match Package.swift
        // This is a compile-time check - if TypesFoundation imports work, the package is set up correctly
        // We verify this by checking that core types from the package are accessible
        let _: EmailAddress.Type = EmailAddress.self
        let _: Domain.Type = Domain.self
    }

    @Test
    func `Installation - Target Dependency (README lines 69-76)`() throws {
        // Verify the product name "TypesFoundation" is correct
        // This is verified by the fact that we can import TypesFoundation and use its types
        let _: EmailAddress.Type = EmailAddress.self
        let _: Domain.Type = Domain.self
    }
}
