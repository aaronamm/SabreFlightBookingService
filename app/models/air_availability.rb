class AirAvailability
  
  # == Includes ===============================================================
  include ActiveModel::Model
  
  # == Constants ==============================================================
  OTA_AIR_AVAIL_LLS_RQ_WSDL   = "http://webservices.sabre.com/wsdl/tpfc/OTA_AirAvailLLS2.3.0RQ.wsdl"
  HEADER_OTA_AIR_AVAIL_LLS_RQ = "OTA_AirAvailLLSRQ"

  # == Class Initializer ======================================================
  def initialize
    @savon_client = nil
    @message_body = {}
  end 
  
  # == Instance methods =======================================================  
  def namespaces
    namespaces = {
      "xmlns:env" => "http://schemas.xmlsoap.org/soap/envelope/", 
      "xmlns:ns"  => "http://webservices.sabre.com/sabreXML/2011/10", 
      "xmlns:mes" => "http://www.ebxml.org/namespaces/messageHeader", 
      "xmlns:sec" => "http://schemas.xmlsoap.org/ws/2002/12/secext"
    }
    
    return namespaces
  end
  
  def available_operations
    raise "No established 'savon_client' instance." if @savon_client.nil?
    
    return @savon_client.operations
  end
  
  def establish_connection(session)
    raise "Passed 'session' parameter was nil. Said parameter must not be nil." if session.nil?
    
    @savon_client = Savon.client(
      wsdl:                    OTA_AIR_AVAIL_LLS_RQ_WSDL, 
      namespaces:              namespaces,
      soap_header:             session.build_header(HEADER_OTA_AIR_AVAIL_LLS_RQ, session.binary_security_token),
      log:                     true, 
      log_level:               :debug, 
      pretty_print_xml:        true,
      convert_request_keys_to: :none,
      namespace_identifier:    :ns
    )
    
    @savon_client = session.set_endpoint_environment(@savon_client)

    return @savon_client
  end
  
  def operation_attributes
    attributes = {
      "ReturnHostCommand" => "false",
      "TimeStamp"         => Time.now.strftime("%Y-%m-%dT%H:%M:%SZ"),
      "Version"           => "2.3.0",
      "xmlns"             => "http://webservices.sabre.com/sabreXML/2011/10",
      "xmlns:xs"          => "http://www.w3.org/2001/XMLSchema",
      "xmlns:xsi"         => "http://www.w3.org/2001/XMLSchema-instance",
    }
    
    return attributes
  end
  
  def execute_air_availability(departure_date_time, origin_location, destination_location)
    
    raise "No established 'savon_client' instance." if @savon_client.nil?
    
    begin
      @message_body = {
        "ns:OriginDestinationInformation" => {
          "ns:FlightSegment" => {
            :@DepartureDateTime => departure_date_time,
            "ns:DestinationLocation" => { :@LocationCode => origin_location,      },
            "ns:OriginLocation"      => { :@LocationCode => destination_location, },
          },
        },
      }
      
      call_response = @savon_client.call(:ota_air_avail_rq, soap_action: "ns:OTA_AirAvailRQ", attributes: operation_attributes, message: @message_body)

    rescue Savon::SOAPFault => error
      puts "@DEBUG #{__LINE__}    #{ap error.to_hash[:fault]}"
      
      return { status: :failed,  error: error.to_hash[:fault] }
    else
      origin_destination_options = (call_response.body[:ota_air_avail_rs])[:origin_destination_options]
      
      return { status: :success, data: { origin_destination_options: origin_destination_options } }
    end  
  end
    
end
