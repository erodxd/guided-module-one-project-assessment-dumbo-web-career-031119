class Campaign < ActiveRecord::Base
    has_many :donations
    has_many :donors, through: :donations


    # def self.find_donation_total
    #     candidate = Campaign.all.select do |cand|
    #         cand.first
    #     end
    # end

    def sum_total
        self.donations.map do |donation|
            donation.amount
        end.sum
    end 
end
