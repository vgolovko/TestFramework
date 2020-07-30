//
//  Button.swift
//  UIComponents
//
//  Created by Anton Pavlenko on 05.07.2020.
//  Copyright © 2020 Windmill. All rights reserved.
//

import UIKit
import Resources

public class OwnButton: UIButton {
    private struct Constants {
        static let borderWidth: CGFloat = 1
    }
    private let background: UIColor = .clear
    open var style: ButtonStyle = .secondaryOutline {
        didSet {
            if style != oldValue {
                update()
            }
        }
    }
    open override var isHighlighted: Bool {
        didSet {
            if isHighlighted != oldValue {
                update()
            }
        }
    }
    open override var isEnabled: Bool {
        didSet {
            if isEnabled != oldValue {
                update()
            }
        }
    }
    open override var intrinsicContentSize: CGSize {
        var size = titleLabel?.systemLayoutSizeFitting(CGSize(width: proposedTitleLabelWidth == 0 ? .greatestFiniteMagnitude : proposedTitleLabelWidth, height: .greatestFiniteMagnitude)) ?? .zero
        size.width = ceil(size.width + contentEdgeInsets.left + contentEdgeInsets.right)
        size.height = ceil(max(size.height, style.minTitleLabelHeight) + contentEdgeInsets.top + contentEdgeInsets.bottom)
        return size
    }
    /// if value is 0.0, CGFloat.greatestFiniteMagnitude is used to calculate the width of the `titleLabel` in `intrinsicContentSize`
    private var proposedTitleLabelWidth: CGFloat = 0.0 {
        didSet {
            if proposedTitleLabelWidth != oldValue {
                invalidateIntrinsicContentSize()
            }
        }
    }
    public init(style: ButtonStyle = .secondaryOutline) {
        self.style = style
        super.init(frame: .zero)
        initialize()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    open func initialize() {
        layer.cornerRadius = style.cornerRadius
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        titleLabel?.font = style.titleFont
        titleLabel?.adjustsFontForContentSizeCategory = true
        update()
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        proposedTitleLabelWidth = bounds.width - (contentEdgeInsets.left + contentEdgeInsets.right)
    }
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13, *) {
            if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
                updateBorderColor()
            }
        }
    }
    public func updateTitleColors() {
        let titleColor = Colors.ButtonsColors.TitleColor.titleWithFilledBackground
        setTitleColor(titleColor, for: .normal)
    }
    private func update() {
        updateTitleColors()
        updateBackgroundColor()
        updateBorderColor()
        layer.borderWidth = style.hasBorders ? Constants.borderWidth : 0
        contentEdgeInsets = style.contentEdgeInsets
    }
    private func updateBackgroundColor() {
            let backgroundColor: UIColor
            if isHighlighted {
                switch style {
                case .primaryFilled, .signInService:
                    backgroundColor = Colors.ButtonsColors.highlightedColor
                default:
                    backgroundColor = background
                }
            } else if !isEnabled {
                switch style {
                case .primaryFilled:
                    backgroundColor = Colors.ButtonsColors.primaryBackgroundColor
                case .signInService:
                    backgroundColor = Colors.ButtonsColors.signInBackgroundColor
                default:
                    backgroundColor = background
                }
            } else {
                switch style {
                case .primaryFilled:
                    backgroundColor = Colors.ButtonsColors.primaryBackgroundColor
                case .signInService:
                    backgroundColor = Colors.ButtonsColors.signInBackgroundColor
                default:
                    backgroundColor = background
                }
            }
            self.backgroundColor = backgroundColor
    }
    private func updateBorderColor() {
        if !style.hasBorders {
            return
        }
            let borderColor: UIColor
            if isHighlighted {
                borderColor = Colors.ButtonsColors.BorderColors.highlightedColor
            } else if !isEnabled {
                borderColor = Colors.ButtonsColors.BorderColors.enabledColor
            } else {
                borderColor = Colors.ButtonsColors.BorderColors.mainColor
            }
            layer.borderColor = borderColor.cgColor
    }
}
