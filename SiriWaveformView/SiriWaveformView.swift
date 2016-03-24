//
//  SiriWaveformView.swift
//  SiriWaveformView
//
//  Created by Jonathan on 3/14/15.
//  Copyright (c) 2015 Underwood. All rights reserved.
//

import UIKit
import Darwin

let pi = M_PI

@IBDesignable
public class SiriWaveformView: UIView {
    private var _phase: CGFloat = 0.0
    private var _amplitude: CGFloat = 0.0

    @IBInspectable public var waveColor: UIColor = UIColor.blackColor()
    @IBInspectable public var numberOfWaves = 5
    @IBInspectable public var primaryWaveLineWidth: CGFloat = 3.0
    @IBInspectable public var secondaryWaveLineWidth: CGFloat = 1.0
    @IBInspectable public var idleAmplitude: CGFloat = 0.01
    @IBInspectable public var frequency: CGFloat = 1.5
    @IBInspectable public var density: CGFloat = 5
    @IBInspectable public var phaseShift: CGFloat = -0.15

    @IBInspectable public var amplitude: CGFloat {
        get {
            return _amplitude
        }
    }

    public func updateWithLevel(level: CGFloat) {
        _phase += phaseShift
        _amplitude = fmax(level, idleAmplitude)
        setNeedsDisplay()
    }

    override public func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, bounds)

        backgroundColor?.set()
        CGContextFillRect(context, rect)

        // Draw multiple sinus waves, with equal phases but altered
        // amplitudes, multiplied by a parable function.
        for waveNumber in 0...numberOfWaves {
            let context = UIGraphicsGetCurrentContext()

            CGContextSetLineWidth(context, (waveNumber == 0 ? primaryWaveLineWidth : secondaryWaveLineWidth))

            let halfHeight = CGRectGetHeight(bounds) / 2.0
            let width = CGRectGetWidth(bounds)
            let mid = width / 2.0

            let maxAmplitude = halfHeight - 4.0 // 4 corresponds to twice the stroke width

            // Progress is a value between 1.0 and -0.5, determined by the current wave idx, which is used to alter the wave's amplitude.
            let progress: CGFloat = 1.0 - CGFloat(waveNumber) / CGFloat(numberOfWaves)
            let normedAmplitude = (1.5 * progress - 0.5) * amplitude

            let multiplier: CGFloat = 1.0
            waveColor.colorWithAlphaComponent(multiplier * CGColorGetAlpha(waveColor.CGColor)).set()

            var x: CGFloat = 0.0
            while x < width + density {
                // Use a parable to scale the sinus wave, that has its peak in the middle of the view.
                let scaling = -pow(1 / mid * (x - mid), 2) + 1

                // Original Code:
                // CGFloat y = scaling * maxAmplitude * normedAmplitude * sinf(2 * M_PI *(x / width) * self.frequency + self.phase) + halfHeight;
                let tempCasting: CGFloat = 2.0 * CGFloat(pi) * CGFloat(x / width) * frequency + _phase
                let y = scaling * maxAmplitude * normedAmplitude * CGFloat(sinf(Float(tempCasting))) + halfHeight

                if x == 0 {
                    CGContextMoveToPoint(context, x, y)
                } else {
                    CGContextAddLineToPoint(context, x, y)
                }

                x += density
            }

            CGContextStrokePath(context)
        }
    }
}
