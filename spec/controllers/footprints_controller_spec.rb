require 'spec_helper'

describe FootprintsController do

  describe "GET 'user'" do
    use_vcr_cassette "fetching_checkins_and_carbon", :record => :once

    before(:each) do
      # use a working API token from the yaml
      session["access_token"] = Rails.configuration.foursquare_access_token

      # mock out calls to AMEE abstraction layer
      flexmock(AMEE::DataAbstraction::OngoingCalculation).new_instances do |mock|
        mock.should_receive(:choose).and_return(nil)
        mock.should_receive(:calculate!).and_return(nil)
        mock.should_receive(:[]).with(:co2e).and_return(flexmock(:value => 42))
      end

    end

    it "should fetch user details and checkins from foursquare" do

      get 'user'
      User.first should_not be_blank
      first_journey = User.first.legs.first

      # We should be able to fetch a checkin from the object by calling `end_checkin_id`
      end_checkin = first_journey.end_checkin
      start_checkin = first_journey.start_checkin

      # we should get back an object
      end_checkin.class.should == Checkin
      start_checkin.class.should == Checkin
      end_checkin.incoming_leg.should == first_journey
    end

    it "should forward the user to their checkins page" do

      # start the mocked out sign in process
      get 'user'
      User.count.should eq 1
      response.should redirect_to legs_path
    end

    it "lets people see checkins from last week" do
      get 'user'

      # 

      # add timecop to set the date for the fixtures
      # check if they're displayed
    end

  end

end
