//
//  LeetCodeApi.swift
//  LeetCoding
//
//  Created by octyu on 2022/10/13.
//

import Foundation

public struct LeetCodeApi {
    
    public var cookie: String?
    public var session = URLSession(configuration: .ephemeral)
    
    private let leetCodeCn = "https://leetcode.cn/graphql/"
    private let postHttpMethod = "POST"
    
    /**
     HTTP 请求
     */
    private func request<T>(httpMethod: String = "GET", url: String,
                            args: [String: Any]? = nil,
                            decodeClass: T.Type,
                            origin: String? = nil) async throws -> (T?, URLResponse?) where T : Decodable {
        let urlComponents = NSURLComponents(string: url)!
      
        if httpMethod != postHttpMethod && args != nil {
          urlComponents.queryItems = args?.map({(k, v) in return NSURLQueryItem(name: k, value: "\(v)")}) as [URLQueryItem]?
        }

        guard let requestUrl = urlComponents.url else {
          return (nil, nil)
        }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("origin", forHTTPHeaderField: "https://leetcode.cn")
        
        if let cookie = cookie {
            request.addValue(cookie, forHTTPHeaderField: "Cookie")
        }
        
        if let origin = origin {
            request.addValue(origin, forHTTPHeaderField: "origin")
        }
        
        if httpMethod == postHttpMethod && args != nil {
          request.httpBody = try? JSONSerialization.data(withJSONObject: args as Any)
        }

        let (data, response) = try await session.data(for: request)

        let decoder = JSONDecoder()

        let obj = try decoder.decode(decodeClass.self, from: data)

        return (obj, response)
    }

    
    public func getUserProfile() async throws -> HttpResponse<UserProfile>? {
        
        let (data, _) = try await request (
            httpMethod: postHttpMethod,
            url: leetCodeCn,
            args: [
                "query": "\n query globalData {\n userStatus {\n username\n realName\n avatar\n }\n }\n"
            ],
            decodeClass: HttpResponse<UserProfile>.self
        )
        return data
    }
    
    public func getProblemList() async throws -> HttpResponse<ProblemList>? {
        
        let (data, _) = try await request (
            httpMethod: postHttpMethod,
            url: leetCodeCn,
            args: [
                "query": "\n    query problemsetQuestionList($categorySlug: String, $limit: Int, $skip: Int, $filters: QuestionListFilterInput) {\n  problemsetQuestionList(\n    categorySlug: $categorySlug\n    limit: $limit\n    skip: $skip\n    filters: $filters\n  ) {\n    hasMore\n    total\n    questions {\n      acRate\n      difficulty\n      freqBar\n      frontendQuestionId\n      isFavor\n      paidOnly\n      solutionNum\n      status\n      title\n      titleCn\n      titleSlug\n      topicTags {\n        name\n        nameTranslated\n        id\n        slug\n      }\n      extra {\n        hasVideoSolution\n        topCompanyTags {\n          imgUrl\n          slug\n          numSubscribed\n        }\n      }\n    }\n  }\n}\n    ",
                "variables": "{\"categorySlug\": \"\",\"skip\": 0,\"limit\": 50,\"filters\":{}}"
            ],
            decodeClass: HttpResponse<ProblemList>.self
        )
        return data
    }
    
    public func getProblemDetail(titleSlug: String) async throws -> HttpResponse<ProblemDetail>? {
        
        let (data, _) = try await request(
            httpMethod: postHttpMethod,
            url: leetCodeCn,
            args: [
                "operationName": "questionData",
                "variables": [
                    "titleSlug": titleSlug
                ],
                "query":"query questionData($titleSlug: String!) {\n  question(titleSlug: $titleSlug) {\n    questionId\n    questionFrontendId\n    categoryTitle\n    boundTopicId\n    title\n    titleSlug\n    content\n    translatedTitle\n    translatedContent\n    isPaidOnly\n    difficulty\n    likes\n    dislikes\n    isLiked\n    similarQuestions\n    contributors {\n      username\n      profileUrl\n      avatarUrl\n      __typename\n    }\n    langToValidPlayground\n    topicTags {\n      name\n      slug\n      translatedName\n      __typename\n    }\n    companyTagStats\n    codeSnippets {\n      lang\n      langSlug\n      code\n      __typename\n    }\n    stats\n    hints\n    solution {\n      id\n      canSeeDetail\n      __typename\n    }\n    status\n    sampleTestCase\n    metaData\n    judgerAvailable\n    judgeType\n    mysqlSchemas\n    enableRunCode\n    envInfo\n    book {\n      id\n      bookName\n      pressName\n      source\n      shortDescription\n      fullDescription\n      bookImgUrl\n      pressImgUrl\n      productUrl\n      __typename\n    }\n    isSubscribed\n    isDailyQuestion\n    dailyRecordStatus\n    editorType\n    ugcQuestionId\n    style\n    exampleTestcases\n    jsonExampleTestcases\n    __typename\n  }\n}\n"
                
            ],
            decodeClass: HttpResponse<ProblemDetail>.self
        )
        return data
    }
    
    public func submitSolution(questionId: String, lang: String,
                               code: String, questionSlug: String) async throws -> SubmitSolutionResponse? {
        let url = "https://leetcode.cn/problems/" + questionSlug + "/submit/"
        let (data, _) = try await request(
            httpMethod: postHttpMethod,
            url: url,
            args: [
                "question_id": questionId,
                "lang": lang,
                "typed_code": code,
                "test_mode": false,
                "test_judger": "",
                "questionSlug": questionSlug
            ],
            decodeClass: SubmitSolutionResponse.self,
            origin: "https://leetcode.cn"
        )
        return data
    }
}
