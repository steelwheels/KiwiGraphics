/**
 * @file	KGVelocity.swift
 * @brief	Define KGVelocity data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics

public struct KGVelocity
{
	private var mX:		CGFloat = 0.0
	private var mY:		CGFloat = 0.0
	
	private var mV:		CGFloat = 0.0
	private var mAngle:	CGFloat	= 0.0

	private static func angle2point(v vval:CGFloat, angle aval:CGFloat) -> (CGFloat, CGFloat) {
		let x = vval * sin(aval)
		let y = vval * cos(aval)
		return (x, y)
	}
	
	private static func point2angle(x xval:CGFloat, y yval:CGFloat) -> (CGFloat, CGFloat) {
		let angle = atan2(xval, yval)
		let speed = sqrt(xval*xval + yval*yval)
		return (speed, angle)
	}
	
	public init(x xval:CGFloat, y yval:CGFloat){
		mX           = xval
		mY           = yval
		(mV, mAngle) = KGVelocity.point2angle(x: xval, y: yval)
	}
	
	public init(v vval:CGFloat, angle aval:CGFloat){
		mV       = vval
		mAngle   = aval
		(mX, mY) = KGVelocity.angle2point(v: vval, angle: aval)
	}
	
	public var x:CGFloat {
		get{ return mX }
		set(newx) {
			mX           = newx
			(mV, mAngle) = KGVelocity.point2angle(x: newx, y: mY)
		}
	}
	public var y:CGFloat {
		get{ return mY }
		set(newy) {
			mY		= newy
			(mV, mAngle) = KGVelocity.point2angle(x: mX, y: newy)
		}
	}
	
	public var v:CGFloat {
		get{ return mV }
		set(newv){
			mV       = newv
			(mX, mY) = KGVelocity.angle2point(v: newv, angle: mAngle)
		}
	}
	public var angle:CGFloat {
		get{ return mAngle }
		set(newangle){
			mAngle   = newangle
			(mX, mY) = KGVelocity.angle2point(v: mV, angle: newangle)
		}
	}
	
	public mutating func set(x xval:CGFloat, y yval:CGFloat){
		mX           = xval
		mY           = yval
		(mV, mAngle) = KGVelocity.point2angle(x: x, y: yval)
	}
	
	public mutating func set(v vval:CGFloat, angle aval:CGFloat){
		mV       = vval
		mAngle   = aval
		(mX, mY) = KGVelocity.angle2point(v: vval, angle: aval)
	}

	public var xAndY:CGPoint {
		get { return CGPoint(x: mX, y: mY) }
	}
	
	public var longDescription: String {
		let xstr = NSString(format: "%.2lf", Double(mX))
		let ystr = NSString(format: "%.2lf", Double(mY))
		let vstr = NSString(format: "%.2lf", Double(mV))
		let astr = NSString(format: "%.2lf", Double(Double(mAngle) / M_PI))
		return "((x:\(xstr), y:\(ystr))=(v:\(vstr), angle:\(astr)PI))"
	}
	
	public var shortDescription: String {
		let vstr = NSString(format: "%.2lf", Double(mV))
		let astr = NSString(format: "%.2lf", Double(Double(mAngle) / M_PI))
		return "(v:\(vstr), angle:\(astr)PI)"
	}
	
	public static func serialize(velocity: KGVelocity) -> Dictionary<String, AnyObject> {
		var dict: Dictionary<String, AnyObject>  = [:]
		dict["x"] = NSNumber(value: Double(velocity.x))
		dict["y"] = NSNumber(value: Double(velocity.y))
		return dict
	}

	public static func unserialize(dictionary dict : Dictionary<String, AnyObject>) -> KGVelocity? {
		var x,y: Double
		if let xval = dict["x"] as? NSNumber {
			x = xval.doubleValue
		} else {
			return nil
		}
		if let yval = dict["y"] as? NSNumber {
			y = yval.doubleValue
		} else {
			return nil
		}
		return KGVelocity(x: CGFloat(x), y: CGFloat(y))
	}
}



