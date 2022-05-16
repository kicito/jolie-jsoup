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
package joliex.jsoup;

import java.io.IOException;

import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.UnsupportedMimeTypeException;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.jsoup.select.Selector.SelectorParseException;

import jolie.runtime.FaultException;
import jolie.runtime.JavaService;
import jolie.runtime.Value;
import jolie.runtime.embedding.RequestResponse;

public class JolieJsoup extends JavaService {
    @RequestResponse
    public Value parseHTML(Value request)
            throws FaultException {
        try {
            String content = request.getFirstChild("content").strValue();
            String selector = request.getFirstChild("selector").strValue();

            Document d = Jsoup.parse(content);
            Elements els = d.select(selector);

            Value value = Value.create();
            for (String s : els.eachText()) {
                System.out.println(s);
                value.getNewChild("elementText").add(Value.create(s));
            }
            return value;
        } catch (SelectorParseException e) {
            throw new FaultException("SelectorParseException", e);
        }
    }

    @RequestResponse
    public Value parseURL(Value request)
            throws FaultException {
        try {
            String url = request.getFirstChild("URL").strValue();
            String selector = request.getFirstChild("selector").strValue();

            Document d = Jsoup.connect(url).get();
            Elements els = d.select(selector);

            Value value = Value.create();
            for (String s : els.eachText()) {
                value.getNewChild("elementText").add(Value.create(s));
            }
            return value;
        } catch (SelectorParseException e) {
            throw new FaultException("SelectorParseException", e);
        } catch (java.net.MalformedURLException e) {
            throw new FaultException("MalformedURLException", e);
        } catch (HttpStatusException e) {
            throw new FaultException("HttpStatusException", e);
        } catch (UnsupportedMimeTypeException e) {
            throw new FaultException("UnsupportedMimeTypeException", e);
        } catch (java.net.SocketTimeoutException e) {
            throw new FaultException("SocketTimeoutException", e);
        } catch (IOException e) {
            throw new FaultException("IOException", e);
        }
    }
}
