//
//  main.swift
//  NikeNotification
//
//  Created by Ryan Krol on 08/12/2018.
//
//  Song: Illuminate - Tender

import Foundation
import NikeNotificationsLib

func run() {
    let mailClient = EmailClient()

    do {
        let existingUrls = try FileInteractions.fetch()
        let newUrls = try PageScraper.fetch()

        // if there are no new shoes, just return
        guard !newUrls.isSubset(of: existingUrls) else {
            return
        }

        let updateUrls = existingUrls.union(newUrls)
        let updateString = updateUrls.joined(separator: "\n")
        try FileInteractions.push(urls: updateString)

        mailClient.sendMail("ryankrol.m@gmail.com", images: newUrls)
    } catch {
        mailClient.sendFailureUpdate("ryankrol.m@gmail.com", error: error)
    }

}

run()
