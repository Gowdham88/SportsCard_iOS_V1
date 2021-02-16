//
//  SegmentioBuilder.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko on 11/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Segmentio
import UIKit

struct SegmentioBuilder {
    
    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int) {
        segmentioView.addBadge(
            at: index,
            count: 10,
            color: ColorPalette.coral
        )
    }
    
    static func buildSegmentioView(segmentioView: Segmentio, segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3)) {
        segmentioView.setup(
            content: segmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle, segmentioPosition: segmentioPosition)
        )
    }
    
    private static func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "PSA", image: UIImage(named: "tornado")),
            SegmentioItem(title: "BGS", image: UIImage(named: "floods")),
            SegmentioItem(title: "SGC", image: UIImage(named: "wildfires"))
        ]
    }
    
    private static func segmentioOptions(segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3)) -> SegmentioOptions {
        var imageContentMode = UIView.ContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        
        return SegmentioOptions(
            backgroundColor: ColorPalette.white,
            segmentPosition: segmentioPosition,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }
    
    /* segmentioView.setup(content: content, style: .onlyLabel, options: SegmentioOptions(backgroundColor: .white, segmentPosition: .dynamic, scrollEnabled: true, indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1.0, height: 5.0, color: UIColor(red: 83.0, green: 117.0, blue: 252.0, alpha: 1.0)), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(type: SegmentioHorizontalSeparatorType.bottom, height: 0.5, color: .lightGray), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(ratio: 0, color: .gray), imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear,titleFont:UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .black),selectedState: SegmentioState(backgroundColor: UIColor(red: 83.0/255.0, green: 117.0/255.0, blue: 252.0/255.0, alpha: 1.0),titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .white),highlightedState: SegmentioState(backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),titleFont:UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .black)), animationDuration: 0.1))*/
    
    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont.exampleAvenirMedium(ofSize: 13)
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .white,
                titleFont: font,
                titleTextColor: .black
            ),
            selectedState: segmentioState(
                backgroundColor: UIColor(red: 83.0/255.0, green: 117.0/255.0, blue: 252.0/255.0, alpha: 1.0),
                titleFont: font,
                titleTextColor: ColorPalette.white
            ),
            highlightedState: segmentioState(
                backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),
                titleFont: font,
                titleTextColor: .black
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    
    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 5,
            color: ColorPalette.coral
        )
    }
    
    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: ColorPalette.whiteSmoke
        )
    }
    
    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 1,
            color: ColorPalette.whiteSmoke
        )
    }
    
}
