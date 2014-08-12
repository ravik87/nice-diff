require 'json'
require 'nokogiri'
require 'active_support/all'

module Nice
  class Parser
	def parse_to_array(context)
		raise 'Abstract method called: parse_to_array'		
	end	
  end

  class JSONParser < Parser
	def parse_to_array(context)
		context.key = 'Key'
		[JSON.parse(context.expected_file), JSON.parse(context.actual_file)]
	end
  end

  class XMLParser < Parser
	def parse_to_array(context)		
		context.key = 'Tag'
		xml1 = Nokogiri::XML(context.expected_file).to_s
		xml2 = Nokogiri::XML(context.actual_file).to_s
		[Hash.from_xml(xml1).values, Hash.from_xml(xml2).values]
	end
  end	
end
