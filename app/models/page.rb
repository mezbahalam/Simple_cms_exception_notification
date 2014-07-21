class Page < ActiveRecord::Base

  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  #if you want to give your join table a different name and not follow the rails convention then you can specify here
  # has_and_belongs_to_many :admin_users, :join_table => "admin_users_pages"

  acts_as_list :scope => :subject


  before_validation :add_default_permalink
  after_save :touch_subject
  after_destroy :delete_related_sections


  validates :name, :presence => true,
                   :length => {:maximum => 255}
  validates :permalink, :presence => true,
                        :length => {:within => 3..255},
  # use presence_of with length_of to disallow spaces
                        :uniqueness => true
  # for unique values by subject use ":scope => :subject_id"


  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("pages.position ASC") }
  scope :newest_first, lambda { order("pages.created_at DESC")}

  private

  def add_default_permalink
    if permalink.blank?
      self.permalink = "#{id}-#{name.parameterize}"
    end
  end

  def touch_subject
    # touch is similar to:
    # subject.update_attribute(:updated_at, Time.now)
    subject.touch
  end

  def delete_related_sections
    self.sections.each do |section|
      # Or perhaps instead of destroy, you would
      # move them to a another page.
      # section.destroy
    end
  end


end
