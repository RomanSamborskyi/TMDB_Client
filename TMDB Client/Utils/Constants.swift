//
//  Constants.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation


struct Constants {
    
    static let account_id: String = "account_id"
    
    static let sessionKey: String = "session_id"
    static let apiKey: String = ProcessInfo.processInfo.environment["API_KEY"] ?? "NO KEY"
    
    static let deleteListHeader = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzMxOTkyMi42NjQ0Mywic3ViIjoiNjQ1M2RlYzZkNDhjZWUwMGUxMzNhMDZkIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.KOpOq5eq7eJrAXTTIubRiN9Qxo4dz1cxGIc0wYeH5ec"
      ]
    
    static let clearListHeader = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzMxOTkyMi42NjQ0Mywic3ViIjoiNjQ1M2RlYzZkNDhjZWUwMGUxMzNhMDZkIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.KOpOq5eq7eJrAXTTIubRiN9Qxo4dz1cxGIc0wYeH5ec"
      ]
    
    static let addRatingHeaders =  [
        "accept": "application/json",
        "Content-Type": "application/json;charset=utf-8",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzAxOTc1NC4zOTY1MTMsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdySVI1EWaIw5YpFeOLP4mbv2FW37mGMs4V9gwps0r8"
      ]
    
    static let addToFavoriteHeader = [
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzAxOTc1NC4zOTY1MTMsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdySVI1EWaIw5YpFeOLP4mbv2FW37mGMs4V9gwps0r8"
      ]
    
    static let addToWatchListHeader = [
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMTE0NTkxMC4xMjA1MTMsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lcCwZRSZKtDGUo5Bri9YQ7cFZzABb07mqhKY_jt8MGg"
      ]
    
    static let watchListheader = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMTA0NjkyNC4wMjgyNDksInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KgpKgDGA6OQQ2-8QP2QcjH0eqi7Xz_40gxlbU5OhnBo"
        ]
    
    static let listsHeader = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDk1MjU3MS4yMjY2OTMsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EG1uBVtmGkg075gO3v_SymHi36lfdYDDhAwMK_Gv1vI"
      ]
    
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
