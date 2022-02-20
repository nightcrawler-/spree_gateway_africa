# frozen_string_literal: true

class MobileNetworkService
  attr_reader :phone_number

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def call
    if phone_number.match(MTN_REGEX)
      'MTN'
    elsif phone_number.match(AIRTEL_REGEX)
      'Airtel'
    elsif phone_number.match(ZAMTEL_REGEX)
      'Zamtel'
    else
      UNKNOWN
    end
  end

  MTN_REGEX = /(096|076)([0-9]){6}/i.freeze
  AIRTEL_REGEX = /(097|077)([0-9]){6}/i.freeze
  ZAMTEL_REGEX = /095([0-9]){6}/i.freeze
end
