class CreateTemplatesD01UntilD15 < ActiveRecord::Migration
  
  def self.up
    unless Template.find_by_internal_name "d01"
      tpl = Template.create(:name => "d01", :internal_name => "d01", :page_text_1 => "oben rechts")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "rechte Seite", :internal_name => "rightside", :position => 1)
      tpl.save
    end
    
    #unless Template.find_by_internal_name "d03"
    #  tpl = Template.create(:name => "d03", :internal_name => "d03", :page_text_1 => "oben links", :page_text_2 => "oben rechts", :account_type => "bug")
    #  tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
    #  tpl.template_areas << TemplateArea.create(:name => "rechte Seite", :internal_name => "rightside", :position => 1)
    #  tpl.template_areas << TemplateArea.create(:name => "rechts alleine 1", :internal_name => "rightsingle1", :position => 2, :multiple_boxes_allowed => false)
    #  tpl.template_areas << TemplateArea.create(:name => "rechts alleine 2", :internal_name => "rightsingle2", :position => 3, :multiple_boxes_allowed => false)
    #  tpl.save
    #end
    
    unless Template.find_by_internal_name "d05"
      tpl = Template.create(:name => "d05", :internal_name => "d05", :page_text_1 => "oben links", :page_text_2 => "linke Leiste", :page_text_3 => "1. rechte Leiste", :page_text_4 => "2. rechte Leiste")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Seite", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Seite", :internal_name => "rightside2", :position => 2)
      tpl.save
    end
    
    unless Template.find_by_internal_name "d07"
      tpl = Template.create(:name => "d07", :internal_name => "d07", :page_text_1 => "oben links", :page_text_2 => "Header mitte", :page_text_3 => "kleiner Titel")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Seite", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Seite", :internal_name => "rightside2", :position => 2)
      tpl.save
    end
    
    unless Template.find_by_internal_name "d09"
      tpl = Template.create(:name => "d09", :internal_name => "d09")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "rechte Seite", :internal_name => "rightside", :position => 1)
      tpl.save
    end
    
    unless Template.find_by_internal_name "d12"
      tpl = Template.create(:name => "d12", :internal_name => "d12", :page_text_1  => "oben mitte", :page_text_2 => "über dem Inhalt")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Seite", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Seite", :internal_name => "rightside2", :position => 2)
      tpl.save
    end
    
    unless Template.find_by_internal_name "d13"
      tpl = Template.create(:name => "d13", :internal_name => "d13", :page_text_1  => "oben links", :page_text_2 => "oben rechts", :page_text_2 => "über 2. rechte Leiste")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Seite", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Seite", :internal_name => "rightside2", :position => 2)
      tpl.save
    end
    
    unless Template.find_by_internal_name "d15"
      tpl = Template.create(:name => "d15", :internal_name => "d15", :account_type => "beta")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "rechte Seite", :internal_name => "rightside", :position => 1)
      tpl.save
    end
  end

  def self.down
  end
end
