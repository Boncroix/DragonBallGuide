//
//  NetwortkModelTests.swift
//  DragonBallGuideTests
//
//  Created by Jose Bueno Cruz on 20/1/24.
//

import XCTest
@testable import DragonBallGuide

final class NetwortkModelTests: XCTestCase {
    private var sut: NetworkModel!
    private var expectedToken = "eyJraWQiOiJwcml2YXRlIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJpZGVudGlmeSI6IjkxMDBFQjAxLTRGREItNEU0RC1CNzdELTg1NTYzRjREODg4MSIsImV4cGlyYXRpb24iOjY0MDkyMjExMjAwLCJlbWFpbCI6ImJvbmNyb2l4QGdtYWlsLmNvbSJ9.aAIsq1suoSyP8KV1M9LG4Hp75a9PdRyW2asuXVcq7L0"
    private var expectedResponse = """
[
    {
        "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/Roshi.jpg?width=300",
        "name": "Maestro Roshi",
        "id": "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3",
        "favorite": true,
        "description": "Es un maestro de artes marciales que tiene una escuela, donde entrenará a Goku y Krilin para los Torneos de Artes Marciales. Aún en los primeros episodios había un toque de tradición y disciplina, muy bien representada por el maestro. Pero Muten Roshi es un anciano extremadamente pervertido con las chicas jóvenes, una actitud que se utilizaba en escenas divertidas en los años 80. En su faceta de experto en artes marciales, fue quien le enseñó a Goku técnicas como el Kame Hame Ha"
    }
]
"""
    private var expectedName = "Maestro Roshi"
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let client = APIClient(session: session)
        sut = NetworkModel(client: client)
        expectedToken = "eyJraWQiOiJwcml2YXRlIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJpZGVudGlmeSI6IjkxMDBFQjAxLTRGREItNEU0RC1CNzdELTg1NTYzRjREODg4MSIsImV4cGlyYXRpb24iOjY0MDkyMjExMjAwLCJlbWFpbCI6ImJvbmNyb2l4QGdtYWlsLmNvbSJ9.aAIsq1suoSyP8KV1M9LG4Hp75a9PdRyW2asuXVcq7L0"
        expectedResponse = """
[
    {
        "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/Roshi.jpg?width=300",
        "name": "Maestro Roshi",
        "id": "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3",
        "favorite": true,
        "description": "Es un maestro de artes marciales que tiene una escuela, donde entrenará a Goku y Krilin para los Torneos de Artes Marciales. Aún en los primeros episodios había un toque de tradición y disciplina, muy bien representada por el maestro. Pero Muten Roshi es un anciano extremadamente pervertido con las chicas jóvenes, una actitud que se utilizaba en escenas divertidas en los años 80. En su faceta de experto en artes marciales, fue quien le enseñó a Goku técnicas como el Kame Hame Ha"
    }
]
"""
        expectedName = "Maestro Roshi"
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        expectedToken = ""
        expectedResponse = ""
        expectedName = ""
    }
    
    func test_login() throws {
        // Given
        let tokenData = try XCTUnwrap(expectedToken.data(using: .utf8))
        let (user, password) = ("user", "password")
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let loginString =  String(format: "%@:%@", user, password)
            let base64String = loginString.data(using: .utf8)!.base64EncodedString()
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(
                request.value(forHTTPHeaderField:
                                "Authorization"),
                "Basic \(base64String)"
            )
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: URL(string: "https://dragonball.keepcoding.education/")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: ["Content-Type": "application/json"]
                )
            )
            return (response, tokenData)
        }
        
        // When
        let expectation = expectation(description: "Login Success")
        var receivedToken: String?
        sut.login(
            user: user,
            password: password
        ) { result in
            guard case let .success (token) = result else {
                XCTFail("Expected sucess but received \(result)")
                return
            }
            receivedToken = token
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(receivedToken)
        XCTAssertEqual(receivedToken, expectedToken)
    }
    
    func test_getModel() throws {
        // Given
        let responseData = try XCTUnwrap(expectedResponse.data(using: .utf8))
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(
                request.value(forHTTPHeaderField:
                                "Authorization"),
                "Bearer \(self.expectedToken)"
            )
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: URL(string: "https://dragonball.keepcoding.education")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: ["Content-Type": "application/json"]
                )
            )
            return (response, responseData)
        }
        
        // When
        let expectation = expectation(description: "Get Model Success")
        var receivedDragonBallModels: [DragonBallModel]?
        sut.getModel(path: "/api/heros/all", name: "name", value: "Maestro Roshi") { result in
            guard case let .success (dragonBallmodel) = result else {
                XCTFail("No DragonBallModels received \(result)")
                return
            }
            receivedDragonBallModels = dragonBallmodel
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(receivedDragonBallModels?[0].name ?? "", self.expectedName)
        XCTAssertNotNil(receivedDragonBallModels)
        XCTAssertGreaterThan(receivedDragonBallModels?.count ?? 0, 0, "Expecting at least one DragonBallModel")
    }
}
