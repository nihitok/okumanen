require "okumanen/version"



module Okumanen
  def self.target?(str)
    !str.match(/[億万円]+/).nil?
  end

  def self.to_i(str)
    str   = str.gsub(/,/, "")
    value = ""
    next_value = ""
    [/([\d\.]+)億(円)?/, /([\d\.]+)万(円)?/, /(\d+)円/].each do|r|
      m = str.match(r)
      if m.nil?
        while next_value.size < 4
          next_value += "0"
        end
        value += sprintf("%0.4d", next_value)
        next_value = ""
      else
        if m[1].include?(".") 
          next_value = m[1].split(".").last
        end
        value += sprintf("%0.4d", m[1].to_i)
      end
    end
    value.to_i
  end
end
