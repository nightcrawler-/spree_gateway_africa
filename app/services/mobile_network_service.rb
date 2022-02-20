class MobileNetworkService
    attr_reader :phone_number

    def initialize(phone_number)
        @phone_number = phone_number
    end

    def call
        if phone_number.match(MTN_REGEX)
            return 'MTN'
        elsif phone_number.match(AIRTEL_REGEX)
            return 'Airtel'
        elsif phone_number.match(ZAMTEL_REGEX)
            return 'Zamtel'
        else
            return UNKNOWN
        end
    end

    MTN_REGEX = /(096|076)([0-9]){6}/i    
    AIRTEL_REGEX = /(097|077)([0-9]){6}/i 
    ZAMTEL_REGEX = /095([0-9]){6}/i
    
end