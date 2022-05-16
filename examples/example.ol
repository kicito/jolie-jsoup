from @jolie-jsoup import JolieJsoup
from console import Console
from string-utils import StringUtils

service main {
    embed JolieJsoup as JolieJsoup
    embed Console as Console
    embed StringUtils as StringUtils

    main {
        parseHTML@JolieJsoup({content="<html><head><title>First parse</title></head><body><p>Parsed HTML into a doc.</p></body></html>" selector="p"})(res)
        valueToPrettyString@StringUtils(res)(resPretty)
        println@Console(resPretty)()
        // returns
        // root
        // ╰─── elementText:string = "Parsed HTML into a doc."

        parseURL@JolieJsoup({URL="https://www.jolie-lang.org" selector="h2"})(res)
        valueToPrettyString@StringUtils(res)(resPretty)
        println@Console(resPretty)()

        // returns
        // root
        // ├─── elementText[0]:string = "The service-oriented programming language"
        // ├─── elementText[1]:string = "Thinking in services"
        // ├─── elementText[2]:string = "Tailored for microservices and APIs"
        // ├─── elementText[3]:string = "Built for the networked age"
        // ├─── elementText[4]:string = "Protocol agnostic"
        // ├─── elementText[5]:string = "Structured workflows"
        // ├─── elementText[6]:string = "Dynamic error handling for parallel code"
        // ├─── elementText[7]:string = "Everything you build can be used to build again"
        // ├─── elementText[8]:string = "Revolutionise the way you develop web applications"
        // ├─── elementText[9]:string = "Solid foundations"
        // ├─── elementText[10]:string = "Join us!"
        // ╰─── elementText[11]:string = "Stakeholders and Supporters"

    }
}