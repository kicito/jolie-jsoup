/*
 * Copyright (C) 2021 Narongrit Unwerawattana <narongrit.kie@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
 */
 type ParseHTMLRequest {
    content: string //< HTML content to extract data
    selector: string //< CSS selector to extract data
}

type ParseURLRequest {
    URL: string //< URL to parse content to extract data
    selector: string //< CSS selector to extract data
}

type ParsedHTMLResponse {
    elementText[0,*]:string //< Parsed text result
}

interface JolieJsoupInterface {
RequestResponse:
    /// Parses HTML content from html string
    parseHTML(ParseHTMLRequest)(ParsedHTMLResponse) throws SelectorParseException,
    /// Parses HTML content from URL
    parseURL(ParseURLRequest)(ParsedHTMLResponse) throws 
        SelectorParseException,
        MalformedURLException,
        HttpStatusException,
        UnsupportedMimeTypeException,
        SocketTimeoutException,
        IOExceptionSelectorParseException
}

service JolieJsoup {
	inputPort Input {
		location: "local"
		interfaces: JolieJsoupInterface
	}

	foreign java {
		class: "joliex.jsoup.JolieJsoup"
	}
}