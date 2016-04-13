require "rails_helper"

RSpec.describe BookFromAirAvailability, type: :model do

  it "should be able to find :short_sell_rq SOAP operation" do
    
    session = SabreSession.new
    session.set_to_non_production
    result = session.establish_session
    
    expect(result[:status]).to eq :success
    
    booking = BookFromAirAvailability.new
    booking.establish_connection(session)
    
    expect(booking.available_operations.include?(:short_sell_rq)).to eq true
  end
    
  it "should execute booking" do
    
    session = SabreSession.new
    session.set_to_non_production
    result = session.establish_session
    
    expect(result[:status]).to eq :success
    
    booking = BookFromAirAvailability.new
    booking.establish_connection(session)
    
    booking.execute_booking
  end
  
end
