//
//  exports.swift
//  swift-types-foundation
//
//  W-3-STUB (TEMPORARY umbrella shell — decomposition W2, 2026-07-13).
//  This package's own content dissolved per the ratified decomposition plan (S5):
//    - Tagged<Int/UUID>.parser()            → swift-url-routing-tagged (W2 mint)
//    - ParserPrinter.transform helper       → swift-url-routing (PointFree compat surface)
//    - retroactive Sendable conformances    → superseded by swift-url-routing's native
//      conformances (URI.Request.Data structural; AnyParserPrinter unconditional;
//      URI.Path.Parser conditional) — nothing to import for these.
//  The re-exports below are kept ONLY so `@_exported import TypesFoundation`
//  consumers (swift-server-foundation; the app transitively through it) stay green
//  until Wave 3's ssf C10 umbrella deletion + the E-4 re-export-dissolution
//  inventory execute this shell's removal. Do NOT add surface here.
//

@_exported import Standard_Library_Extensions
@_exported import Dependencies
@_exported import Domain_Standard
@_exported import EmailAddress_Standard
@_exported import Foundation
@_exported import FoundationExtensions
@_exported import Tagged_Primitives
@_exported import Translating
@_exported import URLFormCoding

#if canImport(FoundationNetworking)
    @_exported import FoundationNetworking
#endif
