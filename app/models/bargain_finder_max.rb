class BargainFinderMax
  
  # == Includes ===============================================================
  include ActiveModel::Model
  
  # == Constants ==============================================================
  BARGAIN_FINDER_MAX_RQ_WSDL          = "http://files.developer.sabre.com/wsdl/sabreXML1.0.00/shopping/BargainFinderMaxRQ_v1-9-2.wsdl"
  HEADER_ACTION_BARGAIN_FINDER_MAX_RQ = "BargainFinderMaxRQ"
  TRIP_TYPE_ONE_WAY                   = "OneWay"
  
  # == Instance methods =======================================================
  def operation_attributes
    attributes = {
      "Target"          => "Production",
      "Version"         => "1.9.2",
      "ResponseType"    => "OTA",
      "ResponseVersion" => "1.9.2",
    }
    
    return attributes
  end  
  
  def build_pos_section
    section = {
      "ns:Source" => {
        :@PseudoCityCode => "6A3H",
        
        "ns:RequestorID" => {
          :@Type => "1",
          :@ID   => "1",

          "ns:CompanyName" => {
            :@Code => "TN",  
          },
        },
      },
    }
    
    return section
  end
  
  def build_origin_destination_information_section(origins_and_destinations)
    raise "'origins_and_destinations' parameters should not be empty." if origins_and_destinations.empty?
    
    origin_destination_list = []
    
    count = 0
    origins_and_destinations.each do |entry|
      count += 1
      origin_destination_list << {
        :@RPH => count,
        "ns:DepartureDateTime"   => { :content!      => entry[:departure_date_time ], },
        "ns:OriginLocation"      => { :@LocationCode => entry[:origin_location     ], },
        "ns:DestinationLocation" => { :@LocationCode => entry[:destination_location], },
      }
    end
    
    return origin_destination_list
  end  
  
  def bfm_one_way(session, origins_and_destinations)
    
    namespaces = {
      "xmlns:env" => "http://schemas.xmlsoap.org/soap/envelope/", 
      "xmlns:ns"  => "http://www.opentravel.org/OTA/2003/05",
      "xmlns:mes" => "http://www.ebxml.org/namespaces/messageHeader", 
      "xmlns:sec" => "http://schemas.xmlsoap.org/ws/2002/12/secext"
    }
    
    message_body = {
      "ns:POS"                          => build_pos_section,
      "ns:OriginDestinationInformation" => build_origin_destination_information_section(origins_and_destinations), 
      "ns:TravelPreferences" => {
        "ns:TPA_Extensions" => {
          "ns:TripType" => {
            :@Value => TRIP_TYPE_ONE_WAY,
          },
        },
      },
      "ns:TravelerInfoSummary" => {
        "ns:SeatsRequested"    => 3,
        "ns:AirTravelerAvail"  => {
          "ns:PassengerTypeQuantity" => [
            {
              :@Code     => "ADT",
              :@Quantity => "1",  
            },
            {
              :@Code     => "CNN",
              :@Quantity => "1",  
            },
            {
              :@Code     => "INF",
              :@Quantity => "1",  
            },
          ],
        },
      },
      "ns:TPA_Extensions" => {
        "ns:IntelliSellTransaction" => {
          "ns:RequestType" => {
            :@Name => "50ITINS",
          },
        },
      },
    }
    
    savon_client = Savon.client(
      wsdl:                    BARGAIN_FINDER_MAX_RQ_WSDL, 
      namespaces:              namespaces,
      soap_header:             session.build_header(HEADER_ACTION_BARGAIN_FINDER_MAX_RQ, session.binary_security_token),
      log:                     true, 
      log_level:               :debug, 
      pretty_print_xml:        true,
      convert_request_keys_to: :none,
      namespace_identifier:    :ns
    )
    
    response = savon_client.call(:bargain_finder_max_rq,  soap_action: "ns:OTA_AirLowFareSearchRQ", attributes: operation_attributes, message: message_body)
    
    return savon_client
  end
  
end
