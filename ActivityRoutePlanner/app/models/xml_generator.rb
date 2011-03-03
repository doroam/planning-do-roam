require "rexml/document"

class XmlGenerator < ActionController::Base

  #creates an xml document for the entered segments (paths)
  def self.generate_route(segments)
    doc   = REXML::Document.new
    #creates head of the document
    body  = generate_head(doc)
    #sets the segments to the document
    segments.each.with_index do |segment,index|
      set_segment(body,segment,index)
    end
    #writes the document to a string
    doc.write(out_string = "",2)
    return out_string
  end

  #sets a segment to the document
  def self.set_segment(folder,segment,index)
    #placemark with id
    place = folder.add_element("Placemark")
    place.add_attribute("id", index.to_s)
    #styles for the lines
    style = "#style2"
    if index%2 ==0
      style = "#style1"
    end
    #set style
    place.add_element("styleUrl").add_text(style)
    #add segment
    place.add(parse(segment))
  end

  #generates a style with given name and color
  def self.generate_style(document,name,color)
    style = document.add_element("Style")
    style.add_attribute("id", name)
    lineStyle = style.add_element("LineStyle")
    lineStyle.add_element("color").add_text(color)
    lineStyle.add_element("width").add_text("7")
  end

  #generates the head of the document
  def self.generate_head(doc)
    # root node
    kml       = doc.add_element("kml")
    kml.add_attribute("xmlns", "http://earth.google.com/kml/2.1")
    #description attributes
    document  = kml.add_element("document")
    name      = document.add_element("name")
    name.add_text("Activity Route")
    desc      = document.add_element("description")
    desc.add_text("Route for activities")
    #create styles
    generate_style(document,"style1","7fff0000")
    generate_style(document,"style2","7ff000ff")#7f0000ff
    return document
  end  
  #parses a string to a kml object
  def self.parse(data)
    doc = REXML::Document.new(data)
    return doc
  end

end
