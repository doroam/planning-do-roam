module SiteHelper
  
  def display_class_menu(c,selected_classes)
    if !c.interesting
      return ""
    end
    checkbox = check_box_tag("class[" + c.id.to_s + "]","1",selected_classes.include?(c.id.to_s))
    t_name = t("ontology.#{c.name}")
    out = "<li><a> <label for=\"class_#{c.id.to_s}\"> #{checkbox} #{t_name} </label>"
    if !c.subclasses.empty? and c.subclasses.map{|x| x.interesting}.any? then
      out += "&nbsp;"
      out += image_tag("right-arrow.png")
      out += "</a><ul>"
      c.subclasses.each do |sub|
        out += display_class_menu(sub,selected_classes)
      end
      out += "</ul>"
    end
    out += "</li>"
    return out
  end
  
end
