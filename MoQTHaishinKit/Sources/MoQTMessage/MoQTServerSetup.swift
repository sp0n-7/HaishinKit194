import Foundation

public struct MoQTServerSetup: MoQTMessage {
    public let type: MoQTMessageType = .serverSetup
    public let selectedVersion: Int
    public let setupParameters: [MoQTSetupParameter]

    public var payload: Data {
        get throws {
            throw MoQTMessageError.notImplemented
        }
    }

    init(_ payload: inout MoQTPayload) throws {
        selectedVersion = try payload.getInt()
        let setupParametersCounts = try payload.getInt()
        var setupParameters: [MoQTSetupParameter] = .init()
        for _ in 0..<setupParametersCounts {
            do {
                setupParameters.append(try .init(&payload))
            } catch {
                logger.warn(error)
            }
        }
        self.setupParameters = setupParameters
    }
}