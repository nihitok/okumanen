require "okumanen/version"



module Okumanen
  def self.target?(str)
    !str.match(/[億万円]+/).nil?
  end

  def self.to_i(str)
    str   = str.gsub(/,/, "")
    value = ""
    [/(\d+)億(円)?/, /(\d+)万(円)?/, /(\d+)円/].each do|r|
      m = str.match(r)
      if m.nil?
        value += sprintf("%0.4d", 0)
      else
        value += sprintf("%0.4d", m[1].to_i)
      end
    end
    value.to_i
  end
end
