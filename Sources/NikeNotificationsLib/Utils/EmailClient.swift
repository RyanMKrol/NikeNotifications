//
//  EmailClient.swift
//  NikeNotificationsLib
//
//  Created by Ryan Krol on 08/12/2018.
//

import Foundation
import SwiftSMTP

public class EmailClient {

    private let fromEmail: Mail.User
    private let client: SMTP
    private let hostName = "smtp.gmail.com"
    private let emailAccount = "ryankrol.m@gmail.com"
    private let emailPassword = "example"

    public init() {
        self.fromEmail = Mail.User(name: "NikeNotifications", email: self.emailAccount)
        self.client = SMTP(
            hostname: self.hostName,
            email: self.emailAccount,
            password: self.emailPassword
        )
    }

    public func sendMail(_ to: String, images: [String]) {

        let waitTask = DispatchSemaphore(value: 0)
        let toUser = Mail.User(email: to)

        // Create an HTML `Attachment`
        let htmlAttachments = images.map({
            Attachment(htmlContent: "<img src=\"\($0)\"/>")
        })

        let mail = Mail(
            from: self.fromEmail,
            to: [toUser],
            subject: "Upcoming Releases From Nike",
            text: "Here are the new shoes coming out",
            attachments: htmlAttachments
        )

        self.client.send(mail) { (error) in
            if let error = error {
                print(error)
            }
            waitTask.signal()
        }

        waitTask.wait()
    }
}

