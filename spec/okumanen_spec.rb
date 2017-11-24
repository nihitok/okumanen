require 'spec_helper'

describe Okumanen do
  it 'versionが定義されている' do
    expect(Okumanen::VERSION).not_to be nil
  end

  it '万円表記かどうか判別できる' do
    expect(Okumanen.target?("1万円")).to be true
    expect(Okumanen.target?("12万円")).to be true
    expect(Okumanen.target?("123万円")).to be true
    expect(Okumanen.target?("1234万円")).to be true
    expect(Okumanen.target?("1億1234万円")).to be true
    expect(Okumanen.target?("12億1234万円")).to be true
    expect(Okumanen.target?("123億1234万円")).to be true
    expect(Okumanen.target?("1234億1234万円")).to be true

    expect(Okumanen.target?("1234")).to be false
    expect(Okumanen.target?("12345678")).to be false
  end

  it '万円表記から数値表記に変更できる' do
    expect(Okumanen.to_i("1円")).to         be 1
    expect(Okumanen.to_i("10円")).to        be 10
    expect(Okumanen.to_i("100円")).to       be 100
    expect(Okumanen.to_i("1,000円")).to     be 1000
    expect(Okumanen.to_i("11,000円")).to    be 11000
    expect(Okumanen.to_i("121,000円")).to   be 121000
    expect(Okumanen.to_i("1231,000円")).to  be 1231000
    expect(Okumanen.to_i("12341,000円")).to be 12341000

    expect(Okumanen.to_i("1万1,000円")).to     be 11000
    expect(Okumanen.to_i("12万1,000円")).to    be 121000
    expect(Okumanen.to_i("123万1,000円")).to   be 1231000
    expect(Okumanen.to_i("1,234万1,000円")).to be 12341000
    expect(Okumanen.to_i("1,234万円")).to      be 12340000

    expect(Okumanen.to_i("1億円")).to            be 100000000
    expect(Okumanen.to_i("1億1,234万円")).to     be 112340000
    expect(Okumanen.to_i("12億1,234万円")).to    be 1212340000
    expect(Okumanen.to_i("123億1,234万円")).to   be 12312340000
    expect(Okumanen.to_i("1,234億1,234万円")).to be 123412340000
    expect(Okumanen.to_i("1,234億円")).to        be 123400000000

    expect(Okumanen.to_i("1,234億10円")).to          be 123400000010
    expect(Okumanen.to_i("1,234億100円")).to         be 123400000100
    expect(Okumanen.to_i("1,234億1,000円")).to       be 123400001000
    expect(Okumanen.to_i("1,234億1万1,000円")).to    be 123400011000
    expect(Okumanen.to_i("1,234億12万1,000円")).to   be 123400121000
    expect(Okumanen.to_i("1,234億123万1,000円")).to  be 123401231000
    expect(Okumanen.to_i("1,234億1234万1,000円")).to be 123412341000

  end

  it '万円表記から数値表記に変更できる(小数点)' do
    expect(Okumanen.to_i("1234.1万円")).to be 12341000
    expect(Okumanen.to_i("1234.12万円")).to be 12341200
    expect(Okumanen.to_i("1234.123万円")).to be 12341230
    expect(Okumanen.to_i("1234.1234万円")).to be 12341234
    expect(Okumanen.to_i("1234.1億円")).to be 123410000000

    expect(Okumanen.to_i("1.2億円")).to            be 120000000
    expect(Okumanen.to_i("1.23億円")).to            be 123000000
    expect(Okumanen.to_i("1.234億円")).to            be 123400000
    expect(Okumanen.to_i("1.2345億円")).to            be 123450000
    expect(Okumanen.to_i("1.0345億円")).to            be 103450000
    expect(Okumanen.to_i("1.0045億円")).to            be 100450000
    expect(Okumanen.to_i("1.0005億円")).to            be 100050000
    expect(Okumanen.to_i("1.0000億円")).to            be 100000000
  end

end
