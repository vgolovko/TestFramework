//
//  ButtonStyle.swift
//  UIComponents
//
//  Created by Anton Pavlenko on 05.07.2020.
//  Copyright © 2020 Windmill. All rights reserved.
//

import UIKit

public enum ButtonStyle: Int, CaseIterable {
    case primaryFilled
    case primaryOutline
    case secondaryOutline
    case tertiaryOutline
    case borderless
    case signInService
    public var contentEdgeInsets: UIEdgeInsets {
        switch self {
        case .primaryFilled, .primaryOutline, .signInService:
            return UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        case .secondaryOutline:
            return UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        case .borderless:
            return UIEdgeInsets(top: 7, left: 12, bottom: 7, right: 12)
        case .tertiaryOutline:
            return UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        }
    }
    var cornerRadius: CGFloat {
        switch self {
        case .primaryFilled, .primaryOutline, .secondaryOutline, .borderless, .signInService:
            return 25
        case .tertiaryOutline:
            return 5
        }
    }
    var hasBorders: Bool {
        switch self {
        case .primaryOutline, .secondaryOutline, .tertiaryOutline:
            return true
        case .primaryFilled, .borderless, .signInService:
            return false
        }
    }
    var minTitleLabelHeight: CGFloat {
        switch self {
        case .primaryFilled, .primaryOutline, .borderless, .signInService:
            return 20
        case .secondaryOutline, .tertiaryOutline:
            return 18
        }
    }
    var titleFont: UIFont {
        switch self {
        case .primaryFilled, .primaryOutline, .borderless:
            return FontFactory.ButtonFonts.primaryFontButton!
        case .secondaryOutline, .tertiaryOutline:
            return FontFactory.ButtonFonts.primaryFontButton!
        case .signInService:
            return FontFactory.ButtonFonts.signInFontButton!
        }
    }
}
