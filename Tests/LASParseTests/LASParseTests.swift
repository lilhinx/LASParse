import XCTest
@testable import LASParse

final class LASParseTests: XCTestCase
{
    func testRead() throws {
        
		let bundle:Bundle = .module
		let lidarFileUrl = bundle.url(forResource:"Job655599_2015_ME_MA_lidar", withExtension:"las")!
		
		XCTAssertNotNil(lidarFileUrl)
			

		let lidarFile = try LASFile.init( url:lidarFileUrl)
		XCTAssertNotNil(lidarFile)
		
		let sig = try lidarFile.readSignature( )!
		XCTAssertEqual( sig, LASFile_SIGNATURE)
		
		let fileSourceID = try lidarFile.readFileSourceID( )!
		XCTAssertEqual( fileSourceID, 0 )
		
		let globalEncodingOptions = try lidarFile.readGlobalEncodingOptions( )!
		XCTAssertTrue( globalEncodingOptions.contains( .GPSTimeType) )
		XCTAssertFalse( globalEncodingOptions.contains( .waveformDataPacketsExternal) )
		XCTAssertFalse( globalEncodingOptions.contains( .waveformDataPacketsInternal) )
		XCTAssertFalse( globalEncodingOptions.contains( .syntheticReturnNumbers) )
		XCTAssertTrue( globalEncodingOptions.contains( .WKT) )
	
		let projectID = try lidarFile.readProjectID( )!
		XCTAssertEqual( projectID.uuidString, "9173E01C-7B25-D44F-B248-4D10E1835363")
		
		let versionMajor = try lidarFile.readVersionMajor( )!
		XCTAssertEqual( versionMajor, 1)
		
		let versionMinor = try lidarFile.readVersionMinor( )!
		XCTAssertEqual( versionMinor, 4)
		
		let systemIdentifier = try lidarFile.readSystemIdentifier( )!
		XCTAssertEqual( systemIdentifier, "LAStools (c) by rapidlasso GmbH" )
		
		let generatingSoftware = try lidarFile.readGeneratingSoftware( )!
		XCTAssertEqual( generatingSoftware, "lasduplicate (200101) commercia" )
		
		let fileCreationDayOfYear = try lidarFile.readFileCreationDayOfYear( )!
		XCTAssertEqual( fileCreationDayOfYear, 301 )
		
		let fileCreationYear = try lidarFile.readFileCreationYear( )!
		XCTAssertEqual( fileCreationYear, 2015 )
		
		let headerSize = try lidarFile.readHeaderSize( )!
		XCTAssertEqual( headerSize, 375 )
		
		let offsetToPointData = try lidarFile.readOffsetToPointData( )!
		XCTAssertEqual( offsetToPointData, 1461 )
		
		let numberOfVariableLengthRecords = try lidarFile.readNumberOfVariableLengthRecords( )!
		XCTAssertEqual( numberOfVariableLengthRecords, 0 )
		
		let pointDataRecordFormat = try lidarFile.readPointDataRecordFormat( )!
		XCTAssertEqual( pointDataRecordFormat, 1 )
		
		let pointDataRecordLength = try lidarFile.readPointDataRecordLength( )!
		XCTAssertEqual( pointDataRecordLength, 0 )
		
		let legacyNumberOfPointRecords = try lidarFile.readLegacyNumberOfPointRecords( )!
		XCTAssertEqual( legacyNumberOfPointRecords, 1967616 )
		
		let legacyNumberOfPointByReturn = try lidarFile.readLegacyNumberOfPointByReturn( )!
		XCTAssertEqual( legacyNumberOfPointByReturn, [0, 0, 5165088341154070528, 5165088342219717345, 5165088342219717345] )
		
		let xScaleFactor = try lidarFile.readXScaleFactor( )!
		XCTAssertEqual( xScaleFactor, 5.26499483e-315 )
		
		let yScaleFactor = try lidarFile.readYScaleFactor( )!
		XCTAssertEqual( yScaleFactor, 5.393808726e-315 )
		
		let zScaleFactor = try lidarFile.readZScaleFactor( )!
		XCTAssertEqual( zScaleFactor, 5.410832884e-315 )
		
		let xOffset = try lidarFile.readXOffset( )!
		XCTAssertEqual( xOffset, 5.110135058468756e-210 )
		
		let yOffset = try lidarFile.readYOffset( )!
		XCTAssertEqual( yOffset, -4.1614946546032454e+160 )
		
		let zOffset = try lidarFile.readZOffset( )!
		XCTAssertEqual( zOffset, 1.9035983772564934e+185 )
		
		let maxX = try lidarFile.readMaxX( )!
		XCTAssertEqual( maxX, 3.942650791224922e+234 )
		
		let minX = try lidarFile.readMinX( )!
		XCTAssertEqual( minX, 2.3934350431269636e-259 )
		
		let maxY = try lidarFile.readMaxY( )!
		XCTAssertEqual( maxY, 1.0811503521933046e-160 )
		
		let minY = try lidarFile.readMinY( )!
		XCTAssertEqual( minY, 5.335339204e-315 )
		
		let maxZ = try lidarFile.readMaxZ( )!
		XCTAssertEqual( maxZ, 0.0 )
		
		let minZ = try lidarFile.readMinZ( )!
		XCTAssertEqual( minZ, 0.0 )
		
		let startOfWaveformDataPacketRecord = try lidarFile.readStartOfWaveformDataPacketRecord( )!
		XCTAssertEqual( startOfWaveformDataPacketRecord, 24953384 )
		
		let startOfFirstExtendedVariableLengthRecord = try lidarFile.readStartOfFirstExtendedVariableLengthRecord( )!
		XCTAssertEqual( startOfFirstExtendedVariableLengthRecord, 15346142 )
		
		let numberOfExtendedVariableLengthRecords = try lidarFile.readNumberOfExtendedVariableLengthRecords( )!
		XCTAssertEqual( numberOfExtendedVariableLengthRecords, 6864061 )
		
		let numberOfPointRecords = try lidarFile.readNumberOfPointRecords( )!
		XCTAssertEqual( numberOfPointRecords, 2712484 )
		
		let numberOfPointsByReturn = try lidarFile.readLegacyNumberOfPointByReturn()!
		XCTAssertEqual( numberOfPointsByReturn, [29830, 856, 11, 0, 0] )
    }
}
