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
Feature: A page to display and add tasks, It should be easily possible to view the days tasks, edit the important details (awesome/not awesome, start/end time)

Scenario: Viewing a list of todays events 
  Given I am on the events page
  Then I should see "Todays Events" within "h1"

Scenario: creating a new event 
  Given I am on the events page
    And I fill in "event_description" with "test 1" within "form#new_event" 
    And I press "Save changes" within "form#new_event"
  Then I should see "test 1" within "td" 
    And I should see "Event was successfully created" within "p"   

Scenario: failing to create an event
  Given I am on the events page
    And I press "Save changes" within "form#new_event"
  Then I should see "Description can't be blank" within "li"

