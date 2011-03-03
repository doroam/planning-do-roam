require "rexml/document"

class XmlGenerator < ActionController::Base

  def self.generate_route(segments)
    doc   = REXML::Document.new
    body  = generate_head(doc)
    segments.each.with_index do |segment,index|
      set_segment(body,segment,index)
    end

    doc.write(out_string = "",2)
    return out_string
  end
  
  def self.set_segment(folder,segment,index)
    place = folder.add_element("Placemark")
    place.add_attribute("id", index.to_s)
    style = "#style2"
    if index%2 ==0
      style = "#style1"
    end
    place.add_element("styleUrl").add_text(style)
    place.add(parse(segment))
  end

  def hijack_response( out_data )
    send_data( out_data, :type => "text/xml",
    :filename => "sample.xml" )
  end
  def self.generate_style(document,name,color)
    style = document.add_element("Style")
    style.add_attribute("id", name)
    lineStyle = style.add_element("LineStyle")
    lineStyle.add_element("color").add_text(color)
    lineStyle.add_element("width").add_text("7")
  end
  def self.generate_head(doc)
    kml = doc.add_element("kml")
    kml.add_attribute("xmlns", "http://earth.google.com/kml/2.1")
    document = kml.add_element("document")
    name = document.add_element("name")
    name.add_text("testName")
    desc = document.add_element("description")
    desc.add_text("testText")
    generate_style(document,"style1","7fff0000")
    generate_style(document,"style2","7f0000ff")
    return document
  end

  

  def self.parse(data)
    doc = REXML::Document.new(data)
    return doc
  end

end
