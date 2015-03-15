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

@IBDesignable class SiriWaveformView: UIView
{
    private var _phase: CGFloat = 0.0
    private var _amplitude: CGFloat = 0.0

    @IBInspectable var waveColor = UIColor.whiteColor()
    @IBInspectable var numberOfWaves = 5
    @IBInspectable var primaryWaveLineWidth: CGFloat = 3.0
    @IBInspectable var secondaryWaveLineWidth: CGFloat = 1.0
    @IBInspectable var idleAmplitude: CGFloat = 0.01
    @IBInspectable var frequency: CGFloat = 1.5
    @IBInspectable var density: CGFloat = 5
    @IBInspectable var phaseShift: CGFloat = -0.15

    @IBInspectable var amplitude: CGFloat {
        get {
            return _amplitude
        }
    }

    func updateWithLevel(level: CGFloat) {
        _phase += phaseShift
        _amplitude = fmax(level, idleAmplitude)
        setNeedsDisplay()
    }

    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, bounds)

        backgroundColor?.set()
        CGContextFillRect(context, rect)

        // We draw multiple sinus waves, with equal phases but altered
        // amplitudes, multiplied by a parable function.
        for var i = 0; i < numberOfWaves; i++ {
            var context = UIGraphicsGetCurrentContext()

            CGContextSetLineWidth(context, (i == 0 ? primaryWaveLineWidth : secondaryWaveLineWidth))

            var halfHeight = CGRectGetHeight(bounds) / 2.0
            var width = CGRectGetWidth(bounds)
            var mid = width / 2.0

            let maxAmplitude = halfHeight - 4.0 // 4 corresponds to twice the stroke width

            // Progress is a value between 1.0 and -0.5, determined by the current wave idx, which is used to alter the wave's amplitude.
            var progress = CGFloat(1.0 - Float(i) / Float(numberOfWaves))
            var normedAmplitude = (1.5 * progress - 0.5) * amplitude

            var multiplier = CGFloat(min(1.0, (progress / 3.0 * 2.0) + (1.0 / 3.0)))
            waveColor.colorWithAlphaComponent(multiplier * CGColorGetAlpha(waveColor.CGColor)).set()

            for var x: CGFloat = 0.0; x < width + density; x += density {
                // We use a parable to scale the sinus wave, that has its peak in the middle of the view.
                var scaling = -pow(1 / mid * (x - mid), 2) + 1

                // Original Code:
                // CGFloat y = scaling * maxAmplitude * normedAmplitude * sinf(2 * M_PI *(x / width) * self.frequency + self.phase) + halfHeight;
                var tempCasting = CGFloat(2.0 * Float(pi) * Float(x / width)) * frequency + _phase
                var y = scaling * maxAmplitude * normedAmplitude * CGFloat(sinf(Float(tempCasting))) + halfHeight

                if x == 0 {
                    CGContextMoveToPoint(context, x, y)
                } else {
                    CGContextAddLineToPoint(context, x, y)
                }
            }

            CGContextStrokePath(context)
        }
    }
}
