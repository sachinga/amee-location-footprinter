# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  # TODO replace these with autogenerated values
  factory :checkin do
      lat "51.5373602354157"
      lon "-0.0614011287689209"
      timestamp DateTime.now
      foursquare_id "4dde05bc1f6e0369473a10fa"
      timezone "Europe/London"
      venue_name "Off Broadway"
    end
end