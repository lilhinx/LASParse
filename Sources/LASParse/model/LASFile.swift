import Foundation


public enum LASFileError:Error
{
	case invalidSignature
}



internal let LASFile_SIGNATURE:String = "LASF"

@available(macOS 10.15.4, *)
extension FileHandle
{
	func readValue<T>( of valueType:T )throws ->T?
	{
		guard let data = try read( upToCount:MemoryLayout<T>.size ) else
		{
			return nil
		}
		
		return data.withUnsafeBytes
		{
			ptr in
			return ptr.load( as:T.self )
		}
	}
}

extension CharacterSet
{
	static let whitespacesNewlinesAndNulls = CharacterSet.whitespacesAndNewlines.union(CharacterSet(["\0"]))
}

@available(macOS 10.15.4, *)
public class LASFile
{
	
	
	
    private var file:FileHandle
    public init( url:URL ) throws
    {
		try file = FileHandle.init(forReadingFrom:url)
    }
	
//	public func read( ) throws
//	{
//		let sig = try self.readSignature()
//		guard isValidSignature else
//		{
//			throw LASFileError.invalidSignature
//		}
//	}
	
	private func readString( of length:Int ) throws ->String?
	{
		guard let data = try file.read( upToCount:MemoryLayout<CChar>.size*length ) else
		{
			return nil
		}
		
		guard let dataString = String.init( data:data, encoding:.ascii) else
		{
			return nil
		}
		
		return dataString.trimmingCharacters(in:.whitespacesNewlinesAndNulls)
	}
	
	internal func readSignature( )throws ->String?
	{
		return try readString( of:4 )
	}
	
	internal func readFileSourceID( )throws -> CUnsignedShort?
	{
		return try file.readValue(of:CUnsignedShort( ) )
	}
	
	internal func readGlobalEncodingOptions( )throws -> GlobalEncodingOptions?
	{
		guard let rawValue = try file.readValue( of:CUnsignedShort() ) else
		{
			return nil
		}
		return GlobalEncodingOptions.init( rawValue:rawValue )
	}

	internal func readProjectID( ) throws -> UUID?
	{
		return try file.readValue( of: UUID() )
	}
	
	internal func readVersionMajor( ) throws -> CUnsignedChar?
	{
		return try file.readValue( of: CUnsignedChar() )
	}

	internal func readVersionMinor( ) throws -> CUnsignedChar?
	{
		return try file.readValue( of: CUnsignedChar() )
	}
	
	internal func readSystemIdentifier( ) throws -> String?
	{
		return try readString( of:32 )
	}
	
	internal func readGeneratingSoftware( ) throws -> String?
	{
		return try readString( of:32 )
	}
	
	internal func readFileCreationDayOfYear( ) throws -> CUnsignedShort?
	{
		return try file.readValue( of:CUnsignedShort( ) )
	}
	
	internal func readFileCreationYear( ) throws -> CUnsignedShort?
	{
		return try file.readValue( of:CUnsignedShort( ) )
	}
	
	internal func readHeaderSize( ) throws -> CUnsignedShort?
	{
		return try file.readValue( of:CUnsignedShort( ) )
	}
	
	internal func readOffsetToPointData( ) throws -> CUnsignedShort?
	{
		return try file.readValue( of:CUnsignedShort( ) )
	}
	
	internal func readNumberOfVariableLengthRecords( ) throws -> CUnsignedShort?
	{
		return try file.readValue( of:CUnsignedShort( ) )
	}
	
	internal func readPointDataRecordFormat( ) throws -> CUnsignedChar?
	{
		return try file.readValue( of:CUnsignedChar( ) )
	}
	
	internal func readPointDataRecordLength( ) throws -> CUnsignedShort?
	{
		return try file.readValue( of:CUnsignedShort( ) )
	}
	
	internal func readLegacyNumberOfPointRecords( ) throws -> CUnsignedLong?
	{
		return try file.readValue( of:CUnsignedLong( ) )
	}
	
	internal func readLegacyNumberOfPointByReturn( ) throws -> [CUnsignedLong]?
	{
		var ret:[CUnsignedLong] = [ ]
		for _ in 0..<5
		{
			guard let value = try file.readValue( of:CUnsignedLong( ) ) else {
				continue
			}
			ret.append( value )
		}
		return ret
	}
	
	internal func readXScaleFactor( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readYScaleFactor( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readZScaleFactor( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readXOffset( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readYOffset( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readZOffset( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readMaxX( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readMinX( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readMaxY( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readMinY( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readMaxZ( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readMinZ( ) throws -> CDouble?
	{
		return try file.readValue( of:CDouble( ) )
	}
	
	internal func readStartOfWaveformDataPacketRecord( ) throws -> CUnsignedLongLong?
	{
		return try file.readValue( of:CUnsignedLongLong( ) )
	}
	
	internal func readStartOfFirstExtendedVariableLengthRecord( ) throws -> CUnsignedLongLong?
	{
		return try file.readValue( of:CUnsignedLongLong( ) )
	}
	
	internal func readNumberOfExtendedVariableLengthRecords( ) throws -> CUnsignedLong?
	{
		return try file.readValue( of:CUnsignedLong( ) )
	}
	
	internal func readNumberOfPointRecords( ) throws -> CUnsignedLongLong?
	{
		return try file.readValue( of:CUnsignedLongLong( ) )
	}
	
	internal func readNumberOfPointsByReturn( ) throws -> [CUnsignedLongLong]?
	{
		var ret:[CUnsignedLongLong] = [ ]
		for _ in 0..<15
		{
			guard let value = try file.readValue( of:CUnsignedLongLong( ) ) else {
				continue
			}
			ret.append( value )
		}
		return ret
	}
}


