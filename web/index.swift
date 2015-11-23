#!/usr/bin/env swift

import Foundation

class View {
    let fileManager = NSFileManager.defaultManager();
    let formTemplate     = "index.html.tmpl"
    let confirmTemplate  = "confirm.html.tmpl"
    let completeTemplate = "complete.html.tmpl"

    func getCurrentPath() -> String {
        return self.fileManager.currentDirectoryPath
    }

    func getFormHtml(params: Dictionary<String, String>) -> String {
        var html = self.getFileContents(self.formTemplate)
        html = self.renderTemplate(html, params: params)


        return html
    }

    func getConfirmHtml(params: Dictionary<String, String>) -> String {
        var html = self.getFileContents(self.confirmTemplate)
        html = self.renderTemplate(html, params: params)

        return html
    }

    func getCompleteHtml(params: Dictionary<String, String>) -> String {
        var html = self.getFileContents(self.completeTemplate)
        html = self.renderTemplate(html, params: params)

        return html
    }

    private func renderTemplate(html: String, params: Dictionary<String, String>) -> String {
        let pattern = "\\{\\{ action \\}\\}"
        let replace = "index.swift"

        var html = html.stringByReplacingOccurrencesOfString(pattern, withString: replace, options: NSStringCompareOptions.RegularExpressionSearch, range: nil)

        for (key, value) in params {
            let pattern = "\\{\\{ " + key + " \\}\\}"
            let replace = self.htmlspecialchars(value)
            html = html.stringByReplacingOccurrencesOfString(pattern, withString: replace, options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        }

        return html;
    }

    private func htmlspecialchars(var html: String) -> String {
        let replaceDef: Dictionary<String, String> = [
            "\"": "&quot;",
            "'": "&#039;",
            "<": "&lt;",
            ">": "&gt;",
        ]

        for (key, value) in replaceDef {
            let pattern = key;
            let replace = value;
            html = html.stringByReplacingOccurrencesOfString(pattern, withString: replace, options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        }

        return html
    }

    private func getFileContents(filename: String) -> String {
        let path = self.getCurrentPath() + "/" + filename

        var contents: String = "";

        do {
            contents = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        } catch let error as NSError {
            print(error);
        }

        return contents;
    }
}

class App {
    var view: View
    let keys = ["email", "title", "message", "next"]
    let env: Dictionary<NSObject, AnyObject> = NSProcessInfo.processInfo().environment

    init(view: View) {
        self.view = view
    }

    func run() {
        let params = self.parseGetVars()
        var html = ""

        let next = params["next"] ?? ""

        switch next {
            case "confirm":
                html = self.view.getConfirmHtml(params)
            case "complete":
                html = self.view.getCompleteHtml(params)
            default:
                html = self.view.getFormHtml(params)
        }

        self.response(html);
    }

    func parseGetVars() -> Dictionary<String, String> {
        let queryString = self.env["QUERY_STRING"] as! String
        var queries:Dictionary<String, String> = ["email": "", "title": "", "message": "", "next": ""]

        if (queryString != "") {
            let pairs = queryString.componentsSeparatedByString("&")
            for pair in pairs {
                let keyValue = pair.componentsSeparatedByString("=")
                let key = keyValue[0]
                var value = keyValue[1]
                value = value.stringByReplacingOccurrencesOfString("\\+", withString: " ", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
                queries[key] = value.stringByRemovingPercentEncoding
            }
        }

        return queries
    }

    func response(html: String) {
        print("Content-Type: text/html")
        print("")
        print(html)
    }
}

let view = View();
let app = App(view: view);
app.run()
