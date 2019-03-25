class Donor < ActiveRecord::Base
    has_many :donations
    has_many :campaigns, through: :donations
end