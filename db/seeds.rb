require_all 'lib'

5.times do
    Donor.create(name: Faker::Name.name, industry: Faker::IndustrySegments.sector)
end

5.times do
    Campaign.create(name: Faker::Name.name, party: Faker::TvShows::GameOfThrones.house)
end

5.times do
    Donation.create(amount: Faker::Commerce.price, campaign_id:Campaign.all.sample.id, donor_id:Donor.all.sample.id)
end