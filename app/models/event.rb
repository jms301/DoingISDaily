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
class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  validates_presence_of :description, :start_time

  #whitlist for mass asigns excluded: :user_id
  attr_accessible :description, :start_time, :end_time, :awesome, :useful
 
  def length
    self.end_time != nil ?  self.end_time - self.start_time : 0 
  end
 
  def self.find_todays_events user
    events = user.events.find(:all,
                         :conditions =>['Date(start_time) = Date(?)', Time.now],
                         :order=>'start_time DESC, end_time DESC')

    if !events[0].blank? and events[0].end_time.blank? 
      return events.shift, events
    else
      return nil, events
    end
  end
end
