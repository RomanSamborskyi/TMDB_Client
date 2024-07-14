//
//  Constants.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation


struct Constants {
    
    static let userIdKey: String = "userId"
    
    static let sessionKey: String = "session_id"
    
    static let apiKey: String = "14512c9189d3ba6fe3a1de6324ad576a"
    
    static let deleteSessionHeader = [
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDU0MzIwNi42NzcyNTIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdCbZoe-128Wrybd6WFkZC-3VFSuzkGXXTrxGALDleM"
      ]
    
    static let tokenRequestHeader = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDU0MzIwNi42NzcyNTIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdCbZoe-128Wrybd6WFkZC-3VFSuzkGXXTrxGALDleM"
      ]
    static let validateTokenWithLoginHeader = [
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDU0MzIwNi42NzcyNTIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdCbZoe-128Wrybd6WFkZC-3VFSuzkGXXTrxGALDleM"
      ]
    static let createNewSessionHeader = [
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDU0MzIwNi42NzcyNTIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdCbZoe-128Wrybd6WFkZC-3VFSuzkGXXTrxGALDleM"
      ]
}
