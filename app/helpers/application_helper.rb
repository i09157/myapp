#encoding: utf-8

module ApplicationHelper
  def simple_time(time)
    time.strftime("%Y/%m/%d %H:%M:%S")
  end

end
