class PassengerDetail
  
  # == Includes ===============================================================
  include ActiveModel::Model
  
  # == Constants ==============================================================
  PASSENGER_DETAILS_RQ_WSDL = "http://files.developer.sabre.com/wsdl/sabreXML1.0.00/ServicesPlatform/PassengerDetails3.2.0RQ.wsdl"
  PASSENGER_DETAILS_RQ      = "PassengerDetailsRQ"
  
  # == Class Methods ==========================================================
  # Build the Document section. Document section is under the AdvancePassenger section.
  # 
  # @param [Hash] args The args hash.
  # @option args [String] :@ExpirationDate "ExpirationDate" is used to specify the document expiration date. ExpirationDate" follows this format: YYYY-MM-DD.
  # @option args [String] :@Number "Number" is used to specify the document number.
  # @option args [String] :@Type "Type" is used to specify the document type. Type" is used to specify the document type. Acceptable values include: "A" - Alien resident card, "C" - Permanent resident card, "F" - Facilitation document, "I" - National ID card, "IN" - Nexus Card.  "M" - Military, "N" - Naturalization certificate, "P" - Passport, "T" - Refugee travel document and re-entry permit, US Travel document, "V" - Border crossing card.
  # @option args [String] :IssueCountry The issuing country.
  # @option args [String] :NationalityCountry The person's nationality country.
  # @return args [Hash] Return a hash representing the Document section.
  def self.build_advance_passenger_document_section(args)
    defaults = {}
    args.merge!(defaults)
    
    document_section = Hash.new
    
    unless args[:@ExpirationDate].nil?
      document_section[:@ExpirationDate] = args[:@ExpirationDate]         
    end  

    unless args[:@Number].nil?
      document_section[:@Number] = args[:@Number]         
    end    
    
    unless args[:@Type].nil?
      document_section[:@Type] = args[:@Type]         
    end   
    
    unless args[:IssueCountry].nil?
      document_section[:IssueCountry] = args[:IssueCountry]         
    end  
    
    unless args[:NationalityCountry].nil?
      document_section[:NationalityCountry] = args[:NationalityCountry]         
    end      
    
    return document_section
  end

  # Build the Visa section. Visa section is under the AdvancePassenger.Document section.
  # 
  # @param [Hash] args The args hash.
  # @option args [String] :issue_date The visa issue date.
  # @option args [String] :applicable_country The applicable country.
  # @option args [String] :place_of_birth The place of birth.
  # @option args [String] :place_of_issue The place of issue.
  # @return args [Hash] Return a hash representing the Visa section.
  def self.build_advance_passenger_document_visa_section(args)
    defaults = {}
    args.merge!(defaults)
    
    visa_section = Hash.new
    
    unless args[:issue_date].nil?
      visa_section[:@IssueDate] = args[:issue_date]         
    end  
      
    unless args[:applicable_country].nil?
      visa_section[:ApplicableCountry] = args[:applicable_country] 
    end  
    
    unless args[:place_of_birth].nil?
      visa_section[:PlaceOfBirth] = args[:place_of_birth]     
    end
      
    unless args[:place_of_issue].nil?
      visa_section[:PlaceOfIssue] = args[:place_of_issue]    
    end
      
    return visa_section
  end
  
  # Build the PersonName section. PersonName section is under the AdvancePassenger section.
  # 
  # @param [Hash] args The args hash.
  # @option args [String] :@DateOfBirth "DateOfBirth" follows this format: YYYY-MM-DD.  
  # @option args [String] :@DocumentHolder "DocumentHolder" is used to identify the primary passport holder when the passport document is issued for multiple passengers.
  # @option args [String] :@Gender "Gender" can be "M" or "F" value.
  # @option args [String] :@NameNumber Assigned "NameNumber". 
  # @option args [String] :GivenName Given first name.
  # @option args [String] :MiddleName Given middle name.
  # @option args [String] :Surname Given last name.
  # @return args [Hash] Return a hash representing the PersonName section.
  def self.build_advance_passenger_person_name_section(args)
    defaults = {}
    args.merge!(defaults)
    
    person_name_section = Hash.new
    
    unless args[:@DateOfBirth].nil?
      person_name_section[:@DateOfBirth] = args[:@DateOfBirth]         
    end  

    unless args[:@DocumentHolder].nil?
      person_name_section[:@DocumentHolder] = args[:@DocumentHolder]         
    end    
    
    unless args[:@Gender].nil?
      person_name_section[:@Gender] = args[:@Gender]         
    end   
    
    unless args[:@NameNumber].nil?
      person_name_section[:@NameNumber] = args[:@NameNumber].upcase         
    end  
    
    unless args[:GivenName].nil?
      person_name_section[:GivenName] = args[:GivenName].upcase         
    end   
    
    unless args[:MiddleName].nil?
      person_name_section[:MiddleName] = args[:MiddleName].upcase         
    end   
    
    unless args[:Surname].nil?
      person_name_section[:Surname] = args[:Surname]         
    end      
    
    return person_name_section
  end 
  
  # Build the ContactNumber section. ContactNumber section is under the ContactInfo section.
  # 
  # @param [Hash] args The args hash.
  # @option args [String] :@NameNumber "NameNumber" is used to specify a passenger name number.  
  # @option args [String] :@Phone "Phone" is used to add customer telephone numbers into the record if applicable.  
  # @option args [String] :@PhoneUseType "PhoneUseType" is used to specify if the number is agency, "A," home, "H," business, "B," or fax, "F".  
  # @return args [Hash] Return a hash representing the ContactNumber section.
  def self.build_contact_info_contact_number_section(args)
    defaults = {}
    args.merge!(defaults)
    
    contact_number_section = Hash.new
    
    unless args[:@NameNumber].nil?
      contact_number_section[:@NameNumber] = args[:@NameNumber]         
    end  

    unless args[:@Phone].nil?
      contact_number_section[:@Phone] = args[:@Phone]         
    end  
    
    unless args[:@PhoneUseType].nil?
      contact_number_section[:@PhoneUseType] = args[:@PhoneUseType]         
    end  
    
    return contact_number_section
  end 
  
  # Build the PersonName section. PersonName section is under the ContactInfo section.
  # 
  # @param [Hash] args The args hash.
  # @option args [String] :@Infant "Infant" is used to specify that the particular passenger is an infant.  
  # @option args [String] :@NameNumber "NameNumber" is used to specify a passenger name number, and is only applicable when used in conjunction with @PassengerType.  
  # @option args [String] :@NameReference "NameReference" is used to specify miscellaneous name reference-related information if applicable.
  # @option args [String] :@PassengerType "PassengerType" is used to add a passenger type code into the record.
  # @option args [String] :GivenName Given first name.
  # @option args [String] :Surname Given last name.
  # @return args [Hash] Return a hash representing the PersonName section.
  def self.build_contact_info_person_name_section(args)
    defaults = {}
    args.merge!(defaults)
    
    person_name_section = Hash.new
    
    unless args[:@Infant].nil?
      person_name_section[:@Infant] = args[:@Infant]         
    end  
    
    unless args[:@NameNumber].nil?
      person_name_section[:@NameNumber] = args[:@NameNumber]         
    end  
    
    unless args[:@NameReference].nil?
      person_name_section[:@NameReference] = args[:@NameReference]         
    end  
    
    unless args[:@PassengerType].nil?
      person_name_section[:@PassengerType] = args[:@PassengerType]         
    end  
    
    unless args[:GivenName].nil?
      person_name_section[:GivenName] = args[:GivenName]         
    end  
    
    unless args[:Surname].nil?
      person_name_section[:Surname] = args[:Surname]         
    end  

    return person_name_section
  end

  # == Instance methods =======================================================
  def initialize
    @savon_client = nil
    @message_body = {}
  end 
  
  def namespaces
    namespaces = {
      "xmlns:env" => "http://schemas.xmlsoap.org/soap/envelope/", 
      "xmlns:v"   => "http://services.sabre.com/sp/pd/v3_2", 
      "xmlns:mes" => "http://www.ebxml.org/namespaces/messageHeader", 
      "xmlns:sec" => "http://schemas.xmlsoap.org/ws/2002/12/secext",
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
      wsdl:                    PASSENGER_DETAILS_RQ_WSDL, 
      namespaces:              namespaces,
      soap_header:             session.build_header(PASSENGER_DETAILS_RQ, session.binary_security_token),
      log:                     true, 
      log_level:               :debug, 
      pretty_print_xml:        true,
      convert_request_keys_to: :none,
      namespace_identifier:    :v,
    )
    
    @savon_client = session.set_endpoint_environment(@savon_client)

    return @savon_client
  end
  
  def operation_attributes
    attributes = {
      "xmlns"         => "http://services.sabre.com/sp/pd/v3_2",
      "version"       => "3.2.0",
      "IgnoreOnError" => "false",
      "HaltOnError"   => "false",
    }
    
    return attributes
  end
  
  # Send a PassengerDetailsRQ SOAP request to Sabre
  # 
  # @param [Hash] args The args hash.
  # @option args [String] :document_advance_passenger "document_advance_passenger" is a hash for the Document section that is under the AdvancePassenger section.  
  # @option args [String] :person_name_advance_passenger "person_name_advance_passenger" is a hash for the PersonName section that is under the AdvancePassenger section. 
  # @option args [String] :contact_number_contact_info "contact_number_contact_info" is a hash for the ContactNumber section that is under the ContactInfo section. 
  # @option args [String] :person_name_contact_info "person_name_contact_info" is a hash for the PersonName section that is under the ContactInfo section. 
  # @return args [Hash] Return a hash representing the content of the TravelItineraryReadRS returned by Sabre.
  def execute_request(args)
    
    # Naming convention for keys for the passed hash is [section]_[parent senction], e.g. document_advance_passenger. 
    # Document is the target section. AdvancePassenger is the parent section.
    
    defaults = {}
    args.merge!(defaults)
    
    begin
      # @TODO add error checking
      document_advance_passenger    = args[:document_advance_passenger   ]   
      person_name_advance_passenger = args[:person_name_advance_passenger]  
      contact_number_contact_info   = args[:contact_number_contact_info  ]  
      person_name_contact_info      = args[:person_name_contact_info     ]  
    
      # @TODO add a mechanism for adding the above passed hash parameter as optional
      @message_body = {
        "v:PostProcessing" => {
          :@IgnoreAfter          => "true",
          :@RedisplayReservation => "true",
          
          "v:EndTransactionRQ" => {
            "v:EndTransaction" => {
              :@Ind => "true",
            },
            "v:Source" => {
              :@ReceivedFrom => "6DEFERO",
            },
          },
        },
  
        "v:PreProcessing" => {
          :@IgnoreBefore => "false",
          "v:UniqueID"   => { :@ID => "" },
        },

        "v:SpecialReqDetails" => {
          "v:SpecialServiceRQ" => {
            "v:SpecialServiceInfo" => {
              "v:AdvancePassenger" => {
               :@SegmentNumber => "A",
                "v:Document"   => document_advance_passenger,
                "v:PersonName" => person_name_advance_passenger,
              },
            },
          },
        },
      
        "v:TravelItineraryAddInfoRQ" => {
          "v:AgencyInfo" => {
            "v:Address"  => {
              "v:AddressLine"     => "SABRE TRAVEL",
              "v:CityName"        => "SOUTHLAKE",
              "v:CountryCode"     => "US",
              "v:PostalCode"      => "76092",     
              "v:StateCountyProv" => { :@StateCode => "TX" },
              "v:StreetNmbr"      => "3150 SABRE DRIVE", 
            },
          },
          "v:CustomerInfo" => {
            "v:ContactNumbers" => { "v:ContactNumber" => contact_number_contact_info , },
            "v:PersonName"     => person_name_contact_info,
          },
        },
      }
    
      call_response = @savon_client.call(:passenger_details_rq, soap_action: "v:PassengerDetailsRQ", attributes: operation_attributes, message: @message_body)
      
    rescue Savon::SOAPFault => error
      puts "@DEBUG #{__LINE__}    #{ap error.to_hash[:fault]}"
      
      return { status: :failed,  error: error.to_hash[:fault] }
    else
      travel_itinerary = ((call_response.body[:passenger_details_rs])[:travel_itinerary_read_rs])[:travel_itinerary]

      return { status: :success, data: travel_itinerary }
    end  
  end

end
