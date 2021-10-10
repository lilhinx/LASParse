//
//  File.swift
//  
//
//  Created by Chris Hinkle on 10/4/21.
//

import Foundation

struct GlobalEncodingOptions:OptionSet
{
	let rawValue:CUnsignedShort

	static let GPSTimeType  = GlobalEncodingOptions(rawValue: 1 << 0)
	static let waveformDataPacketsInternal = GlobalEncodingOptions(rawValue: 1 << 1)
	static let waveformDataPacketsExternal  = GlobalEncodingOptions(rawValue: 1 << 2)
	static let syntheticReturnNumbers  = GlobalEncodingOptions(rawValue: 1 << 3)
	static let WKT  = GlobalEncodingOptions(rawValue: 1 << 4)
}






