//
//  CenteredStack.swift
//  CenteredStack
//
//  Created by Xavier Normant on 03/25/2024.
//  Copyright © 2024 Xavier Normant. All rights reserved.
//
//  GitHub: https://github.com/atlou
//

import SwiftUI

private struct ParentContainerKey: EnvironmentKey {
    static let defaultValue: ParentContainer = .unknown
}

private enum ParentContainer {
    case vStack
    case hStack
    case unknown
}

private extension EnvironmentValues {
    var parentContainer: ParentContainer {
        get { self[ParentContainerKey.self] }
        set { self[ParentContainerKey.self] = newValue }
    }
}

private extension VStack {
    func identifyingParent() -> some View {
        self.environment(\.parentContainer, .vStack)
    }
}

private extension HStack {
    func identifyingParent() -> some View {
        self.environment(\.parentContainer, .hStack)
    }
}

private extension HorizontalAlignment {
    private struct CenterAbsoluteAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }

    static let centered = HorizontalAlignment(CenterAbsoluteAlignment.self)
}

private extension VerticalAlignment {
    private struct CenterAbsoluteAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }

    static let centered = VerticalAlignment(CenterAbsoluteAlignment.self)
}

private extension Alignment {
    static let horizontallyCentered = Alignment(horizontal: .centered, vertical: .center)
    static let verticallyCentered = Alignment(horizontal: .center, vertical: .centered)
}

private struct Centered: ViewModifier {
    @Environment(\.parentContainer) var parentContainer

    func body(content: Content) -> some View {
        print(self.parentContainer)
        switch self.parentContainer {
        case .hStack:
            return AnyView(content.alignmentGuide(HorizontalAlignment.centered) { d in
                d[HorizontalAlignment.centered]
            })
        case .vStack:
            return AnyView(content.alignmentGuide(VerticalAlignment.centered) { d in
                d[VerticalAlignment.centered]
            })
        default:
            return AnyView(content)
        }
    }
}

extension View {
    func centered() -> some View {
        modifier(Centered())
    }
}

struct CenteredHStack<Content: View>: View {
    let alignment: VerticalAlignment
    let spacing: CGFloat?
    let content: Content

    init(alignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder _ content: () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .horizontallyCentered) {
            Color.clear
                .frame(height: 0)
                .frame(maxWidth: .infinity)
                .alignmentGuide(HorizontalAlignment.centered) { d in
                    d[HorizontalAlignment.centered]
                }

            HStack(alignment: self.alignment, spacing: self.spacing) {
                self.content
            }
            .identifyingParent()
        }
    }
}

struct CenteredVStack<Content: View>: View {
    let alignment: HorizontalAlignment
    let spacing: CGFloat?
    let content: Content

    init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder _ content: () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .verticallyCentered) {
            Color.clear
                .frame(width: 0)
                .frame(maxHeight: .infinity)
                .alignmentGuide(VerticalAlignment.centered) { d in
                    d[VerticalAlignment.centered]
                }

            VStack(alignment: self.alignment, spacing: self.spacing) {
                self.content
            }
            .identifyingParent()
        }
    }
}
