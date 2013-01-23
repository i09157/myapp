#encoding: utf-8
class Article < ActiveRecord::Base
  attr_accessible :content, :title, :tag_list
  acts_as_taggable
  has_many :comments, :dependent => :destroy
  validates :title, :presence => true
  validates :tag_list, :presence => true
  validates :content, :presence => true,
                      :length => { :minimum => 5 }
  belongs_to :user
  scope :title_or_content_matches, lambda{|q|
    where 'title like :q or content like :q', :q => "%#{q}%"
  }
  def trigger_view_event
    FNORD_METRIC.event(attributes.merge(_type: :view_article))    
  end
  def trigger_update_event
    FNORD_METRIC.event(attributes.merge(_type: :update_article))    
  end
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe
    # add nokogiri gem to Gemfile
    form_fields = [
    'textarea',
    'input',
    'select'
    ]
 
    elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')
  
    elements.each do |e|
    if e.node_name.eql? 'label'
      html = %(<div class="control-group error">#{e}</div>).html_safe
    elsif form_fields.include? e.node_name
      if instance.error_message.kind_of?(Array)
        html = %(<div class="control-group error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message.join(',')}</span></div>).html_safe
      else
        html = %(<div class="control-group error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message}</span></div>).html_safe
      end
    end
    end
    html
  end

end