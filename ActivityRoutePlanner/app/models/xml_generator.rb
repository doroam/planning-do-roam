require "rexml/document"

class XmlGenerator < ActionController::Base

  def self.generate_route(segments)
    doc = REXML::Document.new
    body = generate_head(doc)
    segments.each.with_index do |segment,index|
      set_segment(body,segment,index)
    end

    doc.write(out_string = "",2)
    return out_string
  end
  
  def self.set_segment(folder,segment,index)
    place = folder.add_element("Placemark")
    place.add_attribute("id", index.to_s)
    place.add_element("styleUrl").add_text("#lineStyle")
    place.add(parse(segment))
  end

  def hijack_response( out_data )
    send_data( out_data, :type => "text/xml",
    :filename => "sample.xml" )
  end
  def self.generate_head(doc)
    kml = doc.add_element("kml")
    kml.add_attribute("xmlns", "http://earth.google.com/kml/2.1")
    document = kml.add_element("document")
    name = document.add_element("name")
    name.add_text("testName")
    desc = document.add_element("description")
    desc.add_text("testText")
    style = document.add_element("Style")
    style.add_attribute("id", "lineStyle")
    lineStyle = document.add_element("LineStyle")
    lineStyle.add_element("color").add_text("7fff00ff")
    lineStyle.add_element("width").add_text("9")
    document.add_element("PolyStyle").add_element("color").add_text("7fff00ff")
    return document
  end
  def self.parse(data)
    doc = REXML::Document.new(data)
    return doc
  end

end
