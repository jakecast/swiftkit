import Foundation

public extension NetworkRequest {
    private static func responseSerializerData() -> NetworkSerializerBlock {
        return {(request, response, data) -> NetworkSerializerResponse in
            return (data, nil)
        }
    }

    func responseData(
        queue: NSOperationQueue?=nil,
        completionHandler: NetworkResponseBlock
    ) -> Self {
        return self.response(
            serializer: NetworkRequest.responseSerializerData(),
            queue: queue,
            completionHandler: completionHandler
        )
    }
}

public extension NetworkRequest {
    private static func responseSerializerString(encoding: NSStringEncoding=NSUTF8StringEncoding) -> NetworkSerializerBlock {
        return {(_, _, data) -> NetworkSerializerResponse in
            let response: (serializedData: AnyObject?, serializerError: NSError?)
            if let stringData = data {
                response = (NSString(data: stringData, encoding: encoding), nil)
            }
            else {
                response = (nil, nil)
            }
            return response
        }
    }

    func responseString(
        encoding: NSStringEncoding=NSUTF8StringEncoding,
        queue: NSOperationQueue?=nil,
        completionHandler: (NSURLRequest, NSHTTPURLResponse?, String?, NSError?) -> (Void)
    ) -> Self {
        return self.response(
            serializer: NetworkRequest.responseSerializerString(encoding: encoding),
            queue: queue,
            completionHandler: {(request, response, string, error) -> (Void) in
                completionHandler(request, response, string as? String, error)
        })
    }
}

public extension NetworkRequest {
    private static func responseSerializerJSON(
        options: NSJSONReadingOptions=NSJSONReadingOptions.AllowFragments
    ) -> NetworkSerializerBlock {
        return {(request, response, data) -> NetworkSerializerResponse in
            var json: AnyObject?
            var serializationError: NSError?
            if let jsonData = data {
                json = NSJSONSerialization.JSONObjectWithData(jsonData, options: options, error: &serializationError)
            }
            return (json, serializationError)
        }
    }

    func responseJSON(
        options: NSJSONReadingOptions=NSJSONReadingOptions.AllowFragments,
        queue: NSOperationQueue?=nil,
        completionHandler: NetworkResponseBlock
    ) -> Self {
        return self.response(
            serializer: NetworkRequest.responseSerializerJSON(options: options),
            queue: queue,
            completionHandler: completionHandler
        )
    }
}
