//
//  WebView+Navigator.swift
//  ChaosSwiftUI
//
//  Created by Fu Lam Diep on 17.08.26.
//

import SwiftUI
import WebKit

// swiftlint:disable line_length nesting
extension WebView {
    @MainActor
    @Observable
    public final class Navigator {
        private let navigationDelegate: NavigationDelegate = .init()

        fileprivate weak var wkWebView: WKWebView? {
            didSet {
                wkWebView?.navigationDelegate = navigationDelegate
            }
        }

        public var title: String? {
            wkWebView?.title
        }

        public var url: URL? {
            wkWebView?.url
        }

        public var isLoading: Bool {
            wkWebView?.isLoading ?? false
        }

        public var estimatedProgress: Double {
            wkWebView?.estimatedProgress ?? 0
        }

        public var hasOnlySecureContent: Bool {
            wkWebView?.hasOnlySecureContent ?? false
        }

        public var backForwardList: WKBackForwardList {
            wkWebView?.backForwardList ?? WKBackForwardList()
        }

        public var canGoBack: Bool {
            wkWebView?.canGoBack ?? false
        }

        public var canGoForward: Bool {
            wkWebView?.canGoForward ?? false
        }

        public var allowsBackForwardNavigationGestures: Bool {
            get { wkWebView?.allowsBackForwardNavigationGestures ?? false }
            set { wkWebView?.allowsBackForwardNavigationGestures = newValue }
        }

        public var allowsLinkPreview: Bool {
            get { wkWebView?.allowsLinkPreview ?? false }
            set { wkWebView?.allowsLinkPreview = newValue }
        }

        @available(iOS 16.4, *)
        @available(macOS 13.3, *)
        public var isInspectable: Bool {
            get { wkWebView?.isInspectable ?? false }
            set { wkWebView?.isInspectable = newValue }
        }

        public init() {
            navigationDelegate.navigator = self
        }

        @discardableResult
        public func load(_ request: URLRequest) -> WKNavigation? {
            wkWebView?.load(request)
        }

        @discardableResult
        public func load(
            _ url: URL,
            cachePolicy: URLRequest.CachePolicy = URLSessionConfiguration.default.requestCachePolicy,
            timeout: TimeInterval = URLSessionConfiguration.default.timeoutIntervalForRequest,
        ) -> WKNavigation? {
            let request = URLRequest(
                url: url,
                cachePolicy: cachePolicy,
                timeoutInterval: timeout,
            )
            return wkWebView?.load(request)
        }

        @discardableResult
        public func load(
            _ data: Data,
            mimeType: MimeType = .text("html"),
            encoding: String.Encoding = .utf8,
            baseURL: URL,
        ) -> WKNavigation? {
            wkWebView?.load(
                data,
                mimeType: mimeType.description,
                characterEncodingName: encoding.description,
                baseURL: baseURL,
            )
        }

        public func loadHTMLString(_ string: String, baseURL: URL? = nil) -> WKNavigation? {
            wkWebView?.loadHTMLString(string, baseURL: baseURL)
        }

        @discardableResult
        public func go(
            to item: WKBackForwardListItem,
        ) -> WKNavigation? {
            wkWebView?.go(to: item)
        }

        @discardableResult
        public func goBack() -> WKNavigation? {
            wkWebView?.goBack()
        }

        @discardableResult
        public func goForward() -> WKNavigation? {
            wkWebView?.goForward()
        }

        @discardableResult
        public func reload() -> WKNavigation? {
            wkWebView?.reload()
        }

        public func stopLoading() {
            wkWebView?.stopLoading()
        }

        // MARK: Delegate functions

        public typealias DecidePolicyForActionCallback = @Sendable (WKNavigationAction) async -> WKNavigationActionPolicy

        fileprivate var decidePolicyForAction: DecidePolicyForActionCallback?

        public func onDecidePolicyForAction(perform action: @escaping DecidePolicyForActionCallback) {
            decidePolicyForAction = action
        }

        public typealias DecidePolicyForResponseCallback = @Sendable (WKNavigationResponse) async -> WKNavigationResponsePolicy

        fileprivate var decidePolicyForResponse: DecidePolicyForResponseCallback?

        public func onDecidePolicyForResponse(perform action: @escaping DecidePolicyForResponseCallback) {
            decidePolicyForResponse = action
        }

        public typealias DidCommitCallback = @Sendable (WKNavigation?) -> Void

        fileprivate var didCommit: DidCommitCallback?

        public func onDidCommit(perform action: @escaping DidCommitCallback) {
            didCommit = action
        }

        public typealias DidFinishCallback = @Sendable (WKNavigation?) -> Void

        fileprivate var didFinish: DidFinishCallback?

        public func onDidFinish(perform action: @escaping DidFinishCallback) {
            didFinish = action
        }
    }

    private class NavigationDelegate: NSObject, WKNavigationDelegate {
        fileprivate weak var navigator: Navigator!

        func webView(_: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
            await navigator.decidePolicyForAction?(navigationAction) ?? .allow
        }

        func webView(_: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
            await navigator.decidePolicyForResponse?(navigationResponse) ?? .allow
        }

        func webView(_: WKWebView, didCommit navigation: WKNavigation!) {
            navigator.didCommit?(navigation)
        }

        func webView(_: WKWebView, didFinish navigation: WKNavigation!) {
            navigator.didCommit?(navigation)
        }
    }
}

#if canImport(UIKit)
    extension WebView: UIViewRepresentable {
        public typealias UIViewType = WKWebView

        public func makeUIView(
            context _: Context,
        ) -> WKWebView {
            let wkWebView = WKWebView()
            navigator.wkWebView = wkWebView
            return wkWebView
        }

        public func updateUIView(
            _: WKWebView,
            context _: Context,
        ) {}
    }
#endif

#if canImport(AppKit)
    extension WebView: NSViewRepresentable {
        public typealias NSViewType = WKWebView

        public func makeNSView(
            context _: Context,
        ) -> WKWebView {
            let wkWebView = WKWebView()
            navigator.wkWebView = wkWebView
            return wkWebView
        }

        public func updateNSView(
            _: WKWebView,
            context _: Context,
        ) {}
    }
#endif
// swiftlint:enable line_length nesting
