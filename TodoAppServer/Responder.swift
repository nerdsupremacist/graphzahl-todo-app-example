
import Foundation
import LeoQL
import GraphQL
import Vapor

struct Query : Content {
    let query: String
}

extension GraphQLResult: ResponseEncodable, LosslessHTTPBodyRepresentable {
    public func encode(for req: Request) throws -> EventLoopFuture<Response> {
        let response = HTTPResponse(status: .ok, body: self)
        return req.eventLoop.newSucceededFuture(result: Response(http: response, using: req.sharedContainer))
    }

    public func convertToHTTPBody() -> HTTPBody {
        do {
            return HTTPBody(data: try JSONEncoder().encode(self))
        } catch {
            return HTTPBody()
        }
    }
}
