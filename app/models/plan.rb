# Copyright (c) 2010 - James Southern
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
class Plan < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name=>"Plan", :foreign_key=>'parent_id'
  has_many   :children, :class_name=>"Plan", :foreign_key=>'parent_id'
  has_many   :events

  validates_presence_of :description

  #whitlist for mass asigns excluded: :user_id, parent_id
  attr_accessible :description,  :note, :deadline

  RECURS = {:none=>0, :daily => 1, :weekly => 2, :monthly => 3}
  REV_RECURS = ['none', 'daily', 'weekly', 'monthly' ]

  def recurs 
    val = self.read_attribute(:recurs)
    val = 0 if val == nil
    return Plan::REV_RECURS[val]
  end

  def completed?
    if self.read_attribute(:recurs) == Plan::RECURS[:none] or
       self.read_attribute(:recurs) == nil 
      events = self.events
    elsif self.read_attribute(:recurs) == Plan::RECURS[:daily] 
      start = Time.now.to_date.to_time
      events = self.events.find(:all, :conditions=>['completed_at > ?', start])
    elsif self.read_attribute(:recurs) == Plan::RECURS[:weekly] 
      start = (Time.now - Time.now.wday.days).to_date.to_time
      events = self.events.find(:all, :conditions=>['completed_at > ?', start])
    elsif self.read_attribute(:recurs) == Plan::RECURS[:monthly] 
      start = (Time.now - Time.now.mday.days).to_date.to_time
      events = self.events.find(:all, :conditions=>['completed_at > ?', start])
    end

    events.each do |event| 
      return true if event.completed_at != nil
    end if events != nil 
    return false
  end

end
